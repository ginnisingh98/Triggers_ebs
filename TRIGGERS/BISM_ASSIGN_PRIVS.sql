--------------------------------------------------------
--  DDL for Trigger BISM_ASSIGN_PRIVS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BISM_ASSIGN_PRIVS" 
after insert on "APPLSYS"."BISM_OBJECTS"
/* $Header: bism_triggers.sql 120.3 2006/04/06 02:26:26 akbansal noship $ */
for each row
declare
  type sub_t is table of BISM_PERMISSIONS.SUBJECT_ID%type;
  type priv_t is table of BISM_PERMISSIONS.PRIVILEGE%type;
  sub_var sub_t := sub_t();
  priv_var priv_t := priv_t();
begin

  select subject_id,privilege bulk collect
    into sub_var,priv_var
    from bism_permissions
   where object_id = :new.folder_id;

  if :new.object_type_id = 100 then
    for i in sub_var.FIRST..sub_var.LAST loop
      insert into bism_permissions (SUBJECT_ID, OBJECT_ID, PRIVILEGE) values(sub_var(i),:new.object_id,priv_var(i));
    end loop;
  else
    for i in sub_var.FIRST..sub_var.LAST loop
    -- for objects, map ADD_FOLDER privilege to READ privilege, LIST privilege to no access
    -- do not assign privilege if it is LIST privilege
      if priv_var(i) > 10 then
        if priv_var(i) = 30 then
          insert into bism_permissions (SUBJECT_ID, OBJECT_ID, PRIVILEGE) values(sub_var(i),:new.object_id,20);
        else
          insert into bism_permissions (SUBJECT_ID, OBJECT_ID, PRIVILEGE) values(sub_var(i),:new.object_id,priv_var(i));
        end if;
      end if;
    end loop;
  end if;

end;


/
ALTER TRIGGER "APPS"."BISM_ASSIGN_PRIVS" ENABLE;
