--------------------------------------------------------
--  DDL for Trigger FEM_CRED_CRD_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CRED_CRD_CD_DL" 
instead of delete on FEM_CRED_CRD_CD_VL
referencing old as FEM_CRED_CRD_CD_B
for each row
begin
  FEM_CRED_CRD_CD_PKG.DELETE_ROW(
    X_CRED_CARD_CD_CODE => :FEM_CRED_CRD_CD_B.CRED_CARD_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CRED_CRD_CD_DL" ENABLE;
