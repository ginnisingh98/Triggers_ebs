--------------------------------------------------------
--  DDL for Trigger GMA_SY_TEXT_TKN_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMA_SY_TEXT_TKN_T3" 
instead of delete on SY_TEXT_TKN_VL
referencing old as SY_TEXT_TKN
for each row
begin
  GMA_SY_TEXT_TKN_PKG.DELETE_ROW(
    X_TEXT_KEY => :SY_TEXT_TKN.TEXT_KEY,
    X_LANG_CODE => :SY_TEXT_TKN.LANG_CODE);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMA_SY_TEXT_TKN_T3" ENABLE;
