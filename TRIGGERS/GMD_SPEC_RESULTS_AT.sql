--------------------------------------------------------
--  DDL for Trigger GMD_SPEC_RESULTS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_SPEC_RESULTS_AT" BEFORE UPDATE OF EVENT_SPEC_DISP_ID,RESULT_ID,ACTION_CODE,EVALUATION_IND,IN_SPEC_IND ON "GMD"."GMD_SPEC_RESULTS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_SPEC_RESULTS_AT" ENABLE;
