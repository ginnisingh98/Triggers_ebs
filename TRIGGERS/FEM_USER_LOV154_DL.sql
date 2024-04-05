--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV154_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV154_DL" 
instead of delete on FEM_USER_LOV154_VL
referencing old as FEM_USER_LOV154_B
for each row
begin
  FEM_USER_LOV154_PKG.DELETE_ROW(
    X_USER_LOV154_CODE => :FEM_USER_LOV154_B.USER_LOV154_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV154_DL" ENABLE;
