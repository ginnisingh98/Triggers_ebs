--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_AUTO_INT_PARAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_AUTO_INT_PARAM" 
BEFORE INSERT
ON "AR"."RA_CUSTOMER_TRX_ALL"
FOR EACH ROW
   WHEN (new.created_from = 'RAXTRX'
AND   ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')))) DECLARE
   l_interest_type     VARCHAR2(15);
   l_interest_rate_amt NUMBER;
   l_interest_period   NUMBER;
   l_interest_formula  VARCHAR2(30);
   l_interest_grace    NUMBER;
   l_penalty_type      VARCHAR2(15);
   l_penalty_rate_amt  NUMBER;
   l_country_code      VARCHAR2(100);

BEGIN

        IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

        l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

        JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

        JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));

       END IF;

   IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    IF :new.global_attribute_category IS NOT NULL THEN
     IF :new.global_attribute1 IS NULL and :new.global_attribute2 IS NULL and
        :new.global_attribute3 IS NULL and :new.global_attribute4 IS NULL and
        :new.global_attribute5 IS NULL and :new.global_attribute6 IS NULL and
        :new.global_attribute7 IS NULL THEN

       select acpc.global_attribute3,
              fnd_number.canonical_to_number(acpc.global_attribute4),--Bug 3107496
              to_number(acpc.global_attribute5),
              acpc.global_attribute6,
              fnd_number.canonical_to_number(acpc.global_attribute7),
              acpc.global_attribute8,
              fnd_number.canonical_to_number(acpc.global_attribute9)  --Bug 3107496
         into l_interest_type,
              l_interest_rate_amt,
              l_interest_period,
              l_interest_formula,
              l_interest_grace,
              l_penalty_type,
              l_penalty_rate_amt
        from  hz_cust_profile_classes acpc,
              hz_customer_profiles acp
       where  acp.cust_account_id = :new.bill_to_customer_id
         and  acp.profile_class_id = acpc.profile_class_id
         and acp.site_use_id is null;

       :new.global_attribute1 :=  l_interest_type;
       :new.global_attribute2 :=  to_char(l_interest_rate_amt);
       :new.global_attribute3 :=  to_char(l_interest_period);
       :new.global_attribute4 :=  l_interest_formula;
       :new.global_attribute5 :=  to_char(l_interest_grace);
       :new.global_attribute6 :=  l_penalty_type;
       :new.global_attribute7 :=  to_char(l_penalty_rate_amt);

    END IF;
   END IF;
   END IF;

EXCEPTION WHEN OTHERS THEN
  NULL;

END;


/
ALTER TRIGGER "APPS"."JL_BR_AR_AUTO_INT_PARAM" ENABLE;
