--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV148_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV148_DL" 
instead of delete on FEM_USER_LOV148_VL
referencing old as FEM_USER_LOV148_B
for each row
begin
  FEM_USER_LOV148_PKG.DELETE_ROW(
    X_USER_LOV148_CODE => :FEM_USER_LOV148_B.USER_LOV148_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV148_DL" ENABLE;
