--------------------------------------------------------
--  DDL for Trigger XXAH_VA_UPL_BIR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_VA_UPL_BIR" 
  BEFORE INSERT OR UPDATE ON XXAH.XXAH_VA_UPLOAD
REFERENCING OLD AS OLD
            NEW AS NEW
  FOR EACH ROW
BEGIN
  :new.attribute10 := to_char(fnd_global.user_id);
END xxah_va_upl_bir;

/
ALTER TRIGGER "APPS"."XXAH_VA_UPL_BIR" ENABLE;
