--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV108_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV108_DL" 
instead of delete on FEM_USER_LOV108_VL
referencing old as FEM_USER_LOV108_B
for each row
begin
  FEM_USER_LOV108_PKG.DELETE_ROW(
    X_USER_LOV108_CODE => :FEM_USER_LOV108_B.USER_LOV108_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV108_DL" ENABLE;
