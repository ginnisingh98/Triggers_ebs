--------------------------------------------------------
--  DDL for Trigger FEM_MAP_RULE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MAP_RULE_TYPES_DL" 
instead of delete on FEM_MAP_RULE_TYPES_VL
referencing old as FEM_MAP_RULE_TYPES_B
for each row
begin
  FEM_MAP_RULE_TYPES_PKG.DELETE_ROW(
    X_MAP_RULE_TYPE_CODE => :FEM_MAP_RULE_TYPES_B.MAP_RULE_TYPE_CODE);
 ---
end DELETE_ROW;
 ---

/
ALTER TRIGGER "APPS"."FEM_MAP_RULE_TYPES_DL" ENABLE;
