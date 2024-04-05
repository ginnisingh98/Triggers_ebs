--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV186_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV186_DL" 
instead of delete on FEM_USER_LOV186_VL
referencing old as FEM_USER_LOV186_B
for each row
begin
  FEM_USER_LOV186_PKG.DELETE_ROW(
    X_USER_LOV186_CODE => :FEM_USER_LOV186_B.USER_LOV186_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV186_DL" ENABLE;
