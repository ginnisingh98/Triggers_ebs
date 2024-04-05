--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV174_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV174_DL" 
instead of delete on FEM_USER_LOV174_VL
referencing old as FEM_USER_LOV174_B
for each row
begin
  FEM_USER_LOV174_PKG.DELETE_ROW(
    X_USER_LOV174_CODE => :FEM_USER_LOV174_B.USER_LOV174_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV174_DL" ENABLE;
