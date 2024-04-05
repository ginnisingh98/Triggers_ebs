--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV149_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV149_DL" 
instead of delete on FEM_USER_LOV149_VL
referencing old as FEM_USER_LOV149_B
for each row
begin
  FEM_USER_LOV149_PKG.DELETE_ROW(
    X_USER_LOV149_CODE => :FEM_USER_LOV149_B.USER_LOV149_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV149_DL" ENABLE;
