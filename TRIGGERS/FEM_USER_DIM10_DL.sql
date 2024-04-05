--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM10_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM10_DL" 
instead of delete on FEM_USER_DIM10_VL
referencing old as FEM_USER_DIM10_B
for each row
begin
  FEM_USER_DIM10_PKG.DELETE_ROW(
    X_USER_DIM10_ID => :FEM_USER_DIM10_B.USER_DIM10_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM10_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM10_DL" ENABLE;
