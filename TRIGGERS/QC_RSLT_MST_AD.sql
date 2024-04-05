--------------------------------------------------------
--  DDL for Trigger QC_RSLT_MST_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."QC_RSLT_MST_AD" AFTER DELETE ON "GMD"."QC_RSLT_MST" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN QC_RSLT_MST_ADP(:old.QC_RESULT_ID,:old.ACCEPT_ANYWAY,:old.ASSAY_CODE,:old.DELETE_MARK,:old.FINAL_MARK,:old.NUM_RESULT,:old.QCUNIT_CODE,:old.QC_SPEC_ID,:old.SAMPLE_ID,:old.TEXT_RESULT,:new.QC_RESULT_ID,:new.ACCEPT_ANYWAY,:new.ASSAY_CODE,:new.DELETE_MARK,:new.FINAL_MARK,:new.NUM_RESULT,:new.QCUNIT_CODE,:new.QC_SPEC_ID,:new.SAMPLE_ID,:new.TEXT_RESULT);END IF;END;

/
ALTER TRIGGER "APPS"."QC_RSLT_MST_AD" ENABLE;
