--------------------------------------------------------
--  DDL for Trigger XTR_AU_MASTER_CURRENCIES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_MASTER_CURRENCIES_T" 
 AFTER UPDATE on "XTR"."XTR_MASTER_CURRENCIES"
 FOR EACH ROW
  WHEN ( nvl(new.CURRENCY, 		'@#@') <> nvl(old.CURRENCY, 		'@#@') OR
        nvl(new.NAME, 			'@#@') <> nvl(old.NAME, 		'@#@') OR
        nvl(new.AUTHORISED, 		'@#@') <> nvl(old.AUTHORISED, 		'@#@') OR
        nvl(new.DIVIDE_OR_MULTIPLY, 	'@#@') <> nvl(old.DIVIDE_OR_MULTIPLY, 	'@#@') OR
        nvl(new.YEAR_BASIS , 		-999 ) <> nvl(old.YEAR_BASIS , 		-999 ) OR
        nvl(new.CREATED_BY , 		'@#@') <> nvl(old.CREATED_BY , 		'@#@') OR
        nvl(new.CREATED_ON , 	 sysdate + 1 ) <> nvl(old.CREATED_ON ,   sysdate + 1 ) OR
        nvl(new.MINIMUM_BAND , 		-999 ) <> nvl(old.MINIMUM_BAND , 	-999 ) OR
        nvl(new.MAXIMUM_BAND , 		-999 ) <> nvl(old.MAXIMUM_BAND , 	-999 ) OR
        nvl(new.IR_SEQ_NO , 		-999 ) <> nvl(old.IR_SEQ_NO , 		-999 ) OR
        nvl(new.FX_SEQ_NO , 		-999 ) <> nvl(old.FX_SEQ_NO , 		-999 ) OR
        nvl(new.NET_FX_EXPOSURE , 	-999 ) <> nvl(old.NET_FX_EXPOSURE , 	-999 ) OR
        nvl(new.MAX_DAYS_CONTRACT , 	-999 ) <> nvl(old.MAX_DAYS_CONTRACT , 	-999 ) OR
        nvl(new.AUDIT_INDICATOR , 	'@#@') <> nvl(old.AUDIT_INDICATOR , 	'@#@') ) declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'CURRENCIES SETUP';
 --
 l_val VARCHAR2(1);
 --
begin
 -- Check that Audit on this table has been specified
 open CHK_AUDIT;
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;
 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_MASTER_CURRENCIES(
      CURRENCY, NAME, AUTHORISED, DIVIDE_OR_MULTIPLY,
      YEAR_BASIS, CREATED_BY,
      CREATED_ON, UPDATED_BY, UPDATED_ON, MINIMUM_BAND,
      MAXIMUM_BAND, IR_SEQ_NO, FX_SEQ_NO,
      NET_FX_EXPOSURE, MAX_DAYS_CONTRACT, AUDIT_INDICATOR,
      CALCULATE_HOLS_YEARS, AUDIT_DATE_STORED
      ) VALUES (
      :old.CURRENCY, :old.NAME, :old.AUTHORISED, :old.DIVIDE_OR_MULTIPLY,
      :old.YEAR_BASIS, :old.CREATED_BY,
      :old.CREATED_ON, :old.UPDATED_BY, sysdate, :old.MINIMUM_BAND,
      :old.MAXIMUM_BAND, :old.IR_SEQ_NO, :old.FX_SEQ_NO,
      :old.NET_FX_EXPOSURE, :old.MAX_DAYS_CONTRACT, :old.AUDIT_INDICATOR,
      :old.CALCULATE_HOLS_YEARS,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_MASTER_CURRENCIES_T" ENABLE;
