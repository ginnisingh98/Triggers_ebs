--------------------------------------------------------
--  DDL for Trigger GMA_SY_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_SY_TEXT_TBL_T3" 
instead of delete on SY_TEXT_TBL_VL
referencing old as SY_TEXT_TBL
for each row
begin
  GMA_SY_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :SY_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :SY_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :SY_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :SY_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :SY_TEXT_TBL.LINE_NO,
    X_ROW_ID => :SY_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_SY_TEXT_TBL_T3" ENABLE;
