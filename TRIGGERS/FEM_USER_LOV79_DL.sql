--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV79_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV79_DL" 
instead of delete on FEM_USER_LOV79_VL
referencing old as FEM_USER_LOV79_B
for each row
begin
  FEM_USER_LOV79_PKG.DELETE_ROW(
    X_USER_LOV79_CODE => :FEM_USER_LOV79_B.USER_LOV79_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV79_DL" ENABLE;
