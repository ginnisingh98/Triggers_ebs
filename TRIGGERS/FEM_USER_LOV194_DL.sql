--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV194_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV194_DL" 
instead of delete on FEM_USER_LOV194_VL
referencing old as FEM_USER_LOV194_B
for each row
begin
  FEM_USER_LOV194_PKG.DELETE_ROW(
    X_USER_LOV194_CODE => :FEM_USER_LOV194_B.USER_LOV194_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV194_DL" ENABLE;
