--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV103_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV103_DL" 
instead of delete on FEM_USER_LOV103_VL
referencing old as FEM_USER_LOV103_B
for each row
begin
  FEM_USER_LOV103_PKG.DELETE_ROW(
    X_USER_LOV103_CODE => :FEM_USER_LOV103_B.USER_LOV103_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV103_DL" ENABLE;
