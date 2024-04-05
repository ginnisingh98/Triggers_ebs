--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV63_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV63_DL" 
instead of delete on FEM_USER_LOV63_VL
referencing old as FEM_USER_LOV63_B
for each row
begin
  FEM_USER_LOV63_PKG.DELETE_ROW(
    X_USER_LOV63_CODE => :FEM_USER_LOV63_B.USER_LOV63_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV63_DL" ENABLE;
