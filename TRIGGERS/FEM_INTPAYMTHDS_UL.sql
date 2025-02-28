--------------------------------------------------------
--  DDL for Trigger FEM_INTPAYMTHDS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INTPAYMTHDS_UL" 
instead of update on FEM_INTPAYMTHDS_VL
referencing new as FEM_INTPAYMTHDS_B
for each row
begin
  FEM_INTPAYMTHDS_PKG.UPDATE_ROW(
    X_INT_PAYMENT_METHOD_CODE => :FEM_INTPAYMTHDS_B.INT_PAYMENT_METHOD_CODE,
    X_ENABLED_FLAG => :FEM_INTPAYMTHDS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_INTPAYMTHDS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_INTPAYMTHDS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_INTPAYMTHDS_B.OBJECT_VERSION_NUMBER,
    X_INT_PAYMENT_METHOD_NAME => :FEM_INTPAYMTHDS_B.INT_PAYMENT_METHOD_NAME,
    X_DESCRIPTION => :FEM_INTPAYMTHDS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_INTPAYMTHDS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_INTPAYMTHDS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_INTPAYMTHDS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INTPAYMTHDS_UL" ENABLE;
