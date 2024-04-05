--------------------------------------------------------
--  DDL for Trigger FEM_LEDGERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LEDGERS_DL" 
instead of delete on FEM_LEDGERS_VL
referencing old as FEM_LEDGERS_B
for each row
begin
  FEM_LEDGERS_PKG.DELETE_ROW(
    X_LEDGER_ID => :FEM_LEDGERS_B.LEDGER_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_LEDGERS_DL" ENABLE;
