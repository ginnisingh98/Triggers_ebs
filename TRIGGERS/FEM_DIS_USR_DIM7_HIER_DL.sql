--------------------------------------------------------
--  DDL for Trigger FEM_DIS_USR_DIM7_HIER_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIS_USR_DIM7_HIER_DL" 
instead of delete on FEM_DIS_USR_DIM7_HIER_VL
referencing old as FEM_DIS_USR_DIM7_HIER_B
for each row
begin
  FEM_DIS_USR_DIM7_HIER_PKG.DELETE_ROW(
    X_OBJECT_ID => :FEM_DIS_USR_DIM7_HIER_B.OBJECT_ID,
    X_OBJECT_DEFINITION_ID => :FEM_DIS_USR_DIM7_HIER_B.OBJECT_DEFINITION_ID,
    X_VALUE_SET_ID => :FEM_DIS_USR_DIM7_HIER_B.VALUE_SET_ID,
    X_LEVEL1_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL1_ID,
    X_LEVEL2_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL2_ID,
    X_LEVEL3_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL3_ID,
    X_LEVEL4_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL4_ID,
    X_LEVEL5_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL5_ID,
    X_LEVEL6_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL6_ID,
    X_LEVEL7_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL7_ID,
    X_LEVEL8_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL8_ID,
    X_LEVEL9_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL9_ID,
    X_LEVEL10_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL10_ID,
    X_LEVEL11_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL11_ID,
    X_LEVEL12_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL12_ID,
    X_LEVEL13_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL13_ID,
    X_LEVEL14_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL14_ID,
    X_LEVEL15_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL15_ID,
    X_LEVEL16_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL16_ID,
    X_LEVEL17_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL17_ID,
    X_LEVEL18_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL18_ID,
    X_LEVEL19_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL19_ID,
    X_LEVEL20_ID => :FEM_DIS_USR_DIM7_HIER_B.LEVEL20_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIS_USR_DIM7_HIER_DL" ENABLE;
