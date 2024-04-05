--------------------------------------------------------
--  DDL for Trigger GMA_PS_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_PS_TEXT_TBL_T3" 
instead of delete on PS_TEXT_TBL_VL
referencing old as PS_TEXT_TBL
for each row
begin
  GMA_PS_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :PS_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :PS_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :PS_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :PS_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :PS_TEXT_TBL.LINE_NO,
    X_ROW_ID => :PS_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_PS_TEXT_TBL_T3" ENABLE;
