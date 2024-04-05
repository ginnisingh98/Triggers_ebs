--------------------------------------------------------
--  DDL for Trigger FEM_APP_ANALYSTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_APP_ANALYSTS_DL" 
instead of delete on FEM_APP_ANALYSTS_VL
referencing old as FEM_APP_ANALYSTS_B
for each row
begin
  FEM_APP_ANALYSTS_PKG.DELETE_ROW(
    X_APPL_ANALYST_CODE => :FEM_APP_ANALYSTS_B.APPL_ANALYST_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_APP_ANALYSTS_DL" ENABLE;
