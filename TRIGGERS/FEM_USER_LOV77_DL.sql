--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV77_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV77_DL" 
instead of delete on FEM_USER_LOV77_VL
referencing old as FEM_USER_LOV77_B
for each row
begin
  FEM_USER_LOV77_PKG.DELETE_ROW(
    X_USER_LOV77_CODE => :FEM_USER_LOV77_B.USER_LOV77_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV77_DL" ENABLE;
