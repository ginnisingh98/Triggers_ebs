--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV144_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV144_DL" 
instead of delete on FEM_USER_LOV144_VL
referencing old as FEM_USER_LOV144_B
for each row
begin
  FEM_USER_LOV144_PKG.DELETE_ROW(
    X_USER_LOV144_CODE => :FEM_USER_LOV144_B.USER_LOV144_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV144_DL" ENABLE;
