--------------------------------------------------------
--  DDL for Trigger CN_HIERARCHY_EDGES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_HIERARCHY_EDGES_T1" 
BEFORE INSERT ON "CN"."CN_HIERARCHY_EDGES_ALL"
REFERENCING	NEW as new
		OLD as old
FOR EACH ROW
BEGIN

  UPDATE cn_hierarchy_nodes
     SET ref_count        = nvl(ref_count, 0) + 1
   WHERE value_id         = :new.value_id
     AND dim_hierarchy_id = :new.dim_hierarchy_id;

END;
/
ALTER TRIGGER "APPS"."CN_HIERARCHY_EDGES_T1" ENABLE;
