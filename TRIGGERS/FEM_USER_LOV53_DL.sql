--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV53_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV53_DL" 
instead of delete on FEM_USER_LOV53_VL
referencing old as FEM_USER_LOV53_B
for each row
begin
  FEM_USER_LOV53_PKG.DELETE_ROW(
    X_USER_LOV53_CODE => :FEM_USER_LOV53_B.USER_LOV53_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV53_DL" ENABLE;
