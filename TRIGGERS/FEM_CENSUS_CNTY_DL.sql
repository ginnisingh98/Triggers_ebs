--------------------------------------------------------
--  DDL for Trigger FEM_CENSUS_CNTY_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CENSUS_CNTY_DL" 
instead of delete on FEM_CENSUS_CNTY_VL
referencing old as FEM_CENSUS_CNTY_B
for each row
begin
  FEM_CENSUS_CNTY_PKG.DELETE_ROW(
    X_CENSUS_COUNTY_CODE => :FEM_CENSUS_CNTY_B.CENSUS_COUNTY_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CENSUS_CNTY_DL" ENABLE;
