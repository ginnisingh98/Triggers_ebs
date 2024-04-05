--------------------------------------------------------
--  DDL for Trigger GMO_INSTR_SET_DEFN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMO_INSTR_SET_DEFN_DL" 
/* $Header: GMOINSDT.sql 120.0 2005/06/29 04:21 shthakke noship $ */

instead of delete on GMO_INSTR_SET_DEFN_VL
referencing old as GMO_INSTR_SET_DEFN
for each row
begin
   GMO_INSTR_SET_DEFN_PKG.DELETE_ROW(
      X_INSTRUCTION_SET_ID => :GMO_INSTR_SET_DEFN.INSTRUCTION_SET_ID);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."GMO_INSTR_SET_DEFN_DL" ENABLE;
