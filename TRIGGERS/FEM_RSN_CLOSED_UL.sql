--------------------------------------------------------
--  DDL for Trigger FEM_RSN_CLOSED_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_RSN_CLOSED_UL" 
instead of update on FEM_RSN_CLOSED_VL
referencing new as FEM_RSN_CLOSED_B
for each row
begin
  FEM_RSN_CLOSED_PKG.UPDATE_ROW(
    X_REASON_CLOSED_CODE => :FEM_RSN_CLOSED_B.REASON_CLOSED_CODE,
    X_ENABLED_FLAG => :FEM_RSN_CLOSED_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_RSN_CLOSED_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_RSN_CLOSED_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_RSN_CLOSED_B.OBJECT_VERSION_NUMBER,
    X_REASON_CLOSED_NAME => :FEM_RSN_CLOSED_B.REASON_CLOSED_NAME,
    X_DESCRIPTION => :FEM_RSN_CLOSED_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_RSN_CLOSED_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_RSN_CLOSED_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_RSN_CLOSED_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_RSN_CLOSED_UL" ENABLE;
