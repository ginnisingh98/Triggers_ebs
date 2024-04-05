--------------------------------------------------------
--  DDL for Trigger CZ_RULES_TP1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_RULES_TP1" 
BEFORE INSERT
ON "CZ"."CZ_RULES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE

  v_persistent_id   cz_rules.persistent_rule_id%TYPE;

BEGIN
  IF :NEW.PERSISTENT_RULE_ID IS NULL THEN
   :new.PERSISTENT_RULE_ID:=:new.RULE_ID;
  END IF;

  v_persistent_id := :new.PERSISTENT_RULE_ID;
  cz_model_migration_pvt.allocate_persistent_id(:new.DEVL_PROJECT_ID, v_persistent_id);
  :new.PERSISTENT_RULE_ID := v_persistent_id;
END;

/
ALTER TRIGGER "APPS"."CZ_RULES_TP1" ENABLE;
