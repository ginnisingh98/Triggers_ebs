--------------------------------------------------------
--  DDL for Trigger FEM_SOURCE_SYSTEMS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SOURCE_SYSTEMS_DL" 
instead of delete on FEM_SOURCE_SYSTEMS_VL
referencing old as FEM_SOURCE_SYSTEMS_B
for each row
begin
  FEM_SOURCE_SYSTEMS_PKG.DELETE_ROW(
    X_SOURCE_SYSTEM_CODE => :FEM_SOURCE_SYSTEMS_B.SOURCE_SYSTEM_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SOURCE_SYSTEMS_DL" ENABLE;
