--------------------------------------------------------
--  DDL for Trigger FEM_MARITAL_STS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_MARITAL_STS_DL" 
instead of delete on FEM_MARITAL_STS_VL
referencing old as FEM_MARITAL_STS_B
for each row
begin
  FEM_MARITAL_STS_PKG.DELETE_ROW(
    X_MARITAL_STATUS_CODE => :FEM_MARITAL_STS_B.MARITAL_STATUS_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_MARITAL_STS_DL" ENABLE;
