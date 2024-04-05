--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV38_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV38_DL" 
instead of delete on FEM_USER_LOV38_VL
referencing old as FEM_USER_LOV38_B
for each row
begin
  FEM_USER_LOV38_PKG.DELETE_ROW(
    X_USER_LOV38_CODE => :FEM_USER_LOV38_B.USER_LOV38_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV38_DL" ENABLE;
