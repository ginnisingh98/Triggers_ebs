--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV123_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV123_DL" 
instead of delete on FEM_USER_LOV123_VL
referencing old as FEM_USER_LOV123_B
for each row
begin
  FEM_USER_LOV123_PKG.DELETE_ROW(
    X_USER_LOV123_CODE => :FEM_USER_LOV123_B.USER_LOV123_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV123_DL" ENABLE;
