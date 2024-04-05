--------------------------------------------------------
--  DDL for Trigger FEM_SACCTSRV_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SACCTSRV_TYPES_DL" 
instead of delete on FEM_SACCTSRV_TYPES_VL
referencing old as FEM_SACCTSRV_TYPES_B
for each row
begin
  FEM_SACCTSRV_TYPES_PKG.DELETE_ROW(
    X_SETTLEMENT_ACCT_SERV_CODE => :FEM_SACCTSRV_TYPES_B.SETTLEMENT_ACCT_SERV_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SACCTSRV_TYPES_DL" ENABLE;
