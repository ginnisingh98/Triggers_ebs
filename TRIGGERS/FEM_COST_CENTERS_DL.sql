--------------------------------------------------------
--  DDL for Trigger FEM_COST_CENTERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COST_CENTERS_DL" 
instead of delete on FEM_COST_CENTERS_VL
referencing old as FEM_COST_CENTERS_B
for each row
begin
  FEM_COST_CENTERS_PKG.DELETE_ROW(
    X_COST_CENTER_ID => :FEM_COST_CENTERS_B.COST_CENTER_ID,
    X_VALUE_SET_ID => :FEM_COST_CENTERS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COST_CENTERS_DL" ENABLE;
