--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV183_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV183_DL" 
instead of delete on FEM_USER_LOV183_VL
referencing old as FEM_USER_LOV183_B
for each row
begin
  FEM_USER_LOV183_PKG.DELETE_ROW(
    X_USER_LOV183_CODE => :FEM_USER_LOV183_B.USER_LOV183_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV183_DL" ENABLE;
