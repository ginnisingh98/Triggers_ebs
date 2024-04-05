--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV12_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV12_DL" 
instead of delete on FEM_USER_LOV12_VL
referencing old as FEM_USER_LOV12_B
for each row
begin
  FEM_USER_LOV12_PKG.DELETE_ROW(
    X_USER_LOV12_CODE => :FEM_USER_LOV12_B.USER_LOV12_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV12_DL" ENABLE;
