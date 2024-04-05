--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV4_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV4_DL" 
instead of delete on FEM_USER_LOV4_VL
referencing old as FEM_USER_LOV4_B
for each row
begin
  FEM_USER_LOV4_PKG.DELETE_ROW(
    X_USER_LOV4_CODE => :FEM_USER_LOV4_B.USER_LOV4_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV4_DL" ENABLE;
