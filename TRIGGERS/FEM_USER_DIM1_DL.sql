--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM1_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM1_DL" 
instead of delete on FEM_USER_DIM1_VL
referencing old as FEM_USER_DIM1_B
for each row
begin
  FEM_USER_DIM1_PKG.DELETE_ROW(
    X_USER_DIM1_ID => :FEM_USER_DIM1_B.USER_DIM1_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM1_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM1_DL" ENABLE;
