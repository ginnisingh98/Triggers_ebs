--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV179_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV179_DL" 
instead of delete on FEM_USER_LOV179_VL
referencing old as FEM_USER_LOV179_B
for each row
begin
  FEM_USER_LOV179_PKG.DELETE_ROW(
    X_USER_LOV179_CODE => :FEM_USER_LOV179_B.USER_LOV179_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV179_DL" ENABLE;
