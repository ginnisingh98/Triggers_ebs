--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV51_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV51_DL" 
instead of delete on FEM_USER_LOV51_VL
referencing old as FEM_USER_LOV51_B
for each row
begin
  FEM_USER_LOV51_PKG.DELETE_ROW(
    X_USER_LOV51_CODE => :FEM_USER_LOV51_B.USER_LOV51_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV51_DL" ENABLE;
