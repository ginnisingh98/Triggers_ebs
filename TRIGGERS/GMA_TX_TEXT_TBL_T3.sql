--------------------------------------------------------
--  DDL for Trigger GMA_TX_TEXT_TBL_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_TX_TEXT_TBL_T3" 
instead of delete on TX_TEXT_TBL_VL
referencing old as TX_TEXT_TBL
for each row
begin
  GMA_TX_TEXT_TBL_PKG.DELETE_ROW(
    X_TEXT_CODE => :TX_TEXT_TBL.TEXT_CODE,
    X_LANG_CODE => :TX_TEXT_TBL.LANG_CODE,
    X_PARAGRAPH_CODE => :TX_TEXT_TBL.PARAGRAPH_CODE,
    X_SUB_PARACODE => :TX_TEXT_TBL.SUB_PARACODE,
    X_LINE_NO => :TX_TEXT_TBL.LINE_NO,
    X_ROW_ID => :TX_TEXT_TBL.ROW_ID);
-- Bug #1806284 (JKB)
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_TX_TEXT_TBL_T3" ENABLE;
