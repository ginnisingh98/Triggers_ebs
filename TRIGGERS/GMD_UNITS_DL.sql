--------------------------------------------------------
--  DDL for Trigger GMD_UNITS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_UNITS_DL" 
/* $Header: GMDUNDTG.sql 115.0 2002/03/12 13:13:33 pkm ship        $ */
instead of delete on GMD_UNITS_VL
referencing old as QC_UNIT_MST
for each row

begin
  GMD_UNITS_PKG.DELETE_ROW(
    X_QCUNIT_CODE => :QC_UNIT_MST.QCUNIT_CODE);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GMD_UNITS_DL" ENABLE;
