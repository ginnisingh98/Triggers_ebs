--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV69_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV69_DL" 
instead of delete on FEM_USER_LOV69_VL
referencing old as FEM_USER_LOV69_B
for each row
begin
  FEM_USER_LOV69_PKG.DELETE_ROW(
    X_USER_LOV69_CODE => :FEM_USER_LOV69_B.USER_LOV69_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV69_DL" ENABLE;
