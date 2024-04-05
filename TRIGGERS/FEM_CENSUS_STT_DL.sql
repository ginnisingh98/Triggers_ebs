--------------------------------------------------------
--  DDL for Trigger FEM_CENSUS_STT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CENSUS_STT_DL" 
instead of delete on FEM_CENSUS_STT_VL
referencing old as FEM_CENSUS_STT_B
for each row
begin
  FEM_CENSUS_STT_PKG.DELETE_ROW(
    X_CENSUS_STATE_CODE => :FEM_CENSUS_STT_B.CENSUS_STATE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CENSUS_STT_DL" ENABLE;
