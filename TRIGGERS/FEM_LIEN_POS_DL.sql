--------------------------------------------------------
--  DDL for Trigger FEM_LIEN_POS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LIEN_POS_DL" 
instead of delete on FEM_LIEN_POS_VL
referencing old as FEM_LIEN_POS_B
for each row
begin
  FEM_LIEN_POS_PKG.DELETE_ROW(
    X_LIEN_POSITION_ID => :FEM_LIEN_POS_B.LIEN_POSITION_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_LIEN_POS_DL" ENABLE;
