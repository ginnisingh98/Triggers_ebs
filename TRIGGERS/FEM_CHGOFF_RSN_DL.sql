--------------------------------------------------------
--  DDL for Trigger FEM_CHGOFF_RSN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CHGOFF_RSN_DL" 
instead of delete on FEM_CHGOFF_RSN_VL
referencing old as FEM_CHGOFF_RSN_B
for each row
begin
  FEM_CHGOFF_RSN_PKG.DELETE_ROW(
    X_CHARGE_OFF_REASON_CODE => :FEM_CHGOFF_RSN_B.CHARGE_OFF_REASON_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CHGOFF_RSN_DL" ENABLE;
