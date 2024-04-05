--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV131_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV131_DL" 
instead of delete on FEM_USER_LOV131_VL
referencing old as FEM_USER_LOV131_B
for each row
begin
  FEM_USER_LOV131_PKG.DELETE_ROW(
    X_USER_LOV131_CODE => :FEM_USER_LOV131_B.USER_LOV131_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV131_DL" ENABLE;
