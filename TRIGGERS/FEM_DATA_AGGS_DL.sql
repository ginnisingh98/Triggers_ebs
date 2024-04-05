--------------------------------------------------------
--  DDL for Trigger FEM_DATA_AGGS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DATA_AGGS_DL" 
instead of delete on FEM_DATA_AGGS_VL
referencing old as FEM_DATA_AGGS_B
for each row
begin
  FEM_DATA_AGGS_PKG.DELETE_ROW(
    X_DATA_AGGREG_TYPE_CODE => :FEM_DATA_AGGS_B.DATA_AGGREG_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DATA_AGGS_DL" ENABLE;
