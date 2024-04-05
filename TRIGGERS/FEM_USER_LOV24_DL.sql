--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV24_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV24_DL" 
instead of delete on FEM_USER_LOV24_VL
referencing old as FEM_USER_LOV24_B
for each row
begin
  FEM_USER_LOV24_PKG.DELETE_ROW(
    X_USER_LOV24_CODE => :FEM_USER_LOV24_B.USER_LOV24_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV24_DL" ENABLE;
