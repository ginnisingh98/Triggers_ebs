--------------------------------------------------------
--  DDL for Trigger FEM_CCTR_ORG_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CCTR_ORG_TYPES_DL" 
instead of delete on FEM_CCTR_ORG_TYPES_VL
referencing old as FEM_CCTR_ORG_TYPES_B
for each row
begin
  FEM_CCTR_ORG_TYPES_PKG.DELETE_ROW(
    X_CCTR_ORG_TYPE_CODE => :FEM_CCTR_ORG_TYPES_B.CCTR_ORG_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CCTR_ORG_TYPES_DL" ENABLE;
