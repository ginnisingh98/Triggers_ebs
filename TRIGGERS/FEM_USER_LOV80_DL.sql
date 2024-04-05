--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV80_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV80_DL" 
instead of delete on FEM_USER_LOV80_VL
referencing old as FEM_USER_LOV80_B
for each row
begin
  FEM_USER_LOV80_PKG.DELETE_ROW(
    X_USER_LOV80_CODE => :FEM_USER_LOV80_B.USER_LOV80_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV80_DL" ENABLE;
