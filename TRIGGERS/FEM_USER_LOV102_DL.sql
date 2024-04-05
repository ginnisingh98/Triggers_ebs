--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV102_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV102_DL" 
instead of delete on FEM_USER_LOV102_VL
referencing old as FEM_USER_LOV102_B
for each row
begin
  FEM_USER_LOV102_PKG.DELETE_ROW(
    X_USER_LOV102_CODE => :FEM_USER_LOV102_B.USER_LOV102_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV102_DL" ENABLE;
