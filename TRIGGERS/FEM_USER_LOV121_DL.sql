--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV121_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV121_DL" 
instead of delete on FEM_USER_LOV121_VL
referencing old as FEM_USER_LOV121_B
for each row
begin
  FEM_USER_LOV121_PKG.DELETE_ROW(
    X_USER_LOV121_CODE => :FEM_USER_LOV121_B.USER_LOV121_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV121_DL" ENABLE;
