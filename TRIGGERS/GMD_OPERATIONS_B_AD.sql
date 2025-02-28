--------------------------------------------------------
--  DDL for Trigger GMD_OPERATIONS_B_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_OPERATIONS_B_AD" AFTER DELETE ON "GMD"."GMD_OPERATIONS_B" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GMD_OPERATIONS_B_ADP(:old.OPRN_ID,:old.DELETE_MARK,:old.EFFECTIVE_END_DATE,:old.EFFECTIVE_START_DATE,:old.OPRN_CLASS,:old.OPRN_NO,:old.OPRN_VERS,:old.OWNER_ORGN_CODE,:old.PROCESS_QTY_UM,:new.OPRN_ID,:new.DELETE_MARK,:new.EFFECTIVE_END_DATE,:new.EFFECTIVE_START_DATE,:new.OPRN_CLASS,:new.OPRN_NO,:new.OPRN_VERS,:new.OWNER_ORGN_CODE,:new.PROCESS_QTY_UM);END IF;END;

/
ALTER TRIGGER "APPS"."GMD_OPERATIONS_B_AD" ENABLE;
