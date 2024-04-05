--------------------------------------------------------
--  DDL for Trigger FEM_COLLATERAL_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COLLATERAL_DL" 
instead of delete on FEM_COLLATERAL_VL
referencing old as FEM_COLLATERAL_B
for each row
begin
  FEM_COLLATERAL_PKG.DELETE_ROW(
    X_COLLATERAL_ID => :FEM_COLLATERAL_B.COLLATERAL_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COLLATERAL_DL" ENABLE;
