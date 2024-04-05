--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM2_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM2_DL" 
instead of delete on FEM_USER_DIM2_VL
referencing old as FEM_USER_DIM2_B
for each row
begin
  FEM_USER_DIM2_PKG.DELETE_ROW(
    X_USER_DIM2_ID => :FEM_USER_DIM2_B.USER_DIM2_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM2_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM2_DL" ENABLE;
