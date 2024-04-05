--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV178_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV178_DL" 
instead of delete on FEM_USER_LOV178_VL
referencing old as FEM_USER_LOV178_B
for each row
begin
  FEM_USER_LOV178_PKG.DELETE_ROW(
    X_USER_LOV178_CODE => :FEM_USER_LOV178_B.USER_LOV178_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV178_DL" ENABLE;
