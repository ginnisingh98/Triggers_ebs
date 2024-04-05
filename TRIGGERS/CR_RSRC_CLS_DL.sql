--------------------------------------------------------
--  DDL for Trigger CR_RSRC_CLS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CR_RSRC_CLS_DL" 
instead of delete on CR_RSRC_CLS_VL
referencing old as CR_RSRC_CLS
for each row
begin
  CR_RSRC_CLS_PKG.DELETE_ROW(
    X_RESOURCE_CLASS => :CR_RSRC_CLS.RESOURCE_CLASS);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."CR_RSRC_CLS_DL" ENABLE;
