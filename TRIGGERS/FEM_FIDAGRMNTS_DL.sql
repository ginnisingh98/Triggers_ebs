--------------------------------------------------------
--  DDL for Trigger FEM_FIDAGRMNTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FIDAGRMNTS_DL" 
instead of delete on FEM_FIDAGRMNTS_VL
referencing old as FEM_FIDAGRMNTS_B
for each row
begin
  FEM_FIDAGRMNTS_PKG.DELETE_ROW(
    X_FIDUCIARY_AGREEMENT_CODE => :FEM_FIDAGRMNTS_B.FIDUCIARY_AGREEMENT_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FIDAGRMNTS_DL" ENABLE;
