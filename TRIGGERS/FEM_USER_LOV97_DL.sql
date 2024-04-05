--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV97_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV97_DL" 
instead of delete on FEM_USER_LOV97_VL
referencing old as FEM_USER_LOV97_B
for each row
begin
  FEM_USER_LOV97_PKG.DELETE_ROW(
    X_USER_LOV97_CODE => :FEM_USER_LOV97_B.USER_LOV97_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV97_DL" ENABLE;
