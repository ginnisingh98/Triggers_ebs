--------------------------------------------------------
--  DDL for Trigger CZ_RULES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_RULES_T2" 
BEFORE UPDATE OR INSERT OR DELETE
ON "CZ"."CZ_RULES"
REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW


BEGIN


IF UPDATING THEN
   IF ( ( NVL(:new.INVALID_FLAG,'0')<>NVL(:old.INVALID_FLAG,'0') )
	OR ( NVL(:new.DISABLED_FLAG,'0')<>NVL(:old.DISABLED_FLAG,'0') )
        OR ( NVL(:new.DELETED_FLAG,'0')<>NVL(:old.DELETED_FLAG,'0') ) ) AND
      :new.rule_type = 300 THEN
     -- for on command cx rule only
     FOR i IN (SELECT 1 FROM cz_expression_nodes
               WHERE rule_id = :old.rule_id AND :old.deleted_flag = '0'
               AND expr_parent_id IS NULL AND argument_signature_id = 2203
               AND rownum < 2) LOOP

	 -- jonatara: bugfix 8529418
 	IF NVL(:new.DISABLED_FLAG,'0') = 0 AND NVL(:new.DELETED_FLAG,'0') = 0 THEN
	       UPDATE cz_devl_projects
	       SET last_struct_update = sysdate,
        	   ui_timestamp_struct_update = sysdate,
        	   post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
       		WHERE devl_project_id = :old.devl_project_id;
     	ELSE
		UPDATE cz_devl_projects
		SET ui_timestamp_struct_update = sysdate,
        	    post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
		WHERE devl_project_id = :old.devl_project_id;
	END IF;

     END LOOP;
   END IF;
END IF;

IF (:new.rule_type NOT IN (33, 34, 500, 501, 502, 700) AND (
    NVL(:new.CLASS_NAME, '0') <> NVL(:old.CLASS_NAME, '0') OR
    NVL(:new.COMPONENT_ID, 0) <> NVL(:old.COMPONENT_ID, 0) OR
    NVL(:new.MODEL_REF_EXPL_ID, 0) <> NVL(:old.MODEL_REF_EXPL_ID, 0) OR
    NVL(:new.REASON_ID, 0) <> NVL(:old.REASON_ID, 0) OR
    NVL(:new.INVALID_FLAG, '0') <> NVL(:old.INVALID_FLAG, '0') OR
    NVL(:new.UNSATISFIED_MSG_ID, 0) <> NVL(:old.UNSATISFIED_MSG_ID, 0) OR

    --RULE_TEXT is a CLOB that requires special handling on 8i.
    --If the RULE_TEXT is changes, parser is supposed to be called and so the change will propagate from
    --cz_expression_nodes to last_logic_update. Therefore, RULE_TEXT can be skipped here.

    --NVL(:new.RULE_TEXT, '0') <> NVL(:old.RULE_TEXT, '0') OR
    NVL(:new.EFFECTIVE_USAGE_MASK, '0') <> NVL(:old.EFFECTIVE_USAGE_MASK, '0') OR
    NVL(:new.EFFECTIVE_FROM, TO_DATE(1000, 'YYYY')) <> NVL(:old.EFFECTIVE_FROM, TO_DATE(1000, 'YYYY')) OR
    NVL(:new.EFFECTIVE_UNTIL, TO_DATE(1000, 'YYYY')) <> NVL(:old.EFFECTIVE_UNTIL, TO_DATE(1000, 'YYYY')) OR
    (NVL(:new.DELETED_FLAG, '0') <> NVL(:old.DELETED_FLAG, '0') AND
    (:new.rule_type <> 300 OR :new.DELETED_FLAG = '0')) OR
    (NVL(:new.DISABLED_FLAG, '0') <> NVL(:old.DISABLED_FLAG, '0') AND
    (:new.rule_type <> 300 OR :new.DISABLED_FLAG = '0'))
   )) THEN

   --Bug #4920028. If deleted_flag = '1', we are purging a logically deleted record.

   IF(NVL(:old.deleted_flag, '0') = '0')THEN

     UPDATE cz_devl_projects
     SET last_logic_update = sysdate,
         post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
     WHERE devl_project_id = NVL(:old.devl_project_id, :new.devl_project_id);
   END IF;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_RULES_T2" ENABLE;
