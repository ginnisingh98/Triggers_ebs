--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV32_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV32_DL" 
instead of delete on FEM_USER_LOV32_VL
referencing old as FEM_USER_LOV32_B
for each row
begin
  FEM_USER_LOV32_PKG.DELETE_ROW(
    X_USER_LOV32_CODE => :FEM_USER_LOV32_B.USER_LOV32_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV32_DL" ENABLE;
