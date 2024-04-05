--------------------------------------------------------
--  DDL for Trigger XDO_FONT_MAPPING_SETS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XDO_FONT_MAPPING_SETS_UL" 
instead of update on XDO_FONT_MAPPING_SETS_VL
referencing new as NEWROW
for each row
begin
  XDO_FONT_MAPPING_SETS_PKG.UPDATE_ROW(
          P_MAPPING_CODE => :NEWROW.MAPPING_CODE,
          P_MAPPING_NAME => :NEWROW.MAPPING_NAME,
          P_MAPPING_TYPE  => :NEWROW.MAPPING_TYPE,
          P_LAST_UPDATE_DATE => :NEWROW.LAST_UPDATE_DATE,
          P_LAST_UPDATED_BY => :NEWROW.LAST_UPDATED_BY,
          P_LAST_UPDATE_LOGIN => :NEWROW.LAST_UPDATE_LOGIN);
end UPDATE_ROW;


/
ALTER TRIGGER "APPS"."XDO_FONT_MAPPING_SETS_UL" ENABLE;
