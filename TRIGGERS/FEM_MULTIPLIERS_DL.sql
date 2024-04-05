--------------------------------------------------------
--  DDL for Trigger FEM_MULTIPLIERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MULTIPLIERS_DL" 
instead of delete on FEM_MULTIPLIERS_VL
referencing old as FEM_MULTIPLIERS_B
for each row
begin
  FEM_MULTIPLIERS_PKG.DELETE_ROW(
    X_MULTIPLIER_CODE => :FEM_MULTIPLIERS_B.MULTIPLIER_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MULTIPLIERS_DL" ENABLE;
