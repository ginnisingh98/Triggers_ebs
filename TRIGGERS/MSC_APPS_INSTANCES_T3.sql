--------------------------------------------------------
--  DDL for Trigger MSC_APPS_INSTANCES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MSC_APPS_INSTANCES_T3" 
BEFORE DELETE
ON "MSC"."MSC_APPS_INSTANCES"
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
   lv_sql_stmt VARCHAR2(500);
BEGIN
   IF :old.instance_type <> 3 THEN
      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.drop_st_partition (:instance_id); END;';
   ELSE
      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.modify_st_partition_drop (:instance_id); END;';
   END IF;
   EXECUTE IMMEDIATE lv_sql_stmt USING :old.instance_id;
END;



/
ALTER TRIGGER "APPS"."MSC_APPS_INSTANCES_T3" ENABLE;
