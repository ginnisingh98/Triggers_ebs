--------------------------------------------------------
--  DDL for Trigger FEM_PAYMNT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PAYMNT_TYPES_DL" 
instead of delete on FEM_PAYMNT_TYPES_VL
referencing old as FEM_PAYMNT_TYPES_B
for each row
begin
  FEM_PAYMNT_TYPES_PKG.DELETE_ROW(
    X_PMT_TYPE_ID => :FEM_PAYMNT_TYPES_B.PMT_TYPE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PAYMNT_TYPES_DL" ENABLE;
