--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV173_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV173_DL" 
instead of delete on FEM_USER_LOV173_VL
referencing old as FEM_USER_LOV173_B
for each row
begin
  FEM_USER_LOV173_PKG.DELETE_ROW(
    X_USER_LOV173_CODE => :FEM_USER_LOV173_B.USER_LOV173_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV173_DL" ENABLE;
