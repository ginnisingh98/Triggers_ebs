--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV162_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV162_DL" 
instead of delete on FEM_USER_LOV162_VL
referencing old as FEM_USER_LOV162_B
for each row
begin
  FEM_USER_LOV162_PKG.DELETE_ROW(
    X_USER_LOV162_CODE => :FEM_USER_LOV162_B.USER_LOV162_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV162_DL" ENABLE;
