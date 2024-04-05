--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV146_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV146_DL" 
instead of delete on FEM_USER_LOV146_VL
referencing old as FEM_USER_LOV146_B
for each row
begin
  FEM_USER_LOV146_PKG.DELETE_ROW(
    X_USER_LOV146_CODE => :FEM_USER_LOV146_B.USER_LOV146_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV146_DL" ENABLE;
