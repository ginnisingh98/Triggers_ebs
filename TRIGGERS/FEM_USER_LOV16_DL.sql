--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV16_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV16_DL" 
instead of delete on FEM_USER_LOV16_VL
referencing old as FEM_USER_LOV16_B
for each row
begin
  FEM_USER_LOV16_PKG.DELETE_ROW(
    X_USER_LOV16_CODE => :FEM_USER_LOV16_B.USER_LOV16_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV16_DL" ENABLE;
