--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV52_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV52_DL" 
instead of delete on FEM_USER_LOV52_VL
referencing old as FEM_USER_LOV52_B
for each row
begin
  FEM_USER_LOV52_PKG.DELETE_ROW(
    X_USER_LOV52_CODE => :FEM_USER_LOV52_B.USER_LOV52_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV52_DL" ENABLE;
