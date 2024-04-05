--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV95_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV95_DL" 
instead of delete on FEM_USER_LOV95_VL
referencing old as FEM_USER_LOV95_B
for each row
begin
  FEM_USER_LOV95_PKG.DELETE_ROW(
    X_USER_LOV95_CODE => :FEM_USER_LOV95_B.USER_LOV95_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV95_DL" ENABLE;
