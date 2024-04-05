--------------------------------------------------------
--  DDL for Trigger FEM_EXIST_BORWR_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_EXIST_BORWR_DL" 
instead of delete on FEM_EXIST_BORWR_VL
referencing old as FEM_EXIST_BORWR_B
for each row
begin
  FEM_EXIST_BORWR_PKG.DELETE_ROW(
    X_EXIST_BORROWER_ID => :FEM_EXIST_BORWR_B.EXIST_BORROWER_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_EXIST_BORWR_DL" ENABLE;
