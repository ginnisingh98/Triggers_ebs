--------------------------------------------------------
--  DDL for Trigger FEM_DB_LINKS_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DB_LINKS_UL" 
instead of update on FEM_DB_LINKS_VL
referencing new as FEM_DB_LINKS_B
for each row
begin
  FEM_DB_LINKS_PKG.UPDATE_ROW(
    X_DATABASE_LINK => :FEM_DB_LINKS_B.DATABASE_LINK,
    X_MIG_WF_OUT_AGENT_IN_LOCAL_DB => :FEM_DB_LINKS_B.MIG_WF_OUT_AGENT_IN_LOCAL_DB,
    X_MIG_WF_IN_AGENT_IN_LINKED_DB => :FEM_DB_LINKS_B.MIG_WF_IN_AGENT_IN_LINKED_DB,
    X_OBJECT_VERSION_NUMBER => :FEM_DB_LINKS_B.OBJECT_VERSION_NUMBER,
    X_DB_LINK_NAME => :FEM_DB_LINKS_B.DB_LINK_NAME,
    X_DESCRIPTION => :FEM_DB_LINKS_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_DB_LINKS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_DB_LINKS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_DB_LINKS_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DB_LINKS_UL" ENABLE;
