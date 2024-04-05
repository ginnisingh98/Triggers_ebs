--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM7_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM7_DL" 
instead of delete on FEM_USER_DIM7_VL
referencing old as FEM_USER_DIM7_B
for each row
begin
  FEM_USER_DIM7_PKG.DELETE_ROW(
    X_USER_DIM7_ID => :FEM_USER_DIM7_B.USER_DIM7_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM7_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM7_DL" ENABLE;
