--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV44_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV44_DL" 
instead of delete on FEM_USER_LOV44_VL
referencing old as FEM_USER_LOV44_B
for each row
begin
  FEM_USER_LOV44_PKG.DELETE_ROW(
    X_USER_LOV44_CODE => :FEM_USER_LOV44_B.USER_LOV44_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV44_DL" ENABLE;
