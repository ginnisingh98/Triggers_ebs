--------------------------------------------------------
--  DDL for Trigger FEM_DB_LINKS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DB_LINKS_DL" 
instead of delete on FEM_DB_LINKS_VL
referencing old as FEM_DB_LINKS_B
for each row
begin
  FEM_DB_LINKS_PKG.DELETE_ROW(
    X_DATABASE_LINK => :FEM_DB_LINKS_B.DATABASE_LINK);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DB_LINKS_DL" ENABLE;
