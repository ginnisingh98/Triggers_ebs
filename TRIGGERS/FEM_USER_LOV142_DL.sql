--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV142_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV142_DL" 
instead of delete on FEM_USER_LOV142_VL
referencing old as FEM_USER_LOV142_B
for each row
begin
  FEM_USER_LOV142_PKG.DELETE_ROW(
    X_USER_LOV142_CODE => :FEM_USER_LOV142_B.USER_LOV142_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV142_DL" ENABLE;
