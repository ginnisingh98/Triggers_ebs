--------------------------------------------------------
--  DDL for Trigger CZ_ITEM_PROPERTY_VALUES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_ITEM_PROPERTY_VALUES_T2" 
  BEFORE UPDATE OR DELETE
 ON "CZ"."CZ_ITEM_PROPERTY_VALUES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
IF((DELETING AND NVL(:old.DELETED_FLAG, '0') = '0') OR
   ((NVL(:new.DELETED_FLAG, 0) <> NVL(:old.DELETED_FLAG, 0)) OR
    (NVL(:new.PROPERTY_VALUE, 0) <> NVL(:old.PROPERTY_VALUE, 0)) OR
    (NVL(:new.PROPERTY_NUM_VALUE, 0) <> NVL(:old.PROPERTY_NUM_VALUE, 0))))THEN

--This may update more models than necessary. A model may use a property of a ps_node_id not as
--the item_id's property, but as an item_type_id's property, or ps_node_id's property. However,
--it is not always possible to determine until the generation time.

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
ALTER TRIGGER "APPS"."CZ_ITEM_PROPERTY_VALUES_T2" ENABLE;
