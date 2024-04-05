--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV168_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV168_DL" 
instead of delete on FEM_USER_LOV168_VL
referencing old as FEM_USER_LOV168_B
for each row
begin
  FEM_USER_LOV168_PKG.DELETE_ROW(
    X_USER_LOV168_CODE => :FEM_USER_LOV168_B.USER_LOV168_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV168_DL" ENABLE;
