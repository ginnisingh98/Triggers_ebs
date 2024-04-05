--------------------------------------------------------
--  DDL for Trigger GMA_FC_TEXT_TBL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_FC_TEXT_TBL_T1" 
instead of insert on FC_TEXT_TBL_VL
referencing new as FC_TEXT_TBL
for each row
declare
  row_id rowid;
begin
  GMA_FC_TEXT_TBL_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TEXT_CODE => :FC_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :FC_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :FC_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :FC_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :FC_TEXT_TBL.LINE_NO,
    X_TEXT => :FC_TEXT_TBL.TEXT,
    X_CREATION_DATE => :FC_TEXT_TBL.CREATION_DATE,
    X_CREATED_BY => :FC_TEXT_TBL.CREATED_BY,
    X_LAST_UPDATE_DATE => :FC_TEXT_TBL.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FC_TEXT_TBL.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FC_TEXT_TBL.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."GMA_FC_TEXT_TBL_T1" ENABLE;
