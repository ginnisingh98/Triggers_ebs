--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV6_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV6_DL" 
instead of delete on FEM_USER_LOV6_VL
referencing old as FEM_USER_LOV6_B
for each row
begin
  FEM_USER_LOV6_PKG.DELETE_ROW(
    X_USER_LOV6_CODE => :FEM_USER_LOV6_B.USER_LOV6_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV6_DL" ENABLE;
