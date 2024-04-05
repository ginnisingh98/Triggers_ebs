--------------------------------------------------------
--  DDL for Trigger FEM_OVRDRFT_PRT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_OVRDRFT_PRT_DL" 
instead of delete on FEM_OVRDRFT_PRT_VL
referencing old as FEM_OVRDRFT_PRT_B
for each row
begin
  FEM_OVRDRFT_PRT_PKG.DELETE_ROW(
    X_OD_PROTECTION_ID => :FEM_OVRDRFT_PRT_B.OD_PROTECTION_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_OVRDRFT_PRT_DL" ENABLE;
