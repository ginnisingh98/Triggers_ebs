--------------------------------------------------------
--  DDL for Trigger FEM_MERCH_CHAINS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MERCH_CHAINS_DL" 
instead of delete on FEM_MERCH_CHAINS_VL
referencing old as FEM_MERCH_CHAINS_B
for each row
begin
  FEM_MERCH_CHAINS_PKG.DELETE_ROW(
    X_MERCHANT_CHAIN_CODE => :FEM_MERCH_CHAINS_B.MERCHANT_CHAIN_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MERCH_CHAINS_DL" ENABLE;
