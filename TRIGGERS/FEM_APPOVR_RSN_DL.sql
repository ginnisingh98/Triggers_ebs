--------------------------------------------------------
--  DDL for Trigger FEM_APPOVR_RSN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_APPOVR_RSN_DL" 
instead of delete on FEM_APPOVR_RSN_VL
referencing old as FEM_APPOVR_RSN_B
for each row
begin
  FEM_APPOVR_RSN_PKG.DELETE_ROW(
    X_APPL_OVERRIDE_REASON_CODE => :FEM_APPOVR_RSN_B.APPL_OVERRIDE_REASON_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_APPOVR_RSN_DL" ENABLE;
