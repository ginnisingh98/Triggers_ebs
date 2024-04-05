--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV181_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV181_DL" 
instead of delete on FEM_USER_LOV181_VL
referencing old as FEM_USER_LOV181_B
for each row
begin
  FEM_USER_LOV181_PKG.DELETE_ROW(
    X_USER_LOV181_CODE => :FEM_USER_LOV181_B.USER_LOV181_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV181_DL" ENABLE;
