--------------------------------------------------------
--  DDL for Trigger FEM_OCCUPANCIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OCCUPANCIES_DL" 
instead of delete on FEM_OCCUPANCIES_VL
referencing old as FEM_OCCUPANCIES_B
for each row
begin
  FEM_OCCUPANCIES_PKG.DELETE_ROW(
    X_OCCUPANCY_ID => :FEM_OCCUPANCIES_B.OCCUPANCY_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OCCUPANCIES_DL" ENABLE;
