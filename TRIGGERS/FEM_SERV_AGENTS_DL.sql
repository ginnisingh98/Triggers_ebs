--------------------------------------------------------
--  DDL for Trigger FEM_SERV_AGENTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_SERV_AGENTS_DL" 
instead of delete on FEM_SERV_AGENTS_VL
referencing old as FEM_SERV_AGENTS_B
for each row
begin
  FEM_SERV_AGENTS_PKG.DELETE_ROW(
    X_SERVICING_AGENT_ID => :FEM_SERV_AGENTS_B.SERVICING_AGENT_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_SERV_AGENTS_DL" ENABLE;
