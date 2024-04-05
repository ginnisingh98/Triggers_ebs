--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV39_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV39_DL" 
instead of delete on FEM_USER_LOV39_VL
referencing old as FEM_USER_LOV39_B
for each row
begin
  FEM_USER_LOV39_PKG.DELETE_ROW(
    X_USER_LOV39_CODE => :FEM_USER_LOV39_B.USER_LOV39_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV39_DL" ENABLE;
