--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV188_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV188_DL" 
instead of delete on FEM_USER_LOV188_VL
referencing old as FEM_USER_LOV188_B
for each row
begin
  FEM_USER_LOV188_PKG.DELETE_ROW(
    X_USER_LOV188_CODE => :FEM_USER_LOV188_B.USER_LOV188_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV188_DL" ENABLE;
