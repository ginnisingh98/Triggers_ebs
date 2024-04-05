--------------------------------------------------------
--  DDL for Trigger CN_HIERARCHY_EDGES_T5
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_HIERARCHY_EDGES_T5" 
BEFORE UPDATE ON "CN"."CN_HIERARCHY_EDGES_ALL"
REFERENCING	NEW as new
		OLD as old
FOR EACH ROW
BEGIN

  IF ( :old.value_id <> :new.value_id ) THEN

    UPDATE cn_hierarchy_nodes
       SET ref_count 	    = nvl(ref_count, 0) - 1
     WHERE value_id 	    = :old.value_id
       AND dim_hierarchy_id = :old.dim_hierarchy_id;

    UPDATE cn_hierarchy_nodes
       SET ref_count 	    = nvl(ref_count, 0) + 1
     WHERE value_id 	    = :new.value_id
       AND dim_hierarchy_id = :new.dim_hierarchy_id;

  END IF;

END;
/
ALTER TRIGGER "APPS"."CN_HIERARCHY_EDGES_T5" ENABLE;
