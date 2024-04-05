--------------------------------------------------------
--  DDL for Trigger FEM_SERV_SRC_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SERV_SRC_DL" 
instead of delete on FEM_SERV_SRC_VL
referencing old as FEM_SERV_SRC_B
for each row
begin
  FEM_SERV_SRC_PKG.DELETE_ROW(
    X_SERVICE_SOURCE_CODE => :FEM_SERV_SRC_B.SERVICE_SOURCE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SERV_SRC_DL" ENABLE;
