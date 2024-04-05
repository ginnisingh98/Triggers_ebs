--------------------------------------------------------
--  DDL for Trigger FEM_APAYINST_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_APAYINST_TYPES_DL" 
instead of delete on FEM_APAYINST_TYPES_VL
referencing old as FEM_APAYINST_TYPES_B
for each row
begin
  FEM_APAYINST_TYPES_PKG.DELETE_ROW(
    X_AUTOPAY_INSTR_TYPE_ID => :FEM_APAYINST_TYPES_B.AUTOPAY_INSTR_TYPE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_APAYINST_TYPES_DL" ENABLE;
