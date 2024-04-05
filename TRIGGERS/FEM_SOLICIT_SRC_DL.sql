--------------------------------------------------------
--  DDL for Trigger FEM_SOLICIT_SRC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SOLICIT_SRC_DL" 
instead of delete on FEM_SOLICIT_SRC_VL
referencing old as FEM_SOLICIT_SRC_B
for each row
begin
  FEM_SOLICIT_SRC_PKG.DELETE_ROW(
    X_SOLICIT_SOURCE_ID => :FEM_SOLICIT_SRC_B.SOLICIT_SOURCE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SOLICIT_SRC_DL" ENABLE;
