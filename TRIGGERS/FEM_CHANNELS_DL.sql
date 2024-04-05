--------------------------------------------------------
--  DDL for Trigger FEM_CHANNELS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CHANNELS_DL" 
instead of delete on FEM_CHANNELS_VL
referencing old as FEM_CHANNELS_B
for each row
begin
  FEM_CHANNELS_PKG.DELETE_ROW(
    X_CHANNEL_ID => :FEM_CHANNELS_B.CHANNEL_ID,
    X_VALUE_SET_ID => :FEM_CHANNELS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CHANNELS_DL" ENABLE;
