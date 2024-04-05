--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV190_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV190_DL" 
instead of delete on FEM_USER_LOV190_VL
referencing old as FEM_USER_LOV190_B
for each row
begin
  FEM_USER_LOV190_PKG.DELETE_ROW(
    X_USER_LOV190_CODE => :FEM_USER_LOV190_B.USER_LOV190_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV190_DL" ENABLE;
