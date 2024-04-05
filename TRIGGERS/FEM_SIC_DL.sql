--------------------------------------------------------
--  DDL for Trigger FEM_SIC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SIC_DL" 
instead of delete on FEM_SIC_VL
referencing old as FEM_SIC_B
for each row
begin
  FEM_SIC_PKG.DELETE_ROW(
    X_SIC_ID => :FEM_SIC_B.SIC_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SIC_DL" ENABLE;
