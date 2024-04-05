--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV91_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV91_DL" 
instead of delete on FEM_USER_LOV91_VL
referencing old as FEM_USER_LOV91_B
for each row
begin
  FEM_USER_LOV91_PKG.DELETE_ROW(
    X_USER_LOV91_CODE => :FEM_USER_LOV91_B.USER_LOV91_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV91_DL" ENABLE;
