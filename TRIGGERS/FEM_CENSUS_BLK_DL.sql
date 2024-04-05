--------------------------------------------------------
--  DDL for Trigger FEM_CENSUS_BLK_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CENSUS_BLK_DL" 
instead of delete on FEM_CENSUS_BLK_VL
referencing old as FEM_CENSUS_BLK_B
for each row
begin
  FEM_CENSUS_BLK_PKG.DELETE_ROW(
    X_CENSUS_BLOCK_CODE => :FEM_CENSUS_BLK_B.CENSUS_BLOCK_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CENSUS_BLK_DL" ENABLE;
