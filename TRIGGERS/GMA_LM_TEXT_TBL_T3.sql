--------------------------------------------------------
--  DDL for Trigger GMA_LM_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_LM_TEXT_TBL_T3" 
instead of delete on LM_TEXT_TBL_VL
referencing old as LM_TEXT_TBL
for each row
begin
  GMA_LM_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :LM_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :LM_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :LM_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :LM_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :LM_TEXT_TBL.LINE_NO,
    X_ROW_ID => :LM_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_LM_TEXT_TBL_T3" ENABLE;
