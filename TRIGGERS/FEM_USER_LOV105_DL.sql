--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV105_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV105_DL" 
instead of delete on FEM_USER_LOV105_VL
referencing old as FEM_USER_LOV105_B
for each row
begin
  FEM_USER_LOV105_PKG.DELETE_ROW(
    X_USER_LOV105_CODE => :FEM_USER_LOV105_B.USER_LOV105_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV105_DL" ENABLE;
