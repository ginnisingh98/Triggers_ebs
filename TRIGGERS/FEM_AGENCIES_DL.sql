--------------------------------------------------------
--  DDL for Trigger FEM_AGENCIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGENCIES_DL" 
instead of delete on FEM_AGENCIES_VL
referencing old as FEM_AGENCIES_B
for each row
begin
  FEM_AGENCIES_PKG.DELETE_ROW(
    X_AGENCY_ID => :FEM_AGENCIES_B.AGENCY_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGENCIES_DL" ENABLE;
