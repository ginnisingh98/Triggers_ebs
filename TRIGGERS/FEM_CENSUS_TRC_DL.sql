--------------------------------------------------------
--  DDL for Trigger FEM_CENSUS_TRC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CENSUS_TRC_DL" 
instead of delete on FEM_CENSUS_TRC_VL
referencing old as FEM_CENSUS_TRC_B
for each row
begin
  FEM_CENSUS_TRC_PKG.DELETE_ROW(
    X_CENSUS_TRACT_CODE => :FEM_CENSUS_TRC_B.CENSUS_TRACT_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CENSUS_TRC_DL" ENABLE;
