--------------------------------------------------------
--  DDL for Trigger WMS_WP_WAVE_HEADERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WMS_WP_WAVE_HEADERS_DL" 
 

instead of delete on WMS_WP_WAVE_HEADERS_VL
referencing old as WAVE_HEADERS
for each row
begin
  WMS_WP_WAVE_HEADERS_PKG.DELETE_ROW(
    X_WAVE_HEADER_ID => :WAVE_HEADERS.WAVE_HEADER_ID);
end DELETE_ROW;

   

/
ALTER TRIGGER "APPS"."WMS_WP_WAVE_HEADERS_DL" ENABLE;
