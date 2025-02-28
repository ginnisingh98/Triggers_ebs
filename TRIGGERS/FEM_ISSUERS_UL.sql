--------------------------------------------------------
--  DDL for Trigger FEM_ISSUERS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ISSUERS_UL" 
instead of update on FEM_ISSUERS_VL
referencing new as FEM_ISSUERS_B
for each row
begin
  FEM_ISSUERS_PKG.UPDATE_ROW(
    X_ISSUER_ID => :FEM_ISSUERS_B.ISSUER_ID,
    X_ISSUER_DISPLAY_CODE => :FEM_ISSUERS_B.ISSUER_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_ISSUERS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_ISSUERS_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_ISSUERS_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_ISSUERS_B.OBJECT_VERSION_NUMBER,
    X_ISSUER_NAME => :FEM_ISSUERS_B.ISSUER_NAME,
    X_DESCRIPTION => :FEM_ISSUERS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_ISSUERS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_ISSUERS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_ISSUERS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ISSUERS_UL" ENABLE;
