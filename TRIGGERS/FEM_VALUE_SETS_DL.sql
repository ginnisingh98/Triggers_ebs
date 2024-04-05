--------------------------------------------------------
--  DDL for Trigger FEM_VALUE_SETS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_VALUE_SETS_DL" 
instead of delete on FEM_VALUE_SETS_VL
referencing old as FEM_VALUE_SETS_B
for each row
begin
  FEM_VALUE_SETS_PKG.DELETE_ROW(
    X_VALUE_SET_ID => :FEM_VALUE_SETS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_VALUE_SETS_DL" ENABLE;
