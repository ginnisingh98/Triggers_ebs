--------------------------------------------------------
--  DDL for Trigger GMD_RESULTS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RESULTS_AT" BEFORE UPDATE OF RESULT_ID,QC_LAB_ORGN_CODE,RESULT_DATE,RESULT_VALUE_CHAR,RESULT_VALUE_NUM,SAMPLE_ID,TEST_ID ON "GMD"."GMD_RESULTS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RESULTS_AT" ENABLE;
