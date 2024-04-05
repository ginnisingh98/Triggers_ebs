--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV73_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV73_DL" 
instead of delete on FEM_USER_LOV73_VL
referencing old as FEM_USER_LOV73_B
for each row
begin
  FEM_USER_LOV73_PKG.DELETE_ROW(
    X_USER_LOV73_CODE => :FEM_USER_LOV73_B.USER_LOV73_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV73_DL" ENABLE;
