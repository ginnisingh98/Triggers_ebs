--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV2_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV2_DL" 
instead of delete on FEM_USER_LOV2_VL
referencing old as FEM_USER_LOV2_B
for each row
begin
  FEM_USER_LOV2_PKG.DELETE_ROW(
    X_USER_LOV2_CODE => :FEM_USER_LOV2_B.USER_LOV2_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV2_DL" ENABLE;
