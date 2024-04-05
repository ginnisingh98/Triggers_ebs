--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOX_USERS_AU_STM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOX_USERS_AU_STM" 
  after UPDATE of USER_NAME on "HR"."GHR_GROUPBOX_USERS"
DECLARE
l_ID number;
l_oldID  number;
l_name   GHR_GROUPBOXES.NAME%TYPE;
l_parms  wf_parameter_list_t;

Cursor c_old_emp(p_old_user_name in varchar2) is
     select U.EMPLOYEE_ID
     from FND_USER U
     where U.USER_NAME = p_old_user_name;

Cursor c_emp(p_groupbox_id in number,
             p_user_name   in varchar2) is
   select
       U.EMPLOYEE_ID,
       GBX.NAME
   from   GHR_GROUPBOXES GBX,
          FND_USER U
   where  p_GROUPBOX_ID   = GBX.GROUPBOX_ID
   and    p_USER_NAME     = U.USER_NAME
   and    U.EMPLOYEE_ID is not null;

begin
for i in 1..ghr_api.ghr_gbx_user_index loop
  for c_old_emp_rec in c_old_emp(
     ghr_api.ghr_gbx_user_old_tab(ghr_api.ghr_gbx_user_index).user_name
    ) loop
    l_oldID  := c_old_emp_rec.employee_id;
  end loop;

  for c_emp_rec in c_emp
    (ghr_api.ghr_gbx_user_new_tab(ghr_api.ghr_gbx_user_index).groupbox_id,
     ghr_api.ghr_gbx_user_new_tab(ghr_api.ghr_gbx_user_index).user_name)
   loop
    l_id   := c_emp_rec.employee_id;
    l_name := c_emp_rec.name;
  end loop;

--   Setting the expiration Date to Current Date so that these rows could be removed
--   when running the purge routine after the expiration date has passed.

       wf_local_synch.propagate_user_role
       (p_user_orig_system      => 'PER',
        p_user_orig_system_id   => l_oldID,
        p_role_orig_system      => 'GBX',
        p_role_orig_system_id   =>
          ghr_api.ghr_gbx_user_old_tab(ghr_api.ghr_gbx_user_index).groupbox_id,
        p_expiration_date       => trunc(sysdate)
       );

        l_parms := null;
       wf_local_synch.propagate_user_role
       (p_user_orig_system      => 'PER',
        p_user_orig_system_id   => l_id,
        p_role_orig_system      => 'GBX',
        p_role_orig_system_id   =>
          ghr_api.ghr_gbx_user_new_tab(ghr_api.ghr_gbx_user_index).groupbox_id
       );

end loop;

ghr_api.ghr_gbx_user_index := 0;

end GHR_GROUPBOX_USERS_AU_STM;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOX_USERS_AU_STM" ENABLE;
