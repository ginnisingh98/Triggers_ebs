--------------------------------------------------------
--  DDL for Trigger XTR_AU_MIRROR_DDA_LIMIT_ROW_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_MIRROR_DDA_LIMIT_ROW_T" 
 AFTER UPDATE on "XTR"."XTR_MIRROR_DDA_LIMIT_ROW" FOR EACH ROW
--
declare
 l_country   VARCHAR2(100);
 l_party     VARCHAR2(7);
 l_grp_party VARCHAR2(7);
 l_dealer    VARCHAR2(10);
 l_dtype     VARCHAR2(7);
 l_product   VARCHAR2(10);
 l_dmmy      NUMBER;
 l_lim_type  VARCHAR2(7);
 l_lim_code  VARCHAR2(7);
 l_home_ccy  VARCHAR2(50);
 l_company   VARCHAR2(7);
--
 cursor GET_HOMECCY is
    select param_value
     from XTR_PRO_PARAM
     where param_name = 'SYSTEM_FUNCTIONAL_CCY';
--
 cursor GET_COUNTRY is
  select COUNTRY_CODE
   from XTR_PARTIES_V
   where PARTY_CODE = l_party;
--
 cursor GET_GROUP_DET is
  select nvl(CROSS_REF_TO_OTHER_PARTY,l_party) GROUP_PARTY
   from XTR_PARTIES_V
   where PARTY_CODE = l_party;
--
 cursor GET_TYPE is
  select LIMIT_TYPE
   from XTR_COMPANY_LIMITS
   where LIMIT_CODE = l_lim_code;
--
 cursor GET_FX_INVEST_FUND_TYPE is
  select fx_invest_fund_type
   from XTR_LIMIT_TYPES
    where limit_type=l_lim_type;
--
 cursor c_ok_to_do (pc3_param_name VARCHAR2) is
   select nvl(param_value,'Y')
    from XTR_PRO_PARAM
    where param_name = pc3_param_name;
  v_ok_to_do     VARCHAR2(2);

  l_rowid varchar2(30);

  cursor CHK_LOCK_MASTER_CURRENCIES(C_CURRENCY varchar2) is
   select rowid
     from XTR_MASTER_CURRENCIES
      where CURRENCY = C_CURRENCY
          for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_MASTER_CURRENCIES_1(C_CURRENCY varchar2) is
   select rowid
     from XTR_MASTER_CURRENCIES
	where CURRENCY = substrb(C_CURRENCY,1,instrb(C_CURRENCY,'/')-lengthb('/'))
          for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_MASTER_CURRENCIES_2(C_CURRENCY varchar2) is
   select rowid
     from XTR_MASTER_CURRENCIES
	where CURRENCY = substrb(C_CURRENCY,instrb(C_CURRENCY,'/')+lengthb('/'),lengthb(C_CURRENCY))
           for update of UTILISED_AMOUNT NOWAIT;
/*
--* bug#2920529, rravunny
  cursor CHK_LOCK_MASTER_CURRENCIES_1(C_CURRENCY varchar2) is
   select rowid
     from XTR_MASTER_CURRENCIES
    where CURRENCY = substr(C_CURRENCY,1,3)
--       and CURRENCY <> l_home_ccy
          for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_MASTER_CURRENCIES_2(C_CURRENCY varchar2) is
   select rowid
     from XTR_MASTER_CURRENCIES
      where CURRENCY = substr(C_CURRENCY,5,3)
--        and CURRENCY <> l_home_ccy
          for update of UTILISED_AMOUNT NOWAIT;
*/

  cursor CHK_LOCK_COUNTRY_LIMITS(C_COMPANY_CODE varchar2) is
   select rowid
    from XTR_COUNTRY_COMPANY_LIMITS
      where COMPANY_CODE=C_COMPANY_CODE
        and COUNTRY_CODE=l_country
           for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_COMPANY_LIMITS(C_COMPANY_CODE varchar2,
                                 C_LIMIT_CODE varchar2) is
    select rowid
     from XTR_COMPANY_LIMITS
        where COMPANY_CODE = C_COMPANY_CODE
         and LIMIT_CODE = C_LIMIT_CODE
           for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_COUNTERPARTY_LIMITS(C_COMPANY_CODE varchar2,
                                      C_LIMIT_PARTY varchar2,
                                      C_LIMIT_CODE varchar2) is
      select rowid
        from XTR_COUNTERPARTY_LIMITS
         where COMPANY_CODE = C_COMPANY_CODE
          and CPARTY_CODE = C_LIMIT_PARTY
          and LIMIT_CODE = C_LIMIT_CODE
           for update of UTILISED_AMOUNT NOWAIT;

  cursor CHK_LOCK_GROUP_LIMITS(C_COMPANY_CODE varchar2) is
   select 1
    from XTR_GROUP_LIMITS
     where COMPANY_CODE = C_COMPANY_CODE
      and (LIMIT_TYPE = nvl(l_lim_type,'X')
          or (LIMIT_TYPE='XI' and nvl(l_lim_type,'X') in('X','I')))
      and CPARTY_CODE = l_grp_party
         for update of UTILISED_AMOUNT NOWAIT;


begin
   xtr_debug_pkg.debug('Before XTR_AU_XTR_MIRROR_DDA_LIMIT_ROW_T on:'||
     to_char(sysdate,'MM:DD:HH24:MI:SS'));

--------------------------
-- Country Limits
--------------------------

if :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE
  or :OLD.LIMIT_PARTY <> :NEW.LIMIT_PARTY
  or :OLD.HCE_UTILISED_AMOUNT <> :NEW.HCE_UTILISED_AMOUNT then

 open c_ok_to_do('LIMIT_CHECK_SOVRN');
  fetch c_ok_to_do into v_ok_to_do;
 if c_ok_to_do%NOTFOUND then
  v_ok_to_do := 'Y';
 end if;
 close c_ok_to_do;
 --
 if v_ok_to_do = 'Y' then
 -- Reversal
  if :OLD.LIMIT_CODE is NOT NULL then
   l_party := :OLD.LIMIT_PARTY;
   open GET_COUNTRY;
   fetch GET_COUNTRY INTO l_country;
   if GET_COUNTRY%FOUND then
    close GET_COUNTRY;
    open CHK_LOCK_COUNTRY_LIMITS(:OLD.COMPANY_CODE);
    fetch CHK_LOCK_COUNTRY_LIMITS into l_rowid;
    if CHK_LOCK_COUNTRY_LIMITS%FOUND then
      close CHK_LOCK_COUNTRY_LIMITS;
      update XTR_COUNTRY_COMPANY_LIMITS
        set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                              nvl(:OLD.HCE_UTILISED_AMOUNT,0)
         where rowid=l_rowid;
    else
      close CHK_LOCK_COUNTRY_LIMITS;
    end if;
   else
     close GET_COUNTRY;
   end if;
  end if;

 -- New details
 if :NEW.LIMIT_CODE is NOT NULL then
   l_party := :NEW.LIMIT_PARTY;
   open GET_COUNTRY;
   fetch GET_COUNTRY INTO l_country;
   if GET_COUNTRY%FOUND then
      close GET_COUNTRY;
      open CHK_LOCK_COUNTRY_LIMITS(:NEW.COMPANY_CODE);
      fetch CHK_LOCK_COUNTRY_LIMITS into l_rowid;
      if CHK_LOCK_COUNTRY_LIMITS%FOUND then
        close CHK_LOCK_COUNTRY_LIMITS;
        update XTR_COUNTRY_COMPANY_LIMITS
        set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                              nvl(:NEW.HCE_UTILISED_AMOUNT,0)
         where rowid=l_rowid;
      else
        close CHK_LOCK_COUNTRY_LIMITS;
      end if;
    else
      close GET_COUNTRY;
    end if;
  end if;
 end if;
end if;

--------------------------
-- Global Limits
--------------------------

if :OLD.LIMIT_CODE <> :NEW.LIMIT_CODE
  or :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE
  or :OLD.HCE_UTILISED_AMOUNT <> :NEW.HCE_UTILISED_AMOUNT then

 open c_ok_to_do('LIMIT_CHECK_GLOBAL');
  fetch c_ok_to_do into v_ok_to_do;
 if c_ok_to_do%NOTFOUND then
  v_ok_to_do := 'Y';
 end if;
 close c_ok_to_do;
 --
 if v_ok_to_do = 'Y' then
 -- Reversal
  if :OLD.LIMIT_CODE is NOT NULL then
    open CHK_LOCK_COMPANY_LIMITS(:OLD.COMPANY_CODE,:OLD.LIMIT_CODE);
    fetch CHK_LOCK_COMPANY_LIMITS into l_rowid;
    if CHK_LOCK_COMPANY_LIMITS%FOUND then
      close CHK_LOCK_COMPANY_LIMITS;
     update XTR_COMPANY_LIMITS
       set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                             nvl(:OLD.HCE_UTILISED_AMOUNT,0)
        where rowid=l_rowid;
    else
      close CHK_LOCK_COMPANY_LIMITS;
    end if;
  end if;

 -- New Details
  if :NEW.LIMIT_CODE is NOT NULL then
    open CHK_LOCK_COMPANY_LIMITS(:NEW.COMPANY_CODE,:NEW.LIMIT_CODE);
    fetch CHK_LOCK_COMPANY_LIMITS into l_rowid;
    if CHK_LOCK_COMPANY_LIMITS%FOUND then
      close CHK_LOCK_COMPANY_LIMITS;
     update XTR_COMPANY_LIMITS
       set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                             nvl(:NEW.HCE_UTILISED_AMOUNT,0)
        where rowid=l_rowid;
    else
      close CHK_LOCK_COMPANY_LIMITS;
    end if;
  end if;
 end if;
end if;

--------------------------
-- Counterparty Limits
--------------------------

if :OLD.LIMIT_CODE <> :NEW.LIMIT_CODE
  or :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE
  or :OLD.HCE_UTILISED_AMOUNT <> :NEW.HCE_UTILISED_AMOUNT
  or :OLD.LIMIT_PARTY <> :NEW.LIMIT_PARTY then

 open c_ok_to_do('LIMIT_CHECK_CPARTY');
  fetch c_ok_to_do into v_ok_to_do;
 if c_ok_to_do%NOTFOUND then
  v_ok_to_do := 'Y';
 end if;
 close c_ok_to_do;
 --
 if v_ok_to_do = 'Y' then
  if :OLD.LIMIT_CODE is NOT NULL then
 -- Reversal
    open CHK_LOCK_COUNTERPARTY_LIMITS(:OLD.COMPANY_CODE,
                                      :OLD.LIMIT_PARTY,
                                      :OLD.LIMIT_CODE);
    fetch CHK_LOCK_COUNTERPARTY_LIMITS into l_rowid;
    if CHK_LOCK_COUNTERPARTY_LIMITS%FOUND then
      close CHK_LOCK_COUNTERPARTY_LIMITS;
      update XTR_COUNTERPARTY_LIMITS
         set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -
                               nvl(:OLD.HCE_UTILISED_AMOUNT,0)
         where rowid=l_rowid;
    else
      close CHK_LOCK_COUNTERPARTY_LIMITS;
    end if;
  end if;

 -- New Details
  if :NEW.LIMIT_CODE is NOT NULL then
    open CHK_LOCK_COUNTERPARTY_LIMITS(:NEW.COMPANY_CODE,
                                      :NEW.LIMIT_PARTY,
                                      :NEW.LIMIT_CODE);
    fetch CHK_LOCK_COUNTERPARTY_LIMITS into l_rowid;
    if CHK_LOCK_COUNTERPARTY_LIMITS%FOUND then
      close CHK_LOCK_COUNTERPARTY_LIMITS;
      update XTR_COUNTERPARTY_LIMITS
         set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                               nvl(:NEW.HCE_UTILISED_AMOUNT,0)
         where rowid=l_rowid;
    else
      close CHK_LOCK_COUNTERPARTY_LIMITS;
    end if;
  end if;
 end if;
end if;

--------------------------
-- Currency Limits
--------------------------

if nvl(:OLD.CURRENCY,'@#@') <>nvl(:NEW.CURRENCY,'@#@')
  or :OLD.HCE_UTILISED_AMOUNT <> :NEW.HCE_UTILISED_AMOUNT
  or nvl(:OLD.CURRENCY_COMBINATION,'@#@') <>nvl(:NEW.CURRENCY_COMBINATION,'@#@')
 then
 open c_ok_to_do('LIMIT_CHECK_CCY');
  fetch c_ok_to_do into v_ok_to_do;
 if c_ok_to_do%NOTFOUND then
  v_ok_to_do := 'Y';
 end if;
 close c_ok_to_do;
 --
 if v_ok_to_do = 'Y' then
  if :OLD.LIMIT_CODE is NOT NULL then
 -- Reversal
  l_company := :OLD.COMPANY_CODE;
  open GET_HOMECCY;
   fetch GET_HOMECCY INTO l_home_ccy;
  close GET_HOMECCY;

  if :OLD.CURRENCY_COMBINATION is NOT NULL then
   open CHK_LOCK_MASTER_CURRENCIES_1(:OLD.CURRENCY_COMBINATION);
   fetch CHK_LOCK_MASTER_CURRENCIES_1 into l_rowid;
   if CHK_LOCK_MASTER_CURRENCIES_1%FOUND then
     close CHK_LOCK_MASTER_CURRENCIES_1;
     update XTR_MASTER_CURRENCIES
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                            nvl(:OLD.HCE_UTILISED_AMOUNT,0)
      where rowid=l_rowid;
   else
     close CHK_LOCK_MASTER_CURRENCIES_1;
   end if;

   open CHK_LOCK_MASTER_CURRENCIES_2(:OLD.CURRENCY_COMBINATION);
   fetch CHK_LOCK_MASTER_CURRENCIES_2 into l_rowid;
   if CHK_LOCK_MASTER_CURRENCIES_2%FOUND then
     close CHK_LOCK_MASTER_CURRENCIES_2;
     update XTR_MASTER_CURRENCIES
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                            nvl(:OLD.HCE_UTILISED_AMOUNT,0)
      where rowid=l_rowid;
   else
     close CHK_LOCK_MASTER_CURRENCIES_2;
   end if;
--* bug#2920529, rravunny end if;

else --* bug#2920529, rravunny

--  bug 1289530 elsif :OLD.CURRENCY <> l_home_ccy then
   open CHK_LOCK_MASTER_CURRENCIES(:OLD.CURRENCY);
   fetch CHK_LOCK_MASTER_CURRENCIES into l_rowid;
   if CHK_LOCK_MASTER_CURRENCIES%FOUND then
    close CHK_LOCK_MASTER_CURRENCIES;
    update XTR_MASTER_CURRENCIES
    set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                          nvl(:OLD.HCE_UTILISED_AMOUNT,0)
    where rowid = l_rowid;
   else
    close CHK_LOCK_MASTER_CURRENCIES;
   end if;
--  bug 1289530 end if;
  end if; --* bug#2920529, rravunny
 end if;

 -- New Details
  if :NEW.LIMIT_CODE is NOT NULL then
  l_company := :NEW.COMPANY_CODE;
  open GET_HOMECCY;
   fetch GET_HOMECCY INTO l_home_ccy;
  close GET_HOMECCY;
  if :NEW.CURRENCY_COMBINATION is NOT NULL then
   open CHK_LOCK_MASTER_CURRENCIES_1(:NEW.CURRENCY_COMBINATION);
   fetch CHK_LOCK_MASTER_CURRENCIES_1 into l_rowid;
   if CHK_LOCK_MASTER_CURRENCIES_1%FOUND then
     close CHK_LOCK_MASTER_CURRENCIES_1;
     update XTR_MASTER_CURRENCIES
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                            nvl(:NEW.HCE_UTILISED_AMOUNT,0)
      where rowid=l_rowid;
   else
     close CHK_LOCK_MASTER_CURRENCIES_1;
   end if;

   open CHK_LOCK_MASTER_CURRENCIES_2(:NEW.CURRENCY_COMBINATION);
   fetch CHK_LOCK_MASTER_CURRENCIES_2 into l_rowid;
   if CHK_LOCK_MASTER_CURRENCIES_2%FOUND then
     close CHK_LOCK_MASTER_CURRENCIES_2;
     update XTR_MASTER_CURRENCIES
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                            nvl(:NEW.HCE_UTILISED_AMOUNT,0)
      where rowid=l_rowid;
   else
     close CHK_LOCK_MASTER_CURRENCIES_2;
   end if;

--  bug 1289530  elsif :NEW.CURRENCY <> l_home_ccy then

else --* bug#2920529, rravunny

  --* bug#2920529, rravunny end if;
   open CHK_LOCK_MASTER_CURRENCIES(:NEW.CURRENCY);
   fetch CHK_LOCK_MASTER_CURRENCIES into l_rowid;
    if CHK_LOCK_MASTER_CURRENCIES%FOUND then
     close CHK_LOCK_MASTER_CURRENCIES;
     update XTR_MASTER_CURRENCIES
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                          nvl(:NEW.HCE_UTILISED_AMOUNT,0)
     where rowid = l_rowid;
    else
     close CHK_LOCK_MASTER_CURRENCIES;
--  bug 1289530  end if;
    end if; --* bug#2920529, rravunny
   end if;
  end if;
 end if;
end if;

--------------------------
-- Group Limits
--------------------------

if :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE
  or :OLD.LIMIT_PARTY <> :NEW.LIMIT_PARTY
  or :OLD.HCE_UTILISED_AMOUNT <> :NEW.HCE_UTILISED_AMOUNT
  or :OLD.AMOUNT <> :NEW.AMOUNT then
 open c_ok_to_do('LIMIT_CHECK_GROUP');
  fetch c_ok_to_do into v_ok_to_do;
 if c_ok_to_do%NOTFOUND then
  v_ok_to_do := 'Y';
 end if;
 close c_ok_to_do;
 --
if v_ok_to_do = 'Y' then
 -- Reversal
 if :OLD.LIMIT_CODE is NOT NULL then
  l_lim_code := :OLD.LIMIT_CODE;
  if :OLD.LIMIT_TYPE is NULL then
   open GET_TYPE;
   fetch GET_TYPE INTO l_lim_type;
   close GET_TYPE;
  else
    l_lim_type := :OLD.LIMIT_TYPE;
  end if;

  open GET_FX_INVEST_FUND_TYPE;
  fetch GET_FX_INVEST_FUND_TYPE into l_lim_type;
  close GET_FX_INVEST_FUND_TYPE;

  l_party := :OLD.LIMIT_PARTY;
  open GET_GROUP_DET;
  fetch GET_GROUP_DET INTO l_grp_party;
  close GET_GROUP_DET;


  open CHK_LOCK_GROUP_LIMITS(:OLD.COMPANY_CODE);
  fetch CHK_LOCK_GROUP_LIMITS into l_dmmy;
  if CHK_LOCK_GROUP_LIMITS%FOUND then
    close CHK_LOCK_GROUP_LIMITS;
    update XTR_GROUP_LIMITS
      set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) -        -- Bug 2229236 should be '-' not '+'
                             nvl(:OLD.HCE_UTILISED_AMOUNT,0)
      where COMPANY_CODE = :OLD.COMPANY_CODE
       and (LIMIT_TYPE = nvl(l_lim_type,'X')
           or (LIMIT_TYPE='XI' and nvl(l_lim_type,'X') in('X','I')))
      and CPARTY_CODE = l_grp_party;
  else
    close CHK_LOCK_GROUP_LIMITS;
  end if;
 end if;


 -- New details
 if :NEW.LIMIT_CODE is NOT NULL then
 l_lim_code := :NEW.LIMIT_CODE;
 if :NEW.LIMIT_TYPE is NULL then
  open GET_TYPE;
   fetch GET_TYPE INTO l_lim_type;
  close GET_TYPE;
 else
  l_lim_type := :NEW.LIMIT_TYPE;
 end if;

 open GET_FX_INVEST_FUND_TYPE;
 fetch GET_FX_INVEST_FUND_TYPE into l_lim_type;
 close GET_FX_INVEST_FUND_TYPE;

 l_party := :NEW.LIMIT_PARTY;

 open GET_GROUP_DET;
 fetch GET_GROUP_DET INTO l_grp_party;
 close GET_GROUP_DET;

   open CHK_LOCK_GROUP_LIMITS(:NEW.COMPANY_CODE);
   fetch CHK_LOCK_GROUP_LIMITS into l_dmmy;
   if CHK_LOCK_GROUP_LIMITS%FOUND then
    close CHK_LOCK_GROUP_LIMITS;
    update XTR_GROUP_LIMITS
       set UTILISED_AMOUNT = nvl(UTILISED_AMOUNT,0) +
                             nvl(:NEW.HCE_UTILISED_AMOUNT,0)
      where COMPANY_CODE = :NEW.COMPANY_CODE
       and (LIMIT_TYPE = nvl(l_lim_type,'X')
           or (LIMIT_TYPE='XI' and nvl(l_lim_type,'X') in('X','I')))
      and CPARTY_CODE = l_grp_party;
   else
     close CHK_LOCK_GROUP_LIMITS;
   end if;
  end if;
 end if;
end if;

xtr_debug_pkg.debug('After XTR_AU_XTR_MIRROR_DDA_LIMIT_ROW_T on:'||
  to_char(sysdate,'MM:DD:HH24:MI:SS'));
--
exception
 when app_exceptions.RECORD_LOCK_EXCEPTION then
  if CHK_LOCK_MASTER_CURRENCIES%ISOPEN then
     close  CHK_LOCK_MASTER_CURRENCIES;
  end if;

  if CHK_LOCK_MASTER_CURRENCIES_1%ISOPEN then
     close  CHK_LOCK_MASTER_CURRENCIES_1;
  end if;

  if CHK_LOCK_MASTER_CURRENCIES_2%ISOPEN then
     close  CHK_LOCK_MASTER_CURRENCIES_2;
  end if;

  if CHK_LOCK_COUNTRY_LIMITS%ISOPEN then
     close CHK_LOCK_COUNTRY_LIMITS;
  end if;

  if CHK_LOCK_COMPANY_LIMITS%ISOPEN then
     close CHK_LOCK_COMPANY_LIMITS;
  end if;

  if CHK_LOCK_COUNTERPARTY_LIMITS%ISOPEN then
     close CHK_LOCK_COUNTERPARTY_LIMITS;
  end if;

  if CHK_LOCK_GROUP_LIMITS%ISOPEN then
     close CHK_LOCK_GROUP_LIMITS;
  end if;

  raise app_exceptions.RECORD_LOCK_EXCEPTION;
--
end;
/
ALTER TRIGGER "APPS"."XTR_AU_MIRROR_DDA_LIMIT_ROW_T" ENABLE;
