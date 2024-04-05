--------------------------------------------------------
--  DDL for Trigger FEM_TASKS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TASKS_DL" 
instead of delete on FEM_TASKS_VL
referencing old as FEM_TASKS_B
for each row
begin
  FEM_TASKS_PKG.DELETE_ROW(
    X_TASK_ID => :FEM_TASKS_B.TASK_ID,
    X_VALUE_SET_ID => :FEM_TASKS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TASKS_DL" ENABLE;
