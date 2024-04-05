--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV163_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV163_DL" 
instead of delete on FEM_USER_LOV163_VL
referencing old as FEM_USER_LOV163_B
for each row
begin
  FEM_USER_LOV163_PKG.DELETE_ROW(
    X_USER_LOV163_CODE => :FEM_USER_LOV163_B.USER_LOV163_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV163_DL" ENABLE;
