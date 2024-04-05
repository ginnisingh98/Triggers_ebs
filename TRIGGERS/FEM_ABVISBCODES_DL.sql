--------------------------------------------------------
--  DDL for Trigger FEM_ABVISBCODES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ABVISBCODES_DL" 
instead of delete on FEM_ABVISBCODES_VL
referencing old as FEM_ABVISBCODES_B
for each row
begin
  FEM_ABVISBCODES_PKG.DELETE_ROW(
    X_AB_VISIBILITY_CODE => :FEM_ABVISBCODES_B.AB_VISIBILITY_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ABVISBCODES_DL" ENABLE;
