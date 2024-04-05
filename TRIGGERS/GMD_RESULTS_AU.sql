--------------------------------------------------------
--  DDL for Trigger GMD_RESULTS_AU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RESULTS_AU" AFTER UPDATE OF RESULT_ID,QC_LAB_ORGN_CODE,RESULT_DATE,RESULT_VALUE_CHAR,RESULT_VALUE_NUM,SAMPLE_ID,TEST_ID ON "GMD"."GMD_RESULTS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GMD_RESULTS_AUP(:old.RESULT_ID,:old.QC_LAB_ORGN_CODE,:old.RESULT_DATE,:old.RESULT_VALUE_CHAR,:old.RESULT_VALUE_NUM,:old.SAMPLE_ID,:old.TEST_ID,:new.RESULT_ID,:new.QC_LAB_ORGN_CODE,:new.RESULT_DATE,:new.RESULT_VALUE_CHAR,:new.RESULT_VALUE_NUM,:new.SAMPLE_ID,:new.TEST_ID);END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RESULTS_AU" ENABLE;
