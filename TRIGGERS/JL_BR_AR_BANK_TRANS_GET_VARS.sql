--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_BANK_TRANS_GET_VARS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_BANK_TRANS_GET_VARS" 
BEFORE INSERT ON "JL"."JL_BR_AR_RET_INTERFACE_ALL"
FOR EACH ROW
   WHEN (new.register_type <> 0
AND   ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')))) DECLARE
l_country_code   VARCHAR2(100);
BEGIN

     IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

       l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

       JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

       JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));

    END IF;

   IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

    :new.company_code := JL_BR_AR_VARIABLES.company_code;
    :new.company_name := JL_BR_AR_VARIABLES.company_name;
    :new.generation_date := JL_BR_AR_VARIABLES.generation_date;
    :new.bank_number := JL_BR_AR_VARIABLES.bank_number;

  END IF;

END;


/
ALTER TRIGGER "APPS"."JL_BR_AR_BANK_TRANS_GET_VARS" ENABLE;
