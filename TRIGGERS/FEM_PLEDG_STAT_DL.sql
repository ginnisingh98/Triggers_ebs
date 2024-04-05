--------------------------------------------------------
--  DDL for Trigger FEM_PLEDG_STAT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PLEDG_STAT_DL" 
instead of delete on FEM_PLEDG_STAT_VL
referencing old as FEM_PLEDG_STAT_B
for each row
begin
  FEM_PLEDG_STAT_PKG.DELETE_ROW(
    X_PLEDGED_STATUS_ID => :FEM_PLEDG_STAT_B.PLEDGED_STATUS_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PLEDG_STAT_DL" ENABLE;
