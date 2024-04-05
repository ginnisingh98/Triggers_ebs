--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_SET_INSTANCE_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_SET_INSTANCE_UL" 
/* $Header: GMOINTUT.sql 120.0 2005/06/29 04:22 shthakke noship $ */

instead of update on GMO_INSTR_SET_INSTANCE_VL
referencing new as GMO_INSTR_SET_INSTANCE_B
for each row
begin
  GMO_INSTR_SET_INSTANCE_PKG.UPDATE_ROW(
    X_INSTRUCTION_SET_ID => :GMO_INSTR_SET_INSTANCE_B.INSTRUCTION_SET_ID,
    X_INSTR_SET_STATUS => :GMO_INSTR_SET_INSTANCE_B.INSTR_SET_STATUS,
    X_INSTRUCTION_TYPE => :GMO_INSTR_SET_INSTANCE_B.INSTRUCTION_TYPE,
    X_INSTR_SET_NAME => :GMO_INSTR_SET_INSTANCE_B.INSTR_SET_NAME,
    X_ENTITY_NAME => :GMO_INSTR_SET_INSTANCE_B.ENTITY_NAME,
    X_ENTITY_KEY => :GMO_INSTR_SET_INSTANCE_B.ENTITY_KEY,
    X_ACKN_STATUS => :GMO_INSTR_SET_INSTANCE_B.ACKN_STATUS,
    X_ORIG_SOURCE => :GMO_INSTR_SET_INSTANCE_B.ORIG_SOURCE,
    X_ORIG_SOURCE_ID => :GMO_INSTR_SET_INSTANCE_B.ORIG_SOURCE_ID,
    X_INSTR_SET_DESC => :GMO_INSTR_SET_INSTANCE_B.INSTR_SET_DESC,
    X_LAST_UPDATE_DATE => :GMO_INSTR_SET_INSTANCE_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :GMO_INSTR_SET_INSTANCE_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :GMO_INSTR_SET_INSTANCE_B.LAST_UPDATE_LOGIN);
end UPDATE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_SET_INSTANCE_UL" ENABLE;
