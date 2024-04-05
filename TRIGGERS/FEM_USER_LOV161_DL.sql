--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV161_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV161_DL" 
instead of delete on FEM_USER_LOV161_VL
referencing old as FEM_USER_LOV161_B
for each row
begin
  FEM_USER_LOV161_PKG.DELETE_ROW(
    X_USER_LOV161_CODE => :FEM_USER_LOV161_B.USER_LOV161_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV161_DL" ENABLE;
