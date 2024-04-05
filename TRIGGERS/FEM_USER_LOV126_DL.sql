--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV126_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV126_DL" 
instead of delete on FEM_USER_LOV126_VL
referencing old as FEM_USER_LOV126_B
for each row
begin
  FEM_USER_LOV126_PKG.DELETE_ROW(
    X_USER_LOV126_CODE => :FEM_USER_LOV126_B.USER_LOV126_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV126_DL" ENABLE;
