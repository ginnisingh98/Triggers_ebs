--------------------------------------------------------
--  DDL for Trigger FEM_CRDLF_INSCO_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CRDLF_INSCO_UL" 
instead of update on FEM_CRDLF_INSCO_VL
referencing new as FEM_CRDLF_INSCO_B
for each row
begin
  FEM_CRDLF_INSCO_PKG.UPDATE_ROW(
    X_CREDIT_LIFE_INS_CO_CODE => :FEM_CRDLF_INSCO_B.CREDIT_LIFE_INS_CO_CODE,
    X_ENABLED_FLAG => :FEM_CRDLF_INSCO_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_CRDLF_INSCO_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_CRDLF_INSCO_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_CRDLF_INSCO_B.OBJECT_VERSION_NUMBER,
    X_CREDIT_LIFE_INS_CO_NAME => :FEM_CRDLF_INSCO_B.CREDIT_LIFE_INS_CO_NAME,
    X_DESCRIPTION => :FEM_CRDLF_INSCO_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_CRDLF_INSCO_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_CRDLF_INSCO_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_CRDLF_INSCO_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CRDLF_INSCO_UL" ENABLE;
