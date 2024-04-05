--------------------------------------------------------
--  DDL for Trigger QC_RSLT_MST_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."QC_RSLT_MST_AT" BEFORE UPDATE OF QC_RESULT_ID,ACCEPT_ANYWAY,ASSAY_CODE,DELETE_MARK,FINAL_MARK,NUM_RESULT,QCUNIT_CODE,QC_SPEC_ID,SAMPLE_ID,TEXT_RESULT ON "GMD"."QC_RSLT_MST" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."QC_RSLT_MST_AT" ENABLE;
