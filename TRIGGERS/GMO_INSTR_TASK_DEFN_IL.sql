--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_TASK_DEFN_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_TASK_DEFN_IL" 
/* $Header: GMOTSKIT.sql 120.0.12000000.2 2007/03/14 12:00:34 rvsingh ship $ */

instead of insert on GMO_INSTR_TASK_DEFN_VL
referencing new as GMO_INSTR_TASK_DEFN_B
for each row
declare
  row_id rowid;
begin
  GMO_INSTR_TASK_DEFN_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_TASK_ID => :GMO_INSTR_TASK_DEFN_B.TASK_ID,
    X_ENTITY_NAME => :GMO_INSTR_TASK_DEFN_B.ENTITY_NAME,
    X_INSTRUCTION_TYPE => :GMO_INSTR_TASK_DEFN_B.INSTRUCTION_TYPE,
    X_TASK_NAME => :GMO_INSTR_TASK_DEFN_B.TASK_NAME,
    X_TASK_TYPE => :GMO_INSTR_TASK_DEFN_B.TASK_TYPE,
    X_TARGET => :GMO_INSTR_TASK_DEFN_B.TARGET,
    X_ATTRIBUTE_SQL => :GMO_INSTR_TASK_DEFN_B.ATTRIBUTE_SQL,
    X_ATTRIBUTE_DISPLAY_COL_COUNT => :GMO_INSTR_TASK_DEFN_B.ATTRIBUTE_DISPLAY_COL_COUNT,
    X_MAX_ALLOWED_TASK             => :GMO_INSTR_TASK_DEFN_B.MAX_ALLOWED_TASK,
    X_ENTITY_KEY_PATTERN => :GMO_INSTR_TASK_DEFN_B.ENTITY_KEY_PATTERN,
    X_DISPLAY_NAME => :GMO_INSTR_TASK_DEFN_B.DISPLAY_NAME,
    X_CREATION_DATE => :GMO_INSTR_TASK_DEFN_B.CREATION_DATE,
    X_CREATED_BY => :GMO_INSTR_TASK_DEFN_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :GMO_INSTR_TASK_DEFN_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :GMO_INSTR_TASK_DEFN_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :GMO_INSTR_TASK_DEFN_B.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_TASK_DEFN_IL" ENABLE;
