--------------------------------------------------------
--  DDL for Trigger CZ_EXPRESSION_NODES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_EXPRESSION_NODES_T2" 
  BEFORE UPDATE OR INSERT
 ON "CZ"."CZ_EXPRESSION_NODES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW

declare
l_rule_type_33  NUMBER := 33;
l_rule_type_34  NUMBER := 34;
l_rule_type_500 NUMBER := 500;
l_rule_type_501 NUMBER := 501;
l_rule_type_502 NUMBER := 502;
l_rule_type_700 NUMBER := 700;

BEGIN
IF INSERTING THEN

  IF :new.argument_signature_id=2203 AND :new.deleted_flag='0' AND
      :new.data_value IS NOT NULL THEN

     update cz_devl_projects
     set    last_struct_update = sysdate,
            ui_timestamp_struct_update = sysdate,
            post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
     where  devl_project_id   = (SELECT devl_project_id
                                 FROM cz_rules
			    	 WHERE rule_id = :new.rule_id AND
                                 invalid_flag='0' AND disabled_flag='0' AND deleted_flag='0');
  END IF;
END IF;

UPDATE cz_devl_projects SET last_logic_update = SYSDATE,
       post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
WHERE devl_project_id =
 (SELECT devl_project_id
     FROM cz_rules
    WHERE rule_id = :new.rule_id
      AND deleted_flag='0'
      AND disabled_flag='0'
      AND rule_type NOT IN (l_rule_type_33,l_rule_type_34,
			    l_rule_type_500,l_rule_type_501,
			    l_rule_type_502, l_rule_type_700));
END;

/
ALTER TRIGGER "APPS"."CZ_EXPRESSION_NODES_T2" ENABLE;
