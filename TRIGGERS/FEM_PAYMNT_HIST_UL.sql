--------------------------------------------------------
--  DDL for Trigger FEM_PAYMNT_HIST_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PAYMNT_HIST_UL" 
instead of update on FEM_PAYMNT_HIST_VL
referencing new as FEM_PAYMNT_HIST_B
for each row
begin
  FEM_PAYMNT_HIST_PKG.UPDATE_ROW(
    X_PAYMENT_HISTORY_CODE => :FEM_PAYMNT_HIST_B.PAYMENT_HISTORY_CODE,
    X_ENABLED_FLAG => :FEM_PAYMNT_HIST_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PAYMNT_HIST_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PAYMNT_HIST_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PAYMNT_HIST_B.OBJECT_VERSION_NUMBER,
    X_PAYMENT_HISTORY_NAME => :FEM_PAYMNT_HIST_B.PAYMENT_HISTORY_NAME,
    X_DESCRIPTION => :FEM_PAYMNT_HIST_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_PAYMNT_HIST_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PAYMNT_HIST_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PAYMNT_HIST_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PAYMNT_HIST_UL" ENABLE;
