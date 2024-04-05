--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_PAYMENT_SCH_GBL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_PAYMENT_SCH_GBL" 
BEFORE INSERT ON "AR"."AR_PAYMENT_SCHEDULES_ALL"
FOR EACH ROW
   WHEN ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX'))) DECLARE
l_country_code    VARCHAR2(100);
BEGIN

    IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));

    END IF;

   IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    IF :new.customer_trx_id is not NULL THEN

      :new.global_attribute11 := 'N';
      :new.global_attribute9 := 'MANUAL_RECEIPT';
      :new.global_attribute_category := 'JL.BR.ARXTWMAI.Additional';

      SELECT receipt_method_id
      INTO   :new.global_attribute8
      FROM   ra_customer_trx
      WHERE  customer_trx_id = :new.customer_trx_id;

    END IF;

   END IF;

END;


/
ALTER TRIGGER "APPS"."JL_BR_AR_PAYMENT_SCH_GBL" ENABLE;
