--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV67_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV67_DL" 
instead of delete on FEM_USER_LOV67_VL
referencing old as FEM_USER_LOV67_B
for each row
begin
  FEM_USER_LOV67_PKG.DELETE_ROW(
    X_USER_LOV67_CODE => :FEM_USER_LOV67_B.USER_LOV67_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV67_DL" ENABLE;
