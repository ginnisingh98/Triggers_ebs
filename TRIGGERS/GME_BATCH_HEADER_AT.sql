--------------------------------------------------------
--  DDL for Trigger GME_BATCH_HEADER_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_BATCH_HEADER_AT" BEFORE UPDATE OF BATCH_ID,ACTUAL_CMPLT_DATE,ACTUAL_START_DATE,BATCH_NO,BATCH_STATUS,BATCH_TYPE,DELETE_MARK,FORMULA_ID,PLANT_CODE,PLAN_START_DATE,ROUTING_ID ON "GME"."GME_BATCH_HEADER" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GME_BATCH_HEADER_AT" ENABLE;
