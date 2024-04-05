--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV127_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV127_DL" 
instead of delete on FEM_USER_LOV127_VL
referencing old as FEM_USER_LOV127_B
for each row
begin
  FEM_USER_LOV127_PKG.DELETE_ROW(
    X_USER_LOV127_CODE => :FEM_USER_LOV127_B.USER_LOV127_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV127_DL" ENABLE;
