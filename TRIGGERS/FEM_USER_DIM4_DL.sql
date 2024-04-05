--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM4_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM4_DL" 
instead of delete on FEM_USER_DIM4_VL
referencing old as FEM_USER_DIM4_B
for each row
begin
  FEM_USER_DIM4_PKG.DELETE_ROW(
    X_USER_DIM4_ID => :FEM_USER_DIM4_B.USER_DIM4_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM4_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM4_DL" ENABLE;
