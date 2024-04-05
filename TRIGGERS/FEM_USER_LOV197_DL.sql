--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV197_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV197_DL" 
instead of delete on FEM_USER_LOV197_VL
referencing old as FEM_USER_LOV197_B
for each row
begin
  FEM_USER_LOV197_PKG.DELETE_ROW(
    X_USER_LOV197_CODE => :FEM_USER_LOV197_B.USER_LOV197_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV197_DL" ENABLE;
