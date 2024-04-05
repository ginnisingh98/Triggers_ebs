--------------------------------------------------------
--  DDL for Trigger FEM_SERV_OPTN_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SERV_OPTN_DL" 
instead of delete on FEM_SERV_OPTN_VL
referencing old as FEM_SERV_OPTN_B
for each row
begin
  FEM_SERV_OPTN_PKG.DELETE_ROW(
    X_SERVICE_OPTION_CODE => :FEM_SERV_OPTN_B.SERVICE_OPTION_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SERV_OPTN_DL" ENABLE;
