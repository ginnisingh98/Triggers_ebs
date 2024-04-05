--------------------------------------------------------
--  DDL for Trigger GMD_SPECIFICATIONS_B_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_SPECIFICATIONS_B_AD" AFTER DELETE ON "GMD"."GMD_SPECIFICATIONS_B" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GMD_SPECIFICATIONS_B_ADP(:old.SPEC_ID,:old.ITEM_ID,:old.SPEC_NAME,:old.SPEC_STATUS,:old.SPEC_VERS,:new.SPEC_ID,:new.ITEM_ID,:new.SPEC_NAME,:new.SPEC_STATUS,:new.SPEC_VERS);END IF;END;

/
ALTER TRIGGER "APPS"."GMD_SPECIFICATIONS_B_AD" ENABLE;
