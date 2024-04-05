--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV136_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV136_DL" 
instead of delete on FEM_USER_LOV136_VL
referencing old as FEM_USER_LOV136_B
for each row
begin
  FEM_USER_LOV136_PKG.DELETE_ROW(
    X_USER_LOV136_CODE => :FEM_USER_LOV136_B.USER_LOV136_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV136_DL" ENABLE;
