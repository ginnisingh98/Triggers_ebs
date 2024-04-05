--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_T5
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_T5" 
  BEFORE INSERT OR UPDATE OF
    parent_id,
    minimum,
    maximum,
    counted_options_flag,
    deleted_flag,
    instantiable_flag,
    ui_omit
  ON "CZ"."CZ_PS_NODES"
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE
  l_update_devl_project BOOLEAN;
  l_count NUMBER;
BEGIN
  l_update_devl_project := FALSE;

  -- time stamp add
  IF INSERTING THEN
    IF :new.UI_TIMESTAMP_ADD IS NULL THEN
      :new.UI_TIMESTAMP_ADD:=SYSDATE;
      l_update_devl_project := TRUE;
    END IF;
  END IF;

  -- time stamp add
  IF UPDATING AND (:old.ui_omit='1' AND :new.ui_omit='0') THEN
    :new.UI_TIMESTAMP_ADD:=SYSDATE;
    l_update_devl_project := TRUE;
  END IF;

  -- time stamp remove
  IF UPDATING AND (
          (:old.deleted_flag<>:new.deleted_flag) OR
          (:old.ui_omit='0' AND :new.ui_omit='1')) THEN
    :new.UI_TIMESTAMP_REMOVE:=SYSDATE;
    l_update_devl_project := TRUE;
  END IF;

  -- time stamp move
  IF UPDATING AND (:old.parent_id<>:new.parent_id) THEN
    :new.UI_TIMESTAMP_MOVE:=SYSDATE;
    l_update_devl_project := TRUE;
  END IF;

  -- time stamp changetype
  IF UPDATING THEN

     -- time stamp reorder FP Bug 5926323
    IF (:old.tree_seq<>:new.tree_seq) THEN
      :new.UI_TIMESTAMP_REORDER := SYSDATE;
      l_update_devl_project := TRUE;
    END IF;

    IF :new.ps_node_type = CZ_TYPES.PS_NODE_TYPE_FEATURE
      AND :new.feature_type = 0
      AND ( ((:old.maximum IS NULL)<>(:new.maximum IS NULL))
            OR(:old.maximum = 1 AND :new.maximum <> 1)
            OR (:old.maximum <> 1 AND :new.maximum = 1)
            OR ( :old.counted_options_flag IN ('0', 'N') AND :new.counted_options_flag IN ('1', 'Y'))
            OR ( :old.counted_options_flag IN ('1', 'Y') AND :new.counted_options_flag IN ('0', 'N'))
          ) THEN
        :new.UI_TIMESTAMP_CHANGETYPE:=SYSDATE;
        l_update_devl_project := TRUE;
    END IF;

    IF :old.instantiable_flag <> :new.instantiable_flag
       AND :new.ps_node_type IN (CZ_TYPES.PS_NODE_TYPE_COMPONENT, CZ_TYPES.PS_NODE_TYPE_PRODUCT, CZ_TYPES.PS_NODE_TYPE_REFERENCE) THEN
        :new.UI_TIMESTAMP_CHANGETYPE:=SYSDATE;
        l_update_devl_project := TRUE;
    END IF;

    IF ((NVL(:old.minimum,-1) <> NVL(:new.minimum,-1)) OR (NVL(:old.maximum,-1) <> NVL(:new.maximum,-1)) OR NVL(:old.instantiable_flag,'*') <> NVL(:new.instantiable_flag,'*'))
       AND :new.ps_node_type=CZ_TYPES.PS_NODE_TYPE_CONNECTOR THEN
        :new.UI_TIMESTAMP_CHANGETYPE:=SYSDATE;
        l_update_devl_project := TRUE;
    END IF;

  END IF;

  IF l_update_devl_project THEN
    UPDATE CZ_DEVL_PROJECTS
    SET UI_TIMESTAMP_STRUCT_UPDATE = SYSDATE
    WHERE devl_project_id = :new.devl_project_id;
  END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_T5" ENABLE;
