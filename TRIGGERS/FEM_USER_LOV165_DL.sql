--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV165_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV165_DL" 
instead of delete on FEM_USER_LOV165_VL
referencing old as FEM_USER_LOV165_B
for each row
begin
  FEM_USER_LOV165_PKG.DELETE_ROW(
    X_USER_LOV165_CODE => :FEM_USER_LOV165_B.USER_LOV165_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV165_DL" ENABLE;
