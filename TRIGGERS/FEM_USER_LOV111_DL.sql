--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV111_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV111_DL" 
instead of delete on FEM_USER_LOV111_VL
referencing old as FEM_USER_LOV111_B
for each row
begin
  FEM_USER_LOV111_PKG.DELETE_ROW(
    X_USER_LOV111_CODE => :FEM_USER_LOV111_B.USER_LOV111_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV111_DL" ENABLE;
