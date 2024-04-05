--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV13_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV13_DL" 
instead of delete on FEM_USER_LOV13_VL
referencing old as FEM_USER_LOV13_B
for each row
begin
  FEM_USER_LOV13_PKG.DELETE_ROW(
    X_USER_LOV13_CODE => :FEM_USER_LOV13_B.USER_LOV13_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV13_DL" ENABLE;
