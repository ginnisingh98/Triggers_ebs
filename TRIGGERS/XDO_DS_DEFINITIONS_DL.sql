--------------------------------------------------------
--  DDL for Trigger XDO_DS_DEFINITIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XDO_DS_DEFINITIONS_DL" 
instead of delete on XDO_DS_DEFINITIONS_VL
referencing old as XDO_DS_DEFINITIONS_TH
for each row
begin
  XDO_DS_DEFINITIONS_PKG.DELETE_ROW(
  X_APPLICATION_SHORT_NAME => :XDO_DS_DEFINITIONS_TH.APPLICATION_SHORT_NAME,
  X_DATA_SOURCE_CODE => :XDO_DS_DEFINITIONS_TH.DATA_SOURCE_CODE
);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."XDO_DS_DEFINITIONS_DL" ENABLE;
