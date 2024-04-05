--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_T2" 
  BEFORE INSERT OR DELETE OR UPDATE OF
     initial_value,
     initial_num_value,
     parent_id,
     minimum,
     maximum,
     ps_node_type,
     feature_type,
     bom_required_flag,
     minimum_selected,
     maximum_selected,
     decimal_qty_flag,
     deleted_flag,
     virtual_flag,
     ib_trackable,
     effective_from,
     effective_until,
     counted_options_flag,
     max_qty_per_option,
     effectivity_set_id,
     domain_order
 ON "CZ"."CZ_PS_NODES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN

 --Bug #4920028. If deleted_flag = '1', we are purging a logically deleted record.

 IF DELETING AND NVL(:old.deleted_flag, '0') = '0' THEN
   UPDATE CZ_DEVL_PROJECTS SET
     LAST_STRUCT_UPDATE=SYSDATE,
     LAST_LOGIC_UPDATE=SYSDATE,
     post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
   WHERE
     DEVL_PROJECT_ID=:old.DEVL_PROJECT_ID;
 END IF;
 IF INSERTING OR (UPDATING AND (
      (((:old.parent_id IS NULL)<>(:new.parent_id IS NULL))OR(:old.parent_id<>:new.parent_id)) OR
      (((:old.minimum IS NULL)<>(:new.minimum IS NULL))OR(:old.minimum<>:new.minimum)) OR
      (((:old.maximum IS NULL)<>(:new.maximum IS NULL))OR(:old.maximum<>:new.maximum)) OR
      (((:old.ps_node_type IS NULL)<>(:new.ps_node_type IS NULL))OR(:old.ps_node_type<>:new.ps_node_type
         AND (:old.ps_node_type <> 258 OR :new.ps_node_type <> 259))) OR -- no update if upgrade prd to comp
      (((:old.feature_type IS NULL)<>(:new.feature_type IS NULL))OR(:old.feature_type<>:new.feature_type)) OR
      (((:old.minimum_selected IS NULL)<>(:new.minimum_selected IS NULL))OR(:old.minimum_selected<>:new.minimum_selected)) OR
      (((:old.maximum_selected IS NULL)<>(:new.maximum_selected IS NULL))OR(:old.maximum_selected<>:new.maximum_selected)) OR
      (((:old.virtual_flag IS NULL)<>(:new.virtual_flag IS NULL))OR(:old.virtual_flag<>:new.virtual_flag)) OR
      (((:old.deleted_flag IS NULL)<>(:new.deleted_flag IS NULL))OR(:old.deleted_flag<>:new.deleted_flag)) OR
      (((:old.domain_order IS NULL)<>(:new.domain_order IS NULL))OR(:old.domain_order<>:new.domain_order)) OR
      (((:old.counted_options_flag IS NULL)<>(:new.counted_options_flag IS NULL))OR(:old.counted_options_flag<>:new.counted_options_flag)) OR
      (((:old.max_qty_per_option IS NULL)<>(:new.max_qty_per_option IS NULL))OR(:old.max_qty_per_option<>:new.max_qty_per_option)) OR
      (((:old.effectivity_set_id IS NULL)<>(:new.effectivity_set_id IS NULL))OR(:old.effectivity_set_id<>:new.effectivity_set_id))
     )) THEN
       UPDATE CZ_DEVL_PROJECTS SET
         LAST_STRUCT_UPDATE=SYSDATE,
         LAST_LOGIC_UPDATE=SYSDATE,
         post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
       WHERE
         DEVL_PROJECT_ID=:new.DEVL_PROJECT_ID;
   END IF;

   IF (UPDATING AND (
      (((:old.decimal_qty_flag IS NULL)<>(:new.decimal_qty_flag IS NULL)) OR
       (:old.decimal_qty_flag<>:new.decimal_qty_flag)) OR
      (((:old.domain_order IS NULL)<>(:new.domain_order IS NULL)) OR
       (:old.domain_order<>:new.domain_order)) OR
      (((:old.initial_value IS NULL)<>(:new.initial_value IS NULL)) OR
       (:old.initial_value<>:new.initial_value)) OR
      (((:old.initial_num_value IS NULL)<>(:new.initial_num_value IS NULL)) OR
       (:old.initial_num_value<>:new.initial_num_value)) OR
      (((:old.ib_trackable IS NULL)<>(:new.ib_trackable IS NULL)) OR
       (:old.ib_trackable<>:new.ib_trackable)) OR
      (((:old.bom_required_flag IS NULL)<>(:new.bom_required_flag IS NULL)) OR
       (:old.bom_required_flag<>:new.bom_required_flag)) OR
       (((:old.effective_from IS NULL)<>(:new.effective_from IS NULL)) OR
        (:old.effective_from<>:new.effective_from)) OR
       (((:old.effective_until IS NULL)<>(:new.effective_until IS NULL)) OR
        (:old.effective_until<>:new.effective_until))
                    )
      ) THEN
         UPDATE CZ_DEVL_PROJECTS SET
         LAST_LOGIC_UPDATE=SYSDATE,
         post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
       WHERE
         DEVL_PROJECT_ID=:new.DEVL_PROJECT_ID;
   END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_T2" ENABLE;
