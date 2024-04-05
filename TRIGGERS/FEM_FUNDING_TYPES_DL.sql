--------------------------------------------------------
--  DDL for Trigger FEM_FUNDING_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FUNDING_TYPES_DL" 
instead of delete on FEM_FUNDING_TYPES_VL
referencing old as FEM_FUNDING_TYPES_B
for each row
begin
  FEM_FUNDING_TYPES_PKG.DELETE_ROW(
    X_FUNDING_TYPE_CODE => :FEM_FUNDING_TYPES_B.FUNDING_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FUNDING_TYPES_DL" ENABLE;
