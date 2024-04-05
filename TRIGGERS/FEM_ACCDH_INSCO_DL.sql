--------------------------------------------------------
--  DDL for Trigger FEM_ACCDH_INSCO_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCDH_INSCO_DL" 
instead of delete on FEM_ACCDH_INSCO_VL
referencing old as FEM_ACCDH_INSCO_B
for each row
begin
  FEM_ACCDH_INSCO_PKG.DELETE_ROW(
    X_ACCID_HEALTH_INS_CO_CODE => :FEM_ACCDH_INSCO_B.ACCID_HEALTH_INS_CO_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCDH_INSCO_DL" ENABLE;
