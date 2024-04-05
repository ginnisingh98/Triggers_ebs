--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV135_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV135_DL" 
instead of delete on FEM_USER_LOV135_VL
referencing old as FEM_USER_LOV135_B
for each row
begin
  FEM_USER_LOV135_PKG.DELETE_ROW(
    X_USER_LOV135_CODE => :FEM_USER_LOV135_B.USER_LOV135_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV135_DL" ENABLE;
