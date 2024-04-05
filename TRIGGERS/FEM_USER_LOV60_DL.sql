--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV60_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV60_DL" 
instead of delete on FEM_USER_LOV60_VL
referencing old as FEM_USER_LOV60_B
for each row
begin
  FEM_USER_LOV60_PKG.DELETE_ROW(
    X_USER_LOV60_CODE => :FEM_USER_LOV60_B.USER_LOV60_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV60_DL" ENABLE;
