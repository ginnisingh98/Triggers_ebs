--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOXES_AD_STM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOXES_AD_STM" 
  after DELETE on "HR"."GHR_GROUPBOXES"
DECLARE
  l_parms   wf_parameter_list_t;
begin
-- construct attribute list --
for i in 1..ghr_api.ghr_gbx_index loop
  wf_event.AddParameterToList('DELETE','TRUE', l_parms);

    wf_event.AddParameterToList('orclWFOrigSystem','GBX',l_parms);
    wf_event.AddParameterToList('orclWFOrigSystemID',ghr_api.ghr_gbx_tab(i).groupbox_id,l_parms);

  -- added to synchronize the wf_local_roles table
  wf_local_synch.propagate_role
   (p_orig_system      => 'GBX',
    p_orig_system_id   => ghr_api.ghr_gbx_tab(i).groupbox_id,
    p_attributes       => l_parms,
    p_expiration_date  => sysdate
   );
end loop;
ghr_api.ghr_gbx_index := 0;

end  GHR_GROUPBOXES_AD_STM;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOXES_AD_STM" ENABLE;
