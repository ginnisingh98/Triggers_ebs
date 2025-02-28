--------------------------------------------------------
--  DDL for Trigger XTR_BU_INTERACCT_TRANSFERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BU_INTERACCT_TRANSFERS_T" 
	 BEFORE UPDATE on "XTR"."XTR_INTERACCT_TRANSFERS"
	 FOR EACH ROW
declare
   cursor CHK_LOCK_DEAL_DATE_AMOUNTS is
   select 1 num
   from XTR_DEAL_DATE_AMOUNTS
   where DEAL_TYPE = :NEW.DEAL_TYPE
   and TRANSACTION_NUMBER = :NEW.TRANSACTION_NUMBER
   for update of DUAL_AUTHORISATION_BY NOWAIT;

   l_dummy NUMBER;

begin
 if nvl(:NEW.DUAL_AUTHORISATION_BY,'-1') <>
   nvl(:OLD.DUAL_AUTHORISATION_BY,'-1') then

  open CHK_LOCK_DEAL_DATE_AMOUNTS;
  fetch CHK_LOCK_DEAL_DATE_AMOUNTS into l_dummy;

  if CHK_LOCK_DEAL_DATE_AMOUNTS%FOUND  then
    close CHK_LOCK_DEAL_DATE_AMOUNTS;
    update XTR_DEAL_DATE_AMOUNTS
    set DUAL_AUTHORISATION_ON = :NEW.DUAL_AUTHORISATION_ON,
	DUAL_AUTHORISATION_BY = :NEW.DUAL_AUTHORISATION_BY
    where DEAL_TYPE = :NEW.DEAL_TYPE
    and TRANSACTION_NUMBER = :NEW.TRANSACTION_NUMBER;
  else
    close CHK_LOCK_DEAL_DATE_AMOUNTS;
  end if;
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_BU_INTERACCT_TRANSFERS_T" ENABLE;
