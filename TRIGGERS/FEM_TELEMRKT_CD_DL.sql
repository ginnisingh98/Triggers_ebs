--------------------------------------------------------
--  DDL for Trigger FEM_TELEMRKT_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TELEMRKT_CD_DL" 
instead of delete on FEM_TELEMRKT_CD_VL
referencing old as FEM_TELEMRKT_CD_B
for each row
begin
  FEM_TELEMRKT_CD_PKG.DELETE_ROW(
    X_TELEMARKET_CD_CODE => :FEM_TELEMRKT_CD_B.TELEMARKET_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TELEMRKT_CD_DL" ENABLE;
