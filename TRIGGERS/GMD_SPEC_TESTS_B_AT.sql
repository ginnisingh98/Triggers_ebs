--------------------------------------------------------
--  DDL for Trigger GMD_SPEC_TESTS_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_SPEC_TESTS_B_AT" BEFORE UPDATE OF SPEC_ID,TEST_ID,ABOVE_MAX_ACTION_CODE,ABOVE_MIN_ACTION_CODE,ABOVE_SPEC_MAX,ABOVE_SPEC_MIN,BELOW_MAX_ACTION_CODE,BELOW_MIN_ACTION_CODE,BELOW_SPEC_MAX,BELOW_SPEC_MIN,MAX_VALUE_CHAR,MAX_VALUE_NUM,MIN_VALUE_CHAR,MIN_VALUE_NUM,OUT_OF_SPEC_ACTION,TARGET_VALUE_CHAR,TARGET_VALUE_NUM,TEST_METHOD_ID ON "GMD"."GMD_SPEC_TESTS_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_SPEC_TESTS_B_AT" ENABLE;
