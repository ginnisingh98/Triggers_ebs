--------------------------------------------------------
--  DDL for Trigger FEM_ENTITIES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ENTITIES_DL" 
instead of delete on FEM_ENTITIES_VL
referencing old as FEM_ENTITIES_B
for each row
begin
  FEM_ENTITIES_PKG.DELETE_ROW(
    X_ENTITY_ID => :FEM_ENTITIES_B.ENTITY_ID,
    X_VALUE_SET_ID => :FEM_ENTITIES_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ENTITIES_DL" ENABLE;
