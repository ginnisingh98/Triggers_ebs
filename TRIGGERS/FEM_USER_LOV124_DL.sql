--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV124_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV124_DL" 
instead of delete on FEM_USER_LOV124_VL
referencing old as FEM_USER_LOV124_B
for each row
begin
  FEM_USER_LOV124_PKG.DELETE_ROW(
    X_USER_LOV124_CODE => :FEM_USER_LOV124_B.USER_LOV124_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV124_DL" ENABLE;
