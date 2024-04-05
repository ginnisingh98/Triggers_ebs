--------------------------------------------------------
--  DDL for Trigger GMA_LM_TEXT_TBL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_LM_TEXT_TBL_T1" 
instead of insert on LM_TEXT_TBL_VL
referencing new as LM_TEXT_TBL
for each row
declare
  row_id rowid;
begin
  GMA_LM_TEXT_TBL_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TEXT_CODE => :LM_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :LM_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :LM_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :LM_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :LM_TEXT_TBL.LINE_NO,
    X_TEXT => :LM_TEXT_TBL.TEXT,
    X_CREATION_DATE => :LM_TEXT_TBL.CREATION_DATE,
    X_CREATED_BY => :LM_TEXT_TBL.CREATED_BY,
    X_LAST_UPDATE_DATE => :LM_TEXT_TBL.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :LM_TEXT_TBL.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :LM_TEXT_TBL.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."GMA_LM_TEXT_TBL_T1" ENABLE;
