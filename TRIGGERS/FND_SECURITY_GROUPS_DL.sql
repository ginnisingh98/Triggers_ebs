--------------------------------------------------------
--  DDL for Trigger FND_SECURITY_GROUPS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_SECURITY_GROUPS_DL" 
instead of delete on FND_SECURITY_GROUPS_VL
referencing old as SECURITY_GROUPS
for each row

begin
  FND_SECURITY_GROUPS_PKG.DELETE_ROW(
    X_SECURITY_GROUP_ID => :SECURITY_GROUPS.SECURITY_GROUP_ID);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."FND_SECURITY_GROUPS_DL" ENABLE;
