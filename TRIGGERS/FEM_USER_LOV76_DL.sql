--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV76_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV76_DL" 
instead of delete on FEM_USER_LOV76_VL
referencing old as FEM_USER_LOV76_B
for each row
begin
  FEM_USER_LOV76_PKG.DELETE_ROW(
    X_USER_LOV76_CODE => :FEM_USER_LOV76_B.USER_LOV76_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV76_DL" ENABLE;
