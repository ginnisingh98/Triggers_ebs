--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV137_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV137_DL" 
instead of delete on FEM_USER_LOV137_VL
referencing old as FEM_USER_LOV137_B
for each row
begin
  FEM_USER_LOV137_PKG.DELETE_ROW(
    X_USER_LOV137_CODE => :FEM_USER_LOV137_B.USER_LOV137_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV137_DL" ENABLE;
