--------------------------------------------------------
--  DDL for Trigger CZ_RULES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_RULES_T3" 
BEFORE UPDATE OR INSERT
ON "CZ"."CZ_RULES"
REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW

DECLARE

  l_id NUMBER;

BEGIN

IF (UPDATING OR INSERTING) AND :new.ui_def_id IS NOT NULL AND :new.deleted_flag='0' THEN

  IF :new.ui_def_id > 1  THEN

    BEGIN
      SELECT ui_def_id INTO l_id FROM CZ_UI_DEFS
       WHERE ui_def_id=:new.ui_def_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(-20110, 'Exception for Rule with rule_id='|| :new.rule_id ||
          ' : UI with ui_def_id='||:new.ui_def_id||' does not exist.');
    END;

    IF NVL(:new.ui_page_id,0) > 0 THEN
      BEGIN
        SELECT page_id INTO l_id FROM CZ_UI_PAGES
         WHERE page_id=:new.ui_page_id AND ui_def_id=:new.ui_def_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          raise_application_error(-20111, 'Exception for Rule with rule_id='|| :new.rule_id ||' : UI Page with page_id='||:new.ui_page_id||' and ui_def_id='|| :new.ui_def_id ||' does not exist.');
      END;
    END IF;

  ELSIF :new.ui_def_id IN(0,1) AND NVL(:new.ui_page_id,0) > 0 THEN

    BEGIN
      SELECT template_id INTO l_id FROM CZ_UI_TEMPLATES
       WHERE template_id=:new.ui_page_id AND ui_def_id=:new.ui_def_id;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
         raise_application_error(-20112, 'Exception for Rule with rule_id='|| :new.rule_id ||
            ' : UI Template with template_id='||:new.ui_page_id||' and ui_def_id='|| :new.ui_def_id ||' does not exist.');
    END;

  END IF;

END IF;

END;

/
ALTER TRIGGER "APPS"."CZ_RULES_T3" ENABLE;
