--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV10_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV10_DL" 
instead of delete on FEM_USER_LOV10_VL
referencing old as FEM_USER_LOV10_B
for each row
begin
  FEM_USER_LOV10_PKG.DELETE_ROW(
    X_USER_LOV10_CODE => :FEM_USER_LOV10_B.USER_LOV10_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV10_DL" ENABLE;
