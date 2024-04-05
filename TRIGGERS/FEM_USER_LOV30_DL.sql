--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV30_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV30_DL" 
instead of delete on FEM_USER_LOV30_VL
referencing old as FEM_USER_LOV30_B
for each row
begin
  FEM_USER_LOV30_PKG.DELETE_ROW(
    X_USER_LOV30_CODE => :FEM_USER_LOV30_B.USER_LOV30_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV30_DL" ENABLE;
