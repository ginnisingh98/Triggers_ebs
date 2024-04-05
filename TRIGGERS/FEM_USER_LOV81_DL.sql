--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV81_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV81_DL" 
instead of delete on FEM_USER_LOV81_VL
referencing old as FEM_USER_LOV81_B
for each row
begin
  FEM_USER_LOV81_PKG.DELETE_ROW(
    X_USER_LOV81_CODE => :FEM_USER_LOV81_B.USER_LOV81_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV81_DL" ENABLE;
