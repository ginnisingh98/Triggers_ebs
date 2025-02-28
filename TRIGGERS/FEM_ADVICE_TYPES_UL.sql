--------------------------------------------------------
--  DDL for Trigger FEM_ADVICE_TYPES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ADVICE_TYPES_UL" 
instead of update on FEM_ADVICE_TYPES_VL
referencing new as FEM_ADVICE_TYPES_B
for each row
begin
  FEM_ADVICE_TYPES_PKG.UPDATE_ROW(
    X_ADVICE_TYPE_CODE => :FEM_ADVICE_TYPES_B.ADVICE_TYPE_CODE,
    X_ENABLED_FLAG => :FEM_ADVICE_TYPES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_ADVICE_TYPES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_ADVICE_TYPES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_ADVICE_TYPES_B.OBJECT_VERSION_NUMBER,
    X_ADVICE_TYPE_NAME => :FEM_ADVICE_TYPES_B.ADVICE_TYPE_NAME,
    X_DESCRIPTION => :FEM_ADVICE_TYPES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_ADVICE_TYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_ADVICE_TYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_ADVICE_TYPES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ADVICE_TYPES_UL" ENABLE;
