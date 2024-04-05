--------------------------------------------------------
--  DDL for Trigger FEM_BUS_REL_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUS_REL_DL" 
instead of delete on FEM_BUS_REL_VL
referencing old as FEM_BUS_REL_B
for each row
begin
  FEM_BUS_REL_PKG.DELETE_ROW(
    X_BUS_REL_ID => :FEM_BUS_REL_B.BUS_REL_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BUS_REL_DL" ENABLE;
