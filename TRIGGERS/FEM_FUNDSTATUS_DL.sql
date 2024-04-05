--------------------------------------------------------
--  DDL for Trigger FEM_FUNDSTATUS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FUNDSTATUS_DL" 
instead of delete on FEM_FUNDSTATUS_VL
referencing old as FEM_FUNDSTATUS_B
for each row
begin
  FEM_FUNDSTATUS_PKG.DELETE_ROW(
    X_FUNDING_STATUS_CODE => :FEM_FUNDSTATUS_B.FUNDING_STATUS_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FUNDSTATUS_DL" ENABLE;
