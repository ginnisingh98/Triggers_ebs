--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV83_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV83_DL" 
instead of delete on FEM_USER_LOV83_VL
referencing old as FEM_USER_LOV83_B
for each row
begin
  FEM_USER_LOV83_PKG.DELETE_ROW(
    X_USER_LOV83_CODE => :FEM_USER_LOV83_B.USER_LOV83_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV83_DL" ENABLE;
