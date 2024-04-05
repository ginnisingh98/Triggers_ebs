--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV42_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV42_DL" 
instead of delete on FEM_USER_LOV42_VL
referencing old as FEM_USER_LOV42_B
for each row
begin
  FEM_USER_LOV42_PKG.DELETE_ROW(
    X_USER_LOV42_CODE => :FEM_USER_LOV42_B.USER_LOV42_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV42_DL" ENABLE;
