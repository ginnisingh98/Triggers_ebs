--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV1_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV1_DL" 
instead of delete on FEM_USER_LOV1_VL
referencing old as FEM_USER_LOV1_B
for each row
begin
  FEM_USER_LOV1_PKG.DELETE_ROW(
    X_USER_LOV1_CODE => :FEM_USER_LOV1_B.USER_LOV1_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV1_DL" ENABLE;
