--------------------------------------------------------
--  DDL for Trigger FEM_ACCT_OWNSHP_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCT_OWNSHP_DL" 
instead of delete on FEM_ACCT_OWNSHP_VL
referencing old as FEM_ACCT_OWNSHP_B
for each row
begin
  FEM_ACCT_OWNSHP_PKG.DELETE_ROW(
    X_ACCT_OWNERSHIP_ID => :FEM_ACCT_OWNSHP_B.ACCT_OWNERSHIP_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCT_OWNSHP_DL" ENABLE;
