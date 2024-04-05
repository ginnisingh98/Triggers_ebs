--------------------------------------------------------
--  DDL for Trigger FEM_CMO_TRANCHE_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CMO_TRANCHE_DL" 
instead of delete on FEM_CMO_TRANCHE_VL
referencing old as FEM_CMO_TRANCHE_B
for each row
begin
  FEM_CMO_TRANCHE_PKG.DELETE_ROW(
    X_CMO_TRANCHE_ID => :FEM_CMO_TRANCHE_B.CMO_TRANCHE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CMO_TRANCHE_DL" ENABLE;
