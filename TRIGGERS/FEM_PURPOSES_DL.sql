--------------------------------------------------------
--  DDL for Trigger FEM_PURPOSES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PURPOSES_DL" 
instead of delete on FEM_PURPOSES_VL
referencing old as FEM_PURPOSES_B
for each row
begin
  FEM_PURPOSES_PKG.DELETE_ROW(
    X_PURPOSE_ID => :FEM_PURPOSES_B.PURPOSE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PURPOSES_DL" ENABLE;
