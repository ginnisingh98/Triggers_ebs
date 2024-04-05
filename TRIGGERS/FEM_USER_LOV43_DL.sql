--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV43_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV43_DL" 
instead of delete on FEM_USER_LOV43_VL
referencing old as FEM_USER_LOV43_B
for each row
begin
  FEM_USER_LOV43_PKG.DELETE_ROW(
    X_USER_LOV43_CODE => :FEM_USER_LOV43_B.USER_LOV43_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV43_DL" ENABLE;
