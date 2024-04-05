--------------------------------------------------------
--  DDL for Trigger GHR_GROUPBOXES_AU_STM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_GROUPBOXES_AU_STM" 
  after UPDATE on "HR"."GHR_GROUPBOXES"
DECLARE
  l_language  FND_LANGUAGES.NLS_LANGUAGE%TYPE;
  l_territory FND_LANGUAGES.NLS_TERRITORY%TYPE;
  l_parms   wf_parameter_list_t;

  Cursor c_lang is
   select NLS_LANGUAGE, NLS_TERRITORY
   from FND_LANGUAGES FNDL
   where FNDL.INSTALLED_FLAG = 'B';

begin

    for c_lang_rec in c_lang loop
       l_language := c_lang_rec.nls_language;
       l_territory := c_lang_rec.nls_territory;
    end loop;

for i in 1..ghr_api.ghr_gbx_index loop

    wf_event.AddParameterToList('USER_NAME',ghr_api.ghr_gbx_tab(i).name,l_parms);
    wf_event.AddParameterToList('DisplayName', ghr_api.ghr_gbx_tab(i).display_name, l_parms);
    wf_event.AddParameterToList('description', ghr_api.ghr_gbx_tab(i).description, l_parms);
    wf_event.AddParameterToList('orclWorkFlowNotificationPref', 'QUERY', l_parms);
    wf_event.AddParameterToList('preferredLanguage', l_language, l_parms);
    wf_event.AddParameterToList('orclNLSTerritory', l_territory,l_parms);
    wf_event.AddParameterToList('mail',null,l_parms);
    wf_event.AddParameterToList('FacsimileTelephoneNumber',null,l_parms);
    wf_event.AddParameterToList('orclIsEnabled','ACTIVE',l_parms);
    wf_event.AddParameterToList('orclWFOrigSystem','GBX',l_parms);
    wf_event.AddParameterToList('orclWFOrigSystemID',ghr_api.ghr_gbx_tab(i).groupbox_id,l_parms);

    wf_local_synch.propagate_role
   (p_orig_system      => 'GBX',
    p_orig_system_id   => ghr_api.ghr_gbx_tab(i).groupbox_id,
    p_attributes       => l_parms,
    p_start_date       => null,
    p_expiration_date  => null);
end loop;
ghr_api.ghr_gbx_index := 0;

end GHR_GROUPBOXES_AU_STM;


/
ALTER TRIGGER "APPS"."GHR_GROUPBOXES_AU_STM" ENABLE;
