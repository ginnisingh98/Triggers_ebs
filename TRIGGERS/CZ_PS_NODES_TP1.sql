--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_TP1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_TP1" 
BEFORE INSERT
ON "CZ"."CZ_PS_NODES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE

  v_persistent_id   cz_ps_nodes.persistent_node_id%TYPE;

BEGIN

  IF :NEW.PERSISTENT_NODE_ID IS NULL THEN
   :new.PERSISTENT_NODE_ID := :new.PS_NODE_ID;
  END IF;

  v_persistent_id := :new.PERSISTENT_NODE_ID;
  cz_model_migration_pvt.allocate_persistent_id(:new.DEVL_PROJECT_ID, v_persistent_id);
  :new.PERSISTENT_NODE_ID := v_persistent_id;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_TP1" ENABLE;
