--------------------------------------------------------
--  DDL for Trigger FEM_NAT_ACCTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_NAT_ACCTS_DL" 
instead of delete on FEM_NAT_ACCTS_VL
referencing old as FEM_NAT_ACCTS_B
for each row
begin
  FEM_NAT_ACCTS_PKG.DELETE_ROW(
    X_NATURAL_ACCOUNT_ID => :FEM_NAT_ACCTS_B.NATURAL_ACCOUNT_ID,
    X_VALUE_SET_ID => :FEM_NAT_ACCTS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_NAT_ACCTS_DL" ENABLE;
