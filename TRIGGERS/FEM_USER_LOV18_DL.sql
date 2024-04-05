--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV18_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV18_DL" 
instead of delete on FEM_USER_LOV18_VL
referencing old as FEM_USER_LOV18_B
for each row
begin
  FEM_USER_LOV18_PKG.DELETE_ROW(
    X_USER_LOV18_CODE => :FEM_USER_LOV18_B.USER_LOV18_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV18_DL" ENABLE;
