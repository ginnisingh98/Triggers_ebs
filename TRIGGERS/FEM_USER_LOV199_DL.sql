--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV199_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV199_DL" 
instead of delete on FEM_USER_LOV199_VL
referencing old as FEM_USER_LOV199_B
for each row
begin
  FEM_USER_LOV199_PKG.DELETE_ROW(
    X_USER_LOV199_CODE => :FEM_USER_LOV199_B.USER_LOV199_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV199_DL" ENABLE;
