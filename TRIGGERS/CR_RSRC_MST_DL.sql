--------------------------------------------------------
--  DDL for Trigger CR_RSRC_MST_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CR_RSRC_MST_DL" 
instead of delete on CR_RSRC_MST_VL
referencing old as CR_RSRC_MST
for each row
begin
  CR_RSRC_MST_PKG.DELETE_ROW(
    X_RESOURCES => :CR_RSRC_MST.RESOURCES);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."CR_RSRC_MST_DL" ENABLE;
