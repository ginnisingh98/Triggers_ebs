--------------------------------------------------------
--  DDL for Trigger FEM_ISSUERS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ISSUERS_DL" 
instead of delete on FEM_ISSUERS_VL
referencing old as FEM_ISSUERS_B
for each row
begin
  FEM_ISSUERS_PKG.DELETE_ROW(
    X_ISSUER_ID => :FEM_ISSUERS_B.ISSUER_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ISSUERS_DL" ENABLE;
