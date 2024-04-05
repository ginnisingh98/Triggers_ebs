--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV159_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV159_DL" 
instead of delete on FEM_USER_LOV159_VL
referencing old as FEM_USER_LOV159_B
for each row
begin
  FEM_USER_LOV159_PKG.DELETE_ROW(
    X_USER_LOV159_CODE => :FEM_USER_LOV159_B.USER_LOV159_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV159_DL" ENABLE;
