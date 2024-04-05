--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV17_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV17_DL" 
instead of delete on FEM_USER_LOV17_VL
referencing old as FEM_USER_LOV17_B
for each row
begin
  FEM_USER_LOV17_PKG.DELETE_ROW(
    X_USER_LOV17_CODE => :FEM_USER_LOV17_B.USER_LOV17_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV17_DL" ENABLE;
