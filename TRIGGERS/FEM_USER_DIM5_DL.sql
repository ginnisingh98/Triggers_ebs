--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM5_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM5_DL" 
instead of delete on FEM_USER_DIM5_VL
referencing old as FEM_USER_DIM5_B
for each row
begin
  FEM_USER_DIM5_PKG.DELETE_ROW(
    X_USER_DIM5_ID => :FEM_USER_DIM5_B.USER_DIM5_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM5_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM5_DL" ENABLE;
