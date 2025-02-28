--------------------------------------------------------
--  DDL for Trigger FEM_MERCH_CHAINS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MERCH_CHAINS_UL" 
instead of update on FEM_MERCH_CHAINS_VL
referencing new as FEM_MERCH_CHAINS_B
for each row
begin
  FEM_MERCH_CHAINS_PKG.UPDATE_ROW(
    X_MERCHANT_CHAIN_CODE => :FEM_MERCH_CHAINS_B.MERCHANT_CHAIN_CODE,
    X_ENABLED_FLAG => :FEM_MERCH_CHAINS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_MERCH_CHAINS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_MERCH_CHAINS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_MERCH_CHAINS_B.OBJECT_VERSION_NUMBER,
    X_MERCHANT_CHAIN_NAME => :FEM_MERCH_CHAINS_B.MERCHANT_CHAIN_NAME,
    X_DESCRIPTION => :FEM_MERCH_CHAINS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_MERCH_CHAINS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_MERCH_CHAINS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_MERCH_CHAINS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MERCH_CHAINS_UL" ENABLE;
