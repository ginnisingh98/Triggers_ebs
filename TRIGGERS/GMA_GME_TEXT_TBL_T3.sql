--------------------------------------------------------
--  DDL for Trigger GMA_GME_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_GME_TEXT_TBL_T3" 
instead of delete on GME_TEXT_TABLE_VL
referencing old as GME_TEXT_TABLE
for each row
begin
  GMA_GME_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :GME_TEXT_TABLE.TEXT_CODE,
    X_LANG_CODE => :GME_TEXT_TABLE.LANG_CODE,
    X_PARAGRAPH_CODE => :GME_TEXT_TABLE.PARAGRAPH_CODE,
    X_SUB_PARACODE => :GME_TEXT_TABLE.SUB_PARACODE,
    X_LINE_NO => :GME_TEXT_TABLE.LINE_NO,
    X_ROW_ID => :GME_TEXT_TABLE.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_GME_TEXT_TBL_T3" ENABLE;
