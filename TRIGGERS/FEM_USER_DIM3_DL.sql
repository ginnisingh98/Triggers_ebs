--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM3_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM3_DL" 
instead of delete on FEM_USER_DIM3_VL
referencing old as FEM_USER_DIM3_B
for each row
begin
  FEM_USER_DIM3_PKG.DELETE_ROW(
    X_USER_DIM3_ID => :FEM_USER_DIM3_B.USER_DIM3_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM3_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM3_DL" ENABLE;
