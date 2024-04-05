--------------------------------------------------------
--  DDL for Trigger GME_BATCH_HEADER_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_BATCH_HEADER_AD" AFTER DELETE ON "GME"."GME_BATCH_HEADER" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GME_BATCH_HEADER_ADP(:old.BATCH_ID,:old.ACTUAL_CMPLT_DATE,:old.ACTUAL_START_DATE,:old.BATCH_NO,:old.BATCH_STATUS,:old.BATCH_TYPE,:old.DELETE_MARK,:old.FORMULA_ID,:old.PLANT_CODE,:old.PLAN_START_DATE,:old.ROUTING_ID,:new.BATCH_ID,:new.ACTUAL_CMPLT_DATE,:new.ACTUAL_START_DATE,:new.BATCH_NO,:new.BATCH_STATUS,:new.BATCH_TYPE,:new.DELETE_MARK,:new.FORMULA_ID,:new.PLANT_CODE,:new.PLAN_START_DATE,:new.ROUTING_ID);END IF;END;

/
ALTER TRIGGER "APPS"."GME_BATCH_HEADER_AD" ENABLE;
