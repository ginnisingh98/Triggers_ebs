--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV31_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV31_DL" 
instead of delete on FEM_USER_LOV31_VL
referencing old as FEM_USER_LOV31_B
for each row
begin
  FEM_USER_LOV31_PKG.DELETE_ROW(
    X_USER_LOV31_CODE => :FEM_USER_LOV31_B.USER_LOV31_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV31_DL" ENABLE;
