--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV45_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV45_DL" 
instead of delete on FEM_USER_LOV45_VL
referencing old as FEM_USER_LOV45_B
for each row
begin
  FEM_USER_LOV45_PKG.DELETE_ROW(
    X_USER_LOV45_CODE => :FEM_USER_LOV45_B.USER_LOV45_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV45_DL" ENABLE;
