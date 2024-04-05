--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV166_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV166_DL" 
instead of delete on FEM_USER_LOV166_VL
referencing old as FEM_USER_LOV166_B
for each row
begin
  FEM_USER_LOV166_PKG.DELETE_ROW(
    X_USER_LOV166_CODE => :FEM_USER_LOV166_B.USER_LOV166_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV166_DL" ENABLE;
