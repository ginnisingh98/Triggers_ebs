--------------------------------------------------------
--  DDL for Trigger GMD_OPERATIONS_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_OPERATIONS_B_AT" BEFORE UPDATE OF OPRN_ID,DELETE_MARK,EFFECTIVE_END_DATE,EFFECTIVE_START_DATE,OPRN_CLASS,OPRN_NO,OPRN_VERS,OWNER_ORGN_CODE,PROCESS_QTY_UM ON "GMD"."GMD_OPERATIONS_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_OPERATIONS_B_AT" ENABLE;
