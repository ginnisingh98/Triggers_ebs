--------------------------------------------------------
--  DDL for Trigger FEM_OBJECT_CATALOG_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OBJECT_CATALOG_DL" 
instead of delete on FEM_OBJECT_CATALOG_VL
referencing old as FEM_OBJECT_CATALOG_B
for each row
begin
  FEM_OBJECT_CATALOG_PKG.DELETE_ROW(
    X_OBJECT_ID => :FEM_OBJECT_CATALOG_B.OBJECT_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OBJECT_CATALOG_DL" ENABLE;
