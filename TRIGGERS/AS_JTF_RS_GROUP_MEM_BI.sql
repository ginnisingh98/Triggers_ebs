--------------------------------------------------------
--  DDL for Trigger AS_JTF_RS_GROUP_MEM_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AS_JTF_RS_GROUP_MEM_BI" BEFORE INSERT
ON JTF.JTF_RS_GROUP_MEMBERS_AUD
FOR EACH ROW

DECLARE
Trigger_Mode VARCHAR(20);
BEGIN
  if INSERTING then
   Trigger_Mode := 'ON-INSERT';
  else
   Return;
  end if;
  AS_JTF_RS_GROUP_MEM_TRG.Group_Mem_Trigger_Handler(
							:new.group_member_id,
							:new.new_group_id,
							:new.old_group_id,
							:new.new_resource_id,
							:new.old_resource_id,
							Trigger_Mode);

END AS_JTF_RS_GROUP_MEM_BI;



/
ALTER TRIGGER "APPS"."AS_JTF_RS_GROUP_MEM_BI" ENABLE;
