--------------------------------------------------------
--  DDL for Trigger FEM_DISBMTHDS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DISBMTHDS_DL" 
instead of delete on FEM_DISBMTHDS_VL
referencing old as FEM_DISBMTHDS_B
for each row
begin
  FEM_DISBMTHDS_PKG.DELETE_ROW(
    X_DISBURS_METHOD_CODE => :FEM_DISBMTHDS_B.DISBURS_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DISBMTHDS_DL" ENABLE;
