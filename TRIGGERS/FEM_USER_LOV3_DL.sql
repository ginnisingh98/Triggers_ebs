--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV3_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV3_DL" 
instead of delete on FEM_USER_LOV3_VL
referencing old as FEM_USER_LOV3_B
for each row
begin
  FEM_USER_LOV3_PKG.DELETE_ROW(
    X_USER_LOV3_CODE => :FEM_USER_LOV3_B.USER_LOV3_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV3_DL" ENABLE;
