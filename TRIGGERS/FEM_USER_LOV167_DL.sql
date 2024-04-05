--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV167_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV167_DL" 
instead of delete on FEM_USER_LOV167_VL
referencing old as FEM_USER_LOV167_B
for each row
begin
  FEM_USER_LOV167_PKG.DELETE_ROW(
    X_USER_LOV167_CODE => :FEM_USER_LOV167_B.USER_LOV167_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV167_DL" ENABLE;
