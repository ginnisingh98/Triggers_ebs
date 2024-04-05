--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV120_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV120_DL" 
instead of delete on FEM_USER_LOV120_VL
referencing old as FEM_USER_LOV120_B
for each row
begin
  FEM_USER_LOV120_PKG.DELETE_ROW(
    X_USER_LOV120_CODE => :FEM_USER_LOV120_B.USER_LOV120_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV120_DL" ENABLE;
