--------------------------------------------------------
--  DDL for Trigger FEM_GLOBAL_VS_COMBOS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_GLOBAL_VS_COMBOS_DL" 
instead of delete on FEM_GLOBAL_VS_COMBOS_VL
referencing old as FEM_GLOBAL_VS_COMBOS_B
for each row
begin
  FEM_GLOBAL_VS_COMBOS_PKG.DELETE_ROW(
    X_GLOBAL_VS_COMBO_ID => :FEM_GLOBAL_VS_COMBOS_B.GLOBAL_VS_COMBO_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_GLOBAL_VS_COMBOS_DL" ENABLE;
