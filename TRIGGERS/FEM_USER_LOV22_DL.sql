--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV22_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV22_DL" 
instead of delete on FEM_USER_LOV22_VL
referencing old as FEM_USER_LOV22_B
for each row
begin
  FEM_USER_LOV22_PKG.DELETE_ROW(
    X_USER_LOV22_CODE => :FEM_USER_LOV22_B.USER_LOV22_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV22_DL" ENABLE;
