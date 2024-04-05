--------------------------------------------------------
--  DDL for Trigger FEM_CORPAGRMNTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CORPAGRMNTS_DL" 
instead of delete on FEM_CORPAGRMNTS_VL
referencing old as FEM_CORPAGRMNTS_B
for each row
begin
  FEM_CORPAGRMNTS_PKG.DELETE_ROW(
    X_CORPORATE_AGREEMENT_CODE => :FEM_CORPAGRMNTS_B.CORPORATE_AGREEMENT_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CORPAGRMNTS_DL" ENABLE;
