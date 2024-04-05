--------------------------------------------------------
--  DDL for Trigger GMA_SY_TEXT_TKN_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_SY_TEXT_TKN_T1" 
instead of insert on SY_TEXT_TKN_VL
referencing new as SY_TEXT_TKN
for each row
declare
  row_id rowid;
begin
  GMA_SY_TEXT_TKN_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TEXT_KEY => :SY_TEXT_TKN.TEXT_KEY,
    X_LANG_CODE => :SY_TEXT_TKN.LANG_CODE,
    X_TEXT_CODE => :SY_TEXT_TKN.TEXT_CODE,
    X_TOKEN_DESC => :SY_TEXT_TKN.TOKEN_DESC,
    X_CREATION_DATE => :SY_TEXT_TKN.CREATION_DATE,
    X_CREATED_BY => :SY_TEXT_TKN.CREATED_BY,
    X_LAST_UPDATE_DATE => :SY_TEXT_TKN.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :SY_TEXT_TKN.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :SY_TEXT_TKN.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."GMA_SY_TEXT_TKN_T1" ENABLE;
