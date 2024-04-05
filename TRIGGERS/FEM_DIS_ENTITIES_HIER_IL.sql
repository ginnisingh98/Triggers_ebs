--------------------------------------------------------
--  DDL for Trigger FEM_DIS_ENTITIES_HIER_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIS_ENTITIES_HIER_IL" 
instead of insert on FEM_DIS_ENTITIES_HIER_VL
referencing new as FEM_DIS_ENTITIES_HIER_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_DIS_ENTITIES_HIER_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_OBJECT_ID => :FEM_DIS_ENTITIES_HIER_B.OBJECT_ID,
    X_OBJECT_DEFINITION_ID => :FEM_DIS_ENTITIES_HIER_B.OBJECT_DEFINITION_ID,
    X_VALUE_SET_ID => :FEM_DIS_ENTITIES_HIER_B.VALUE_SET_ID,
    X_LEVEL1_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL1_ID,
    X_LEVEL2_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL2_ID,
    X_LEVEL3_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL3_ID,
    X_LEVEL4_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL4_ID,
    X_LEVEL5_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL5_ID,
    X_LEVEL6_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL6_ID,
    X_LEVEL7_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL7_ID,
    X_LEVEL8_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL8_ID,
    X_LEVEL9_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL9_ID,
    X_LEVEL10_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL10_ID,
    X_LEVEL11_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL11_ID,
    X_LEVEL12_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL12_ID,
    X_LEVEL13_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL13_ID,
    X_LEVEL14_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL14_ID,
    X_LEVEL15_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL15_ID,
    X_LEVEL16_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL16_ID,
    X_LEVEL17_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL17_ID,
    X_LEVEL18_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL18_ID,
    X_LEVEL19_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL19_ID,
    X_LEVEL20_ID => :FEM_DIS_ENTITIES_HIER_B.LEVEL20_ID,
    X_LEVEL17_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL17_DISPLAY_ORDER_NUM,
    X_LEVEL18_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL18_DISPLAY_ORDER_NUM,
    X_LEVEL19_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL19_DISPLAY_ORDER_NUM,
    X_LEVEL20_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL20_DISPLAY_ORDER_NUM,
    X_LEVEL1_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL1_DISPLAY_CODE,
    X_LEVEL2_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL2_DISPLAY_CODE,
    X_LEVEL3_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL3_DISPLAY_CODE,
    X_LEVEL4_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL4_DISPLAY_CODE,
    X_LEVEL5_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL5_DISPLAY_CODE,
    X_LEVEL6_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL6_DISPLAY_CODE,
    X_LEVEL7_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL7_DISPLAY_CODE,
    X_LEVEL8_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL8_DISPLAY_CODE,
    X_LEVEL9_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL9_DISPLAY_CODE,
    X_LEVEL10_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL10_DISPLAY_CODE,
    X_LEVEL11_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL11_DISPLAY_CODE,
    X_LEVEL12_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL12_DISPLAY_CODE,
    X_LEVEL13_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL13_DISPLAY_CODE,
    X_LEVEL14_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL14_DISPLAY_CODE,
    X_LEVEL15_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL15_DISPLAY_CODE,
    X_LEVEL16_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL16_DISPLAY_CODE,
    X_LEVEL17_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL17_DISPLAY_CODE,
    X_LEVEL18_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL18_DISPLAY_CODE,
    X_LEVEL19_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL19_DISPLAY_CODE,
    X_LEVEL20_DISPLAY_CODE => :FEM_DIS_ENTITIES_HIER_B.LEVEL20_DISPLAY_CODE,
    X_LEVEL1_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL1_DISPLAY_ORDER_NUM,
    X_LEVEL2_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL2_DISPLAY_ORDER_NUM,
    X_LEVEL3_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL3_DISPLAY_ORDER_NUM,
    X_LEVEL4_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL4_DISPLAY_ORDER_NUM,
    X_LEVEL5_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL5_DISPLAY_ORDER_NUM,
    X_LEVEL6_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL6_DISPLAY_ORDER_NUM,
    X_LEVEL7_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL7_DISPLAY_ORDER_NUM,
    X_LEVEL8_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL8_DISPLAY_ORDER_NUM,
    X_LEVEL9_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL9_DISPLAY_ORDER_NUM,
    X_LEVEL10_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL10_DISPLAY_ORDER_NUM,
    X_LEVEL11_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL11_DISPLAY_ORDER_NUM,
    X_LEVEL12_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL12_DISPLAY_ORDER_NUM,
    X_LEVEL13_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL13_DISPLAY_ORDER_NUM,
    X_LEVEL14_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL14_DISPLAY_ORDER_NUM,
    X_LEVEL15_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL15_DISPLAY_ORDER_NUM,
    X_LEVEL16_DISPLAY_ORDER_NUM => :FEM_DIS_ENTITIES_HIER_B.LEVEL16_DISPLAY_ORDER_NUM,
    X_OBJECT_NAME => :FEM_DIS_ENTITIES_HIER_B.OBJECT_NAME,
    X_OBJECT_DEFINITION_NAME => :FEM_DIS_ENTITIES_HIER_B.OBJECT_DEFINITION_NAME,
    X_LEVEL1_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL1_NAME,
    X_LEVEL2_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL2_NAME,
    X_LEVEL3_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL3_NAME,
    X_LEVEL4_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL4_NAME,
    X_LEVEL5_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL5_NAME,
    X_LEVEL6_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL6_NAME,
    X_LEVEL7_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL7_NAME,
    X_LEVEL8_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL8_NAME,
    X_LEVEL9_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL9_NAME,
    X_LEVEL10_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL10_NAME,
    X_LEVEL11_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL11_NAME,
    X_LEVEL12_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL12_NAME,
    X_LEVEL13_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL13_NAME,
    X_LEVEL14_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL14_NAME,
    X_LEVEL15_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL15_NAME,
    X_LEVEL16_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL16_NAME,
    X_LEVEL17_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL17_NAME,
    X_LEVEL18_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL18_NAME,
    X_LEVEL19_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL19_NAME,
    X_LEVEL20_NAME => :FEM_DIS_ENTITIES_HIER_B.LEVEL20_NAME,
    X_LEVEL1_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL1_DESCRIPTION,
    X_LEVEL2_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL2_DESCRIPTION,
    X_LEVEL3_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL3_DESCRIPTION,
    X_LEVEL4_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL4_DESCRIPTION,
    X_LEVEL5_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL5_DESCRIPTION,
    X_LEVEL6_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL6_DESCRIPTION,
    X_LEVEL7_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL7_DESCRIPTION,
    X_LEVEL8_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL8_DESCRIPTION,
    X_LEVEL9_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL9_DESCRIPTION,
    X_LEVEL10_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL10_DESCRIPTION,
    X_LEVEL11_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL11_DESCRIPTION,
    X_LEVEL12_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL12_DESCRIPTION,
    X_LEVEL13_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL13_DESCRIPTION,
    X_LEVEL14_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL14_DESCRIPTION,
    X_LEVEL15_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL15_DESCRIPTION,
    X_LEVEL16_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL16_DESCRIPTION,
    X_LEVEL17_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL17_DESCRIPTION,
    X_LEVEL18_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL18_DESCRIPTION,
    X_LEVEL19_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL19_DESCRIPTION,
    X_LEVEL20_DESCRIPTION => :FEM_DIS_ENTITIES_HIER_B.LEVEL20_DESCRIPTION,
    X_CREATION_DATE => :FEM_DIS_ENTITIES_HIER_B.CREATION_DATE,
    X_CREATED_BY => :FEM_DIS_ENTITIES_HIER_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_DIS_ENTITIES_HIER_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_DIS_ENTITIES_HIER_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_DIS_ENTITIES_HIER_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIS_ENTITIES_HIER_IL" ENABLE;
