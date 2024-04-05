--------------------------------------------------------
--  DDL for Trigger FEM_CREDIT_STATUS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CREDIT_STATUS_DL" 
instead of delete on FEM_CREDIT_STATUS_VL
referencing old as FEM_CREDIT_STATUS_B
for each row
begin
  FEM_CREDIT_STATUS_PKG.DELETE_ROW(
    X_CREDIT_STATUS_ID => :FEM_CREDIT_STATUS_B.CREDIT_STATUS_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CREDIT_STATUS_DL" ENABLE;
