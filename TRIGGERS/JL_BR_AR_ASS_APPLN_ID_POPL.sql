--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_ASS_APPLN_ID_POPL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_ASS_APPLN_ID_POPL" 
AFTER INSERT ON "AR"."AR_RECEIVABLE_APPLICATIONS_ALL"
FOR EACH ROW
  WHEN (new.status = 'APP'
AND   ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')))) declare
 l_country_code VARCHAR2(100);
/* bug 8763035 - obsoleting cursor
  cursor c_adj is
    select adjustment_id
      from ar_adjustments
      where associated_cash_receipt_id = :NEW.cash_receipt_id
        and associated_application_id IS NULL;
 --
  adj_rec  c_adj%ROWTYPE;
 --
*/
 begin

        IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));


       END IF;

 IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN
/* Bug 8763035 - obsoleting old logic
  open c_adj;
  loop
      fetch c_adj into adj_rec;
  EXIT when c_adj%NOTFOUND;
      update ar_adjustments
        set associated_application_id = :NEW.receivable_application_id WHERE adjustment_id = adj_rec.adjustment_id;

  end loop;
  close c_adj;
*/
      update ar_adjustments
         set associated_application_id = :NEW.receivable_application_id
       where associated_cash_receipt_id = :NEW.cash_receipt_id
         and payment_schedule_id = :NEW.applied_payment_schedule_id;
 END IF;
 end jl_br_ar_ass_appln_id_popl;

/
ALTER TRIGGER "APPS"."JL_BR_AR_ASS_APPLN_ID_POPL" ENABLE;
