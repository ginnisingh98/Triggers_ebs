--------------------------------------------------------
--  DDL for Trigger FEM_AGENCY_BNKS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGENCY_BNKS_DL" 
instead of delete on FEM_AGENCY_BNKS_VL
referencing old as FEM_AGENCY_BNKS_B
for each row
begin
  FEM_AGENCY_BNKS_PKG.DELETE_ROW(
    X_AGENT_BANK_CODE => :FEM_AGENCY_BNKS_B.AGENT_BANK_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGENCY_BNKS_DL" ENABLE;
