--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV20_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV20_DL" 
instead of delete on FEM_USER_LOV20_VL
referencing old as FEM_USER_LOV20_B
for each row
begin
  FEM_USER_LOV20_PKG.DELETE_ROW(
    X_USER_LOV20_CODE => :FEM_USER_LOV20_B.USER_LOV20_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV20_DL" ENABLE;
