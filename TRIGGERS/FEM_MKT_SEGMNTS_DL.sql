--------------------------------------------------------
--  DDL for Trigger FEM_MKT_SEGMNTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MKT_SEGMNTS_DL" 
instead of delete on FEM_MKT_SEGMNTS_VL
referencing old as FEM_MKT_SEGMNTS_B
for each row
begin
  FEM_MKT_SEGMNTS_PKG.DELETE_ROW(
    X_MARKET_SEGMENT_ID => :FEM_MKT_SEGMNTS_B.MARKET_SEGMENT_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MKT_SEGMNTS_DL" ENABLE;
