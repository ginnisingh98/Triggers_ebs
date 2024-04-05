--------------------------------------------------------
--  DDL for Trigger FEM_PAYMNT_HIST_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PAYMNT_HIST_DL" 
instead of delete on FEM_PAYMNT_HIST_VL
referencing old as FEM_PAYMNT_HIST_B
for each row
begin
  FEM_PAYMNT_HIST_PKG.DELETE_ROW(
    X_PAYMENT_HISTORY_CODE => :FEM_PAYMNT_HIST_B.PAYMENT_HISTORY_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PAYMNT_HIST_DL" ENABLE;
