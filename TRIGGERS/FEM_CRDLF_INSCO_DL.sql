--------------------------------------------------------
--  DDL for Trigger FEM_CRDLF_INSCO_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CRDLF_INSCO_DL" 
instead of delete on FEM_CRDLF_INSCO_VL
referencing old as FEM_CRDLF_INSCO_B
for each row
begin
  FEM_CRDLF_INSCO_PKG.DELETE_ROW(
    X_CREDIT_LIFE_INS_CO_CODE => :FEM_CRDLF_INSCO_B.CREDIT_LIFE_INS_CO_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CRDLF_INSCO_DL" ENABLE;
