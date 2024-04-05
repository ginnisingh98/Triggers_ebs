--------------------------------------------------------
--  DDL for Trigger CZ_PROPERTIES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PROPERTIES_T3" 
  BEFORE UPDATE OR DELETE
 ON "CZ"."CZ_PROPERTIES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
IF((DELETING AND NVL(:old.DELETED_FLAG, '0') = '0') OR
   ((NVL(:new.DELETED_FLAG, 0) <> NVL(:old.DELETED_FLAG, 0)) OR
    (NVL(:new.DATA_TYPE, 0) <> NVL(:old.DATA_TYPE, 0)) OR
    (NVL(:new.DEF_VALUE, 0) <> NVL(:old.DEF_VALUE, 0)) OR
    (NVL(:new.DEF_NUM_VALUE, 0) <> NVL(:old.DEF_NUM_VALUE, 0))))THEN

--This may update more models than necessary. For example, if only default value has changed,
--we need to update only the models that use the property through its default value (through
--the item type of the ps_node_id's item_id). However it is not always possible to establish
--that (e.g. properties applied to an iterator with no ps_node_id until the generation time).

UPDATE cz_devl_projects SET last_logic_update = SYSDATE,
       post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
 WHERE deleted_flag = '0'
   AND devl_project_id IN (
    SELECT devl_project_id FROM cz_rules
     WHERE deleted_flag = '0'
       AND disabled_flag = '0'
       AND rule_id IN (
        SELECT rule_id FROM cz_expression_nodes
         WHERE deleted_flag = '0'
           AND expr_type = 207
           AND property_id = :old.property_id
       )
   );
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PROPERTIES_T3" ENABLE;
