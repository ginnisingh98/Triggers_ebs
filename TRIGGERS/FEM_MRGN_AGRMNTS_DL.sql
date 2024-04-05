--------------------------------------------------------
--  DDL for Trigger FEM_MRGN_AGRMNTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MRGN_AGRMNTS_DL" 
instead of delete on FEM_MRGN_AGRMNTS_VL
referencing old as FEM_MRGN_AGRMNTS_B
for each row
begin
  FEM_MRGN_AGRMNTS_PKG.DELETE_ROW(
    X_MARGIN_AGREEMENT_CODE => :FEM_MRGN_AGRMNTS_B.MARGIN_AGREEMENT_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MRGN_AGRMNTS_DL" ENABLE;
