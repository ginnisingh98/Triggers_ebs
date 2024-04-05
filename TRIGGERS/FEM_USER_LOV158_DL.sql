--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV158_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV158_DL" 
instead of delete on FEM_USER_LOV158_VL
referencing old as FEM_USER_LOV158_B
for each row
begin
  FEM_USER_LOV158_PKG.DELETE_ROW(
    X_USER_LOV158_CODE => :FEM_USER_LOV158_B.USER_LOV158_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV158_DL" ENABLE;
