--------------------------------------------------------
--  DDL for Trigger FEM_ACCT_GRPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCT_GRPS_DL" 
instead of delete on FEM_ACCT_GRPS_VL
referencing old as FEM_ACCT_GRPS_B
for each row
begin
  FEM_ACCT_GRPS_PKG.DELETE_ROW(
    X_ACCOUNT_GROUP_ID => :FEM_ACCT_GRPS_B.ACCOUNT_GROUP_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCT_GRPS_DL" ENABLE;
