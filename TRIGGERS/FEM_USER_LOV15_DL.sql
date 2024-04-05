--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV15_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV15_DL" 
instead of delete on FEM_USER_LOV15_VL
referencing old as FEM_USER_LOV15_B
for each row
begin
  FEM_USER_LOV15_PKG.DELETE_ROW(
    X_USER_LOV15_CODE => :FEM_USER_LOV15_B.USER_LOV15_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV15_DL" ENABLE;
