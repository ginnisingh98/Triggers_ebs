--------------------------------------------------------
--  DDL for Trigger FEM_DISBACCT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DISBACCT_TYPES_DL" 
instead of delete on FEM_DISBACCT_TYPES_VL
referencing old as FEM_DISBACCT_TYPES_B
for each row
begin
  FEM_DISBACCT_TYPES_PKG.DELETE_ROW(
    X_DISBURS_ACCT_TYPE_CODE => :FEM_DISBACCT_TYPES_B.DISBURS_ACCT_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DISBACCT_TYPES_DL" ENABLE;
