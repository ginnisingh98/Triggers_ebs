--------------------------------------------------------
--  DDL for Trigger INSTEAD_OF_UPDATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."INSTEAD_OF_UPDATE" 
  INSTEAD OF UPDATE ON GMD_TECHNICAL_DATA_VL
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
	UPDATE gmd_technical_data_hdr
	  SET ORGN_CODE = NVL(:NEW.LAB_TYPE, ORGN_CODE);
END instead_of_update;


/
ALTER TRIGGER "APPS"."INSTEAD_OF_UPDATE" ENABLE;
