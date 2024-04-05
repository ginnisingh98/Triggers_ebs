--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV193_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV193_DL" 
instead of delete on FEM_USER_LOV193_VL
referencing old as FEM_USER_LOV193_B
for each row
begin
  FEM_USER_LOV193_PKG.DELETE_ROW(
    X_USER_LOV193_CODE => :FEM_USER_LOV193_B.USER_LOV193_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV193_DL" ENABLE;
