--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV54_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV54_DL" 
instead of delete on FEM_USER_LOV54_VL
referencing old as FEM_USER_LOV54_B
for each row
begin
  FEM_USER_LOV54_PKG.DELETE_ROW(
    X_USER_LOV54_CODE => :FEM_USER_LOV54_B.USER_LOV54_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV54_DL" ENABLE;
