--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV85_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV85_DL" 
instead of delete on FEM_USER_LOV85_VL
referencing old as FEM_USER_LOV85_B
for each row
begin
  FEM_USER_LOV85_PKG.DELETE_ROW(
    X_USER_LOV85_CODE => :FEM_USER_LOV85_B.USER_LOV85_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV85_DL" ENABLE;
