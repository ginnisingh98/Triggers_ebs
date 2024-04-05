--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV8_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV8_DL" 
instead of delete on FEM_USER_LOV8_VL
referencing old as FEM_USER_LOV8_B
for each row
begin
  FEM_USER_LOV8_PKG.DELETE_ROW(
    X_USER_LOV8_CODE => :FEM_USER_LOV8_B.USER_LOV8_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV8_DL" ENABLE;
