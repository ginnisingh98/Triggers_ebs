--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV164_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV164_DL" 
instead of delete on FEM_USER_LOV164_VL
referencing old as FEM_USER_LOV164_B
for each row
begin
  FEM_USER_LOV164_PKG.DELETE_ROW(
    X_USER_LOV164_CODE => :FEM_USER_LOV164_B.USER_LOV164_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV164_DL" ENABLE;
