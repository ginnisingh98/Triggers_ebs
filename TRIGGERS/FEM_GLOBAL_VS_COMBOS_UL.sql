--------------------------------------------------------
--  DDL for Trigger FEM_GLOBAL_VS_COMBOS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_GLOBAL_VS_COMBOS_UL" 
instead of update on FEM_GLOBAL_VS_COMBOS_VL
referencing new as FEM_GLOBAL_VS_COMBOS_B
for each row
begin
  FEM_GLOBAL_VS_COMBOS_PKG.UPDATE_ROW(
    X_GLOBAL_VS_COMBO_ID => :FEM_GLOBAL_VS_COMBOS_B.GLOBAL_VS_COMBO_ID,
    X_GLOBAL_VS_COMBO_DISPLAY_CODE => :FEM_GLOBAL_VS_COMBOS_B.GLOBAL_VS_COMBO_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_GLOBAL_VS_COMBOS_B.ENABLED_FLAG,
    X_READ_ONLY_FLAG => :FEM_GLOBAL_VS_COMBOS_B.READ_ONLY_FLAG,
    X_PERSONAL_FLAG => :FEM_GLOBAL_VS_COMBOS_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_GLOBAL_VS_COMBOS_B.OBJECT_VERSION_NUMBER,
    X_GLOBAL_VS_COMBO_NAME => :FEM_GLOBAL_VS_COMBOS_B.GLOBAL_VS_COMBO_NAME,
    X_DESCRIPTION => :FEM_GLOBAL_VS_COMBOS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_GLOBAL_VS_COMBOS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_GLOBAL_VS_COMBOS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_GLOBAL_VS_COMBOS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_GLOBAL_VS_COMBOS_UL" ENABLE;
