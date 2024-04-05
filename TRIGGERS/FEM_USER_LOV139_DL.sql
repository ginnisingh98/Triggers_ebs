--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV139_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV139_DL" 
instead of delete on FEM_USER_LOV139_VL
referencing old as FEM_USER_LOV139_B
for each row
begin
  FEM_USER_LOV139_PKG.DELETE_ROW(
    X_USER_LOV139_CODE => :FEM_USER_LOV139_B.USER_LOV139_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV139_DL" ENABLE;
