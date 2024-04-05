--------------------------------------------------------
--  DDL for Trigger XTR_BIU_MARKET_PRICES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BIU_MARKET_PRICES_T" 
 BEFORE INSERT or UPDATE on "XTR"."XTR_MARKET_PRICES"
 FOR EACH ROW
--
declare
 l_hce               NUMBER;
 l_old_base_hce_rate NUMBER;
 l_date              DATE := SYSDATE;
 l_mid_usd_rate      NUMBER;
 l_home_ccy          VARCHAR2(15);
 l_basis             VARCHAR2(1);
 l_rounding_factor   NUMBER;
 usd_hce_rate        NUMBER;
--
 cursor HOME_CCY is
   select p.PARAM_VALUE,b.USD_QUOTED_SPOT,b.DIVIDE_OR_MULTIPLY
     from XTR_PRO_PARAM p,
          XTR_MASTER_CURRENCIES b
     where p.PARAM_NAME = 'SYSTEM_FUNCTIONAL_CCY'
     and b.CURRENCY = p.PARAM_VALUE;
--
 cursor RND_FACTOR (p_currency VARCHAR2) is
  select ROUNDING_FACTOR
  from   XTR_MASTER_CURRENCIES_V
  where  CURRENCY = p_currency;
--
 l_first_ins         VARCHAR2(1);
--
 l_currency	      VARCHAR2(15);
--
--
 cursor FIRST_INS is
   select 'N'
   from   XTR_SPOT_RATES
   where  CURRENCY = 'USD';

--
begin
 -- Check if No Spot Rates exist for this currency
 -- if not found ensure at least one row is inserted before the Archive Freq
 -- takes effect
 open HOME_CCY;
 fetch HOME_CCY INTO l_home_ccy,l_old_base_hce_rate,l_basis;
 close HOME_CCY;
 if l_home_ccy ='USD' then
    l_old_base_hce_rate :=1;
 end if;
 l_first_ins := NULL;
 open FIRST_INS;
 fetch FIRST_INS INTO l_first_ins;
 if FIRST_INS%NOTFOUND then
    l_first_ins := 'Y';
    if l_home_ccy='USD' then
       update XTR_MASTER_CURRENCIES
       set    CURRENT_SPOT_RATE = 1,
              HCE_RATE = 1,
              USD_QUOTED_SPOT =1,
              SPOT_DATE = sysdate,
              RATE_DATE = sysdate
       where CURRENCY = 'USD';
       -- Insert USD 'DUMMY' Row ie this is used by USD deals to enable them to pick
       -- the HCE RATE.
       insert into xtr_spot_rates
              (currency,rate_date,bid_rate_against_usd,spread_against_usd,
               offer_rate_against_usd,usd_base_curr_bid_rate,usd_base_curr_offer_rate,
               hce_rate,unique_period_id)
       values
              ('USD',sysdate,1,0,1,1,1,1,'USD REF ROW');
    end if;
 end if;
 close FIRST_INS;
 l_first_ins := nvl(l_first_ins,'N');

 /* ================================================== */
 /* 1. Prorate Archive Details (Original Trigger Code) */
 /* ================================================== */
 if (INSERTING ----nvl(l_first_ins,'N') = 'Y'
    or ((:NEW.LAST_ARCHIVE_TIME  is NULL and :NEW.ARCHIVE_FREQ_TYPE is NOT NULL) or
    (:NEW.ARCHIVE_FREQ_TYPE = 'A') or (:NEW.LAST_ARCHIVE_TIME  is NOT NULL and
    ((:NEW.ARCHIVE_FREQ_TYPE = 'S')
    and (SYSDATE >= (:NEW.LAST_ARCHIVE_TIME + :NEW.FREQ_ARCHIVE / 60 / 60 / 24))) or
    ((:NEW.ARCHIVE_FREQ_TYPE = 'M') and (SYSDATE >= (:NEW.LAST_ARCHIVE_TIME
    + :NEW.FREQ_ARCHIVE / 60 / 24))) or ((:NEW.ARCHIVE_FREQ_TYPE = 'H')
    and (SYSDATE >= (:NEW.LAST_ARCHIVE_TIME + :NEW.FREQ_ARCHIVE / 24))) or
    ((:NEW.ARCHIVE_FREQ_TYPE = 'D') and (SYSDATE >= (:NEW.LAST_ARCHIVE_TIME + :NEW.FREQ_ARCHIVE))) or
    ((:NEW.ARCHIVE_FREQ_TYPE = 'W') and (SYSDATE >= (:NEW.LAST_ARCHIVE_TIME + :NEW.FREQ_ARCHIVE * 7))) or
    ((:NEW.ARCHIVE_FREQ_TYPE = 'T') and
    (:NEW.LAST_ARCHIVE_TIME < to_date(to_char(SYSDATE,'DD/MON/YYYY')||':'||
    lpad(to_char(:NEW.FREQ_ARCHIVE),'0',2), 'DD/MON/YYYY:HH24'))
    and (SYSDATE >= to_date(to_char(SYSDATE,'DD/MON/YYYY')||':'||
    lpad(to_char(:NEW.FREQ_ARCHIVE),'0',2), 'DD/MON/YYYY:HH24')))))) then
    :NEW.LAST_ARCHIVE_TIME := SYSDATE;

    -- Pulled out the rest of the code and placed it in archive_rates
    --  for increased modularity
    XTR_MARKET_DATA_INTERFACE_P.archive_rates(TRUE,
				:new.ask_price,
				:new.bid_price,
				:new.currency_a,
				:new.currency_b,
				:new.nos_of_days,
				:new.ric_code,
				:new.term_length,
				:new.term_type,
				:new.term_year,
				:new.last_download_time,
                                :new.day_count_basis);

 end if;             /* 1 */
end;
/
ALTER TRIGGER "APPS"."XTR_BIU_MARKET_PRICES_T" ENABLE;
