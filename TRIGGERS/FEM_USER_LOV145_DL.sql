--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV145_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV145_DL" 
instead of delete on FEM_USER_LOV145_VL
referencing old as FEM_USER_LOV145_B
for each row
begin
  FEM_USER_LOV145_PKG.DELETE_ROW(
    X_USER_LOV145_CODE => :FEM_USER_LOV145_B.USER_LOV145_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV145_DL" ENABLE;
