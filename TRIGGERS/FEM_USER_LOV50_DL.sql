--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV50_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV50_DL" 
instead of delete on FEM_USER_LOV50_VL
referencing old as FEM_USER_LOV50_B
for each row
begin
  FEM_USER_LOV50_PKG.DELETE_ROW(
    X_USER_LOV50_CODE => :FEM_USER_LOV50_B.USER_LOV50_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV50_DL" ENABLE;
