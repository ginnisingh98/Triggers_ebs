--------------------------------------------------------
--  DDL for Trigger MSC_APPS_INSTANCES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MSC_APPS_INSTANCES_T2" 
BEFORE UPDATE OF instance_type
ON "MSC"."MSC_APPS_INSTANCES"
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
   lv_sql_stmt VARCHAR2(500);
BEGIN
   IF :old.instance_type = 3 AND :new.instance_type <> 3 THEN
      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.modify_st_partition_drop (:instance_id); END;';
      EXECUTE IMMEDIATE lv_sql_stmt USING :old.instance_id;

      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.create_st_partition (:instance_id); END;';
      EXECUTE IMMEDIATE lv_sql_stmt USING :new.instance_id;
   END IF;

   IF :old.instance_type <> 3 and :new.instance_type = 3 THEN
      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.drop_st_partition (:instance_id); END;';
      EXECUTE IMMEDIATE lv_sql_stmt USING :old.instance_id;

      lv_sql_stmt := 'BEGIN MSC_CL_EXCHANGE_PARTTBL.modify_st_partition_add (:instance_id); END;';
      EXECUTE IMMEDIATE lv_sql_stmt USING :new.instance_id;
   END IF;

END;


/
ALTER TRIGGER "APPS"."MSC_APPS_INSTANCES_T2" ENABLE;
