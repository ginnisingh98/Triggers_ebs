--------------------------------------------------------
--  DDL for Trigger GMD_TESTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_TESTS_DL" 
/* $Header: GMDASDTG.sql 115.0 2002/03/12 12:40:42 pkm ship        $ */
instead of delete on GMD_TESTS_VL
referencing old as QC_ASSY_TYP
for each row

begin
  GMD_TESTS_PKG.DELETE_ROW(
    X_QCASSY_TYP_ID => :QC_ASSY_TYP.QCASSY_TYP_ID);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GMD_TESTS_DL" ENABLE;
