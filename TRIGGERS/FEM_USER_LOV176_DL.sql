--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV176_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV176_DL" 
instead of delete on FEM_USER_LOV176_VL
referencing old as FEM_USER_LOV176_B
for each row
begin
  FEM_USER_LOV176_PKG.DELETE_ROW(
    X_USER_LOV176_CODE => :FEM_USER_LOV176_B.USER_LOV176_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV176_DL" ENABLE;
