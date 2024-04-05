--------------------------------------------------------
--  DDL for Trigger FEM_DRDPACCT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DRDPACCT_TYPES_DL" 
instead of delete on FEM_DRDPACCT_TYPES_VL
referencing old as FEM_DRDPACCT_TYPES_B
for each row
begin
  FEM_DRDPACCT_TYPES_PKG.DELETE_ROW(
    X_DIR_DEPOS_ACCT_TYPE_CODE => :FEM_DRDPACCT_TYPES_B.DIR_DEPOS_ACCT_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DRDPACCT_TYPES_DL" ENABLE;
