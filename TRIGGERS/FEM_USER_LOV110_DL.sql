--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV110_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV110_DL" 
instead of delete on FEM_USER_LOV110_VL
referencing old as FEM_USER_LOV110_B
for each row
begin
  FEM_USER_LOV110_PKG.DELETE_ROW(
    X_USER_LOV110_CODE => :FEM_USER_LOV110_B.USER_LOV110_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV110_DL" ENABLE;
