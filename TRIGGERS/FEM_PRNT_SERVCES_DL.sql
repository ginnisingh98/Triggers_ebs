--------------------------------------------------------
--  DDL for Trigger FEM_PRNT_SERVCES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PRNT_SERVCES_DL" 
instead of delete on FEM_PRNT_SERVCES_VL
referencing old as FEM_PRNT_SERVCES_B
for each row
begin
  FEM_PRNT_SERVCES_PKG.DELETE_ROW(
    X_PARENT_SERVICE_CODE => :FEM_PRNT_SERVCES_B.PARENT_SERVICE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PRNT_SERVCES_DL" ENABLE;
