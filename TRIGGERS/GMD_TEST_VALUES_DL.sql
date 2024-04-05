--------------------------------------------------------
--  DDL for Trigger GMD_TEST_VALUES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_TEST_VALUES_DL" 
/* $Header: GMDAVDTG.sql 115.0 2002/03/12 12:44:01 pkm ship        $ */
instead of delete on GMD_TEST_VALUES_VL
referencing old as QC_ASSY_VAL
for each row

begin
  GMD_TEST_VALUES_PKG.DELETE_ROW(
    X_QCASSY_VAL_ID => :QC_ASSY_VAL.QCASSY_VAL_ID);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GMD_TEST_VALUES_DL" ENABLE;
