--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV25_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV25_DL" 
instead of delete on FEM_USER_LOV25_VL
referencing old as FEM_USER_LOV25_B
for each row
begin
  FEM_USER_LOV25_PKG.DELETE_ROW(
    X_USER_LOV25_CODE => :FEM_USER_LOV25_B.USER_LOV25_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV25_DL" ENABLE;
