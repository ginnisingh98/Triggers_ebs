--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV140_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV140_DL" 
instead of delete on FEM_USER_LOV140_VL
referencing old as FEM_USER_LOV140_B
for each row
begin
  FEM_USER_LOV140_PKG.DELETE_ROW(
    X_USER_LOV140_CODE => :FEM_USER_LOV140_B.USER_LOV140_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV140_DL" ENABLE;
