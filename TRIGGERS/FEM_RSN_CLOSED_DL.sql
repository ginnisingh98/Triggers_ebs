--------------------------------------------------------
--  DDL for Trigger FEM_RSN_CLOSED_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_RSN_CLOSED_DL" 
instead of delete on FEM_RSN_CLOSED_VL
referencing old as FEM_RSN_CLOSED_B
for each row
begin
  FEM_RSN_CLOSED_PKG.DELETE_ROW(
    X_REASON_CLOSED_CODE => :FEM_RSN_CLOSED_B.REASON_CLOSED_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_RSN_CLOSED_DL" ENABLE;
