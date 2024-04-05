--------------------------------------------------------
--  DDL for Trigger PER_DRT_PER_DATA_RMVL_STATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_DRT_PER_DATA_RMVL_STATUS" 
before update of status on "HR"."PER_DRT_PERSON_DATA_REMOVALS"
for each row
declare
 l_full_name VARCHAR2(240);
begin
	if hr_general.g_data_migrator_mode <> 'Y' then
		if :old.STATUS <> :new.STATUS and :new.STATUS = 'Removed' then
			if :old.ENTITY_TYPE = 'HR' then
				select full_name into l_full_name
        from per_all_people_f
				where person_id = :new.PERSON_ID
        and trunc(sysdate) between effective_start_date and effective_end_date;
			elsif :old.ENTITY_TYPE = 'FND' then
       	select USER_NAME into l_full_name
        from fnd_user
        where USER_ID = :new.PERSON_ID;
			else
			 	select PARTY_NAME into l_full_name
       	from hz_parties
       	where PARTY_ID = :new.PERSON_ID;
			end if;
       	:new.FULL_NAME := l_full_name;
		end if;
	end if;
end;
/
ALTER TRIGGER "APPS"."PER_DRT_PER_DATA_RMVL_STATUS" ENABLE;
