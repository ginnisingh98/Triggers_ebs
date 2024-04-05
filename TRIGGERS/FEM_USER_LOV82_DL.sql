--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV82_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV82_DL" 
instead of delete on FEM_USER_LOV82_VL
referencing old as FEM_USER_LOV82_B
for each row
begin
  FEM_USER_LOV82_PKG.DELETE_ROW(
    X_USER_LOV82_CODE => :FEM_USER_LOV82_B.USER_LOV82_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV82_DL" ENABLE;
