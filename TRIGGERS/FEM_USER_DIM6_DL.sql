--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM6_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM6_DL" 
instead of delete on FEM_USER_DIM6_VL
referencing old as FEM_USER_DIM6_B
for each row
begin
  FEM_USER_DIM6_PKG.DELETE_ROW(
    X_USER_DIM6_ID => :FEM_USER_DIM6_B.USER_DIM6_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM6_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM6_DL" ENABLE;
