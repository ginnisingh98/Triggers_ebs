--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV133_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV133_DL" 
instead of delete on FEM_USER_LOV133_VL
referencing old as FEM_USER_LOV133_B
for each row
begin
  FEM_USER_LOV133_PKG.DELETE_ROW(
    X_USER_LOV133_CODE => :FEM_USER_LOV133_B.USER_LOV133_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV133_DL" ENABLE;
