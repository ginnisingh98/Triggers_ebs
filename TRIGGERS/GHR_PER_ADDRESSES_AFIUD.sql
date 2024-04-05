--------------------------------------------------------
--  DDL for Trigger GHR_PER_ADDRESSES_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_ADDRESSES_AFIUD" 
AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_ADDRESSES" FOR EACH ROW
DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_old_address_data		per_addresses%rowtype;
	l_old_address_hist_data	ghr_pa_history%rowtype;
	l_proc			varchar2(40):='per_addresses_afiud';

	PROCEDURE get_old_address_data( p_old_address_record in out nocopy per_addresses%rowtype) IS
	    l_old_address_record per_addresses%rowtype;
	BEGIN
	    -- NOCOPY Changes.
	    l_old_address_record := p_old_address_record;
		ghr_history_conv_rg.conv_to_addresses_rg (
		p_address_id              =>	:old.address_id,
		p_business_group_id       =>	:old.business_group_id,
		p_person_id               =>	:old.person_id,
		p_date_from               =>	:old.date_from,
		p_primary_flag            =>	:old.primary_flag,
		p_style                   =>	:old.style,
		p_address_line1           => 	:old.address_line1,
		p_address_line2           =>	:old.address_line2,
		p_address_line3           =>	:old.address_line3,
		p_address_type            =>	:old.address_type,
		p_country                 =>	:old.country,
		p_date_to                 =>	:old.date_to,
		p_postal_code             =>	:old.postal_code,
		p_region_1                =>	:old.region_1,
		p_region_2                =>	:old.region_2,
		p_region_3                =>	:old.region_3,
		p_telephone_number_1      =>	:old.telephone_number_1,
		p_telephone_number_2      =>	:old.telephone_number_2,
		p_telephone_number_3      =>	:old.telephone_number_3,
		p_town_or_city            =>	:old.town_or_city,
		p_request_id              =>	:old.request_id,
		p_program_application_id  =>	:old.program_application_id,
		p_program_id              =>	:old.program_id,
		p_program_update_date     =>	:old.program_update_date,
		p_addr_attribute_category =>	:old.addr_attribute_category,
		p_addr_attribute1         =>	:old.addr_attribute1,
		p_addr_attribute2         =>	:old.addr_attribute2,
		p_addr_attribute3         =>	:old.addr_attribute3,
		p_addr_attribute4         =>	:old.addr_attribute4,
		p_addr_attribute5         =>	:old.addr_attribute5,
		p_addr_attribute6         =>	:old.addr_attribute6,
		p_addr_attribute7         =>	:old.addr_attribute7,
		p_addr_attribute8         =>	:old.addr_attribute8,
		p_addr_attribute9         =>	:old.addr_attribute9,
		p_addr_attribute10        =>	:old.addr_attribute10,
		p_addr_attribute11        =>	:old.addr_attribute11,
		p_addr_attribute12        =>	:old.addr_attribute12,
		p_addr_attribute13        =>	:old.addr_attribute13,
		p_addr_attribute14        =>	:old.addr_attribute14,
		p_addr_attribute15        =>	:old.addr_attribute15,
		p_addr_attribute16        =>	:old.addr_attribute16,
		p_addr_attribute17        =>	:old.addr_attribute17,
		p_addr_attribute18        =>	:old.addr_attribute18,
		p_addr_attribute19        =>	:old.addr_attribute19,
		p_addr_attribute20        =>	:old.addr_attribute20,
--		p_object_version_number   =>	:old.object_version_number,
		p_addresses_data	    	  => 	p_old_address_record);
        EXCEPTION
	    -- NOCOPY Changes
	    WHEN OTHERS THEN
	      	    p_old_address_record := l_old_address_record;
                    raise;
	END get_old_address_data;

  BEGIN
     if hr_general.g_data_migrator_mode <> 'Y' then
        hr_utility.set_location('Entering:'|| l_proc , 1);
    	  ghr_history_api.get_g_session_var( l_session_var);
     	  hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	  hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);

	  if l_session_var.fire_trigger = 'Y' THEN
	     if l_session_var.person_id is null then
		  l_session_var.person_id := :new.person_id;
	   	  ghr_history_api.set_g_session_var( l_session_var);
	     end if;
	     if lower(l_session_var.program_name) = 'core' then
		  ghr_history_api.get_session_date( l_session_var.date_effective);
		  ghr_history_api.set_g_session_var (l_session_var);
	     end if;

	     if (lower(l_session_var.program_name) = 'sf50' or lower(l_session_var.program_name) = 'core') then
		  if inserting THEN
		     hr_utility.set_location( l_proc , 170);
		     hr_utility.set_location( l_proc , 160);
		     ghr_history_api.set_operation_info
                     (
		     p_table_name 	=> ghr_history_api.g_addres_table,
		     p_program_name  	=> l_session_var.program_name,
	   	     p_date_effective 	=> l_session_var.date_effective,
		     p_table_pk_id	=> :new.address_id,
		     p_operation	=> 'insert',
		     p_old_record_data  => l_old_address_hist_data,
		     p_row_id		=> :new.rowid
		     );
		  elsif updating THEN
	   	    hr_utility.set_location( l_proc , 140);
		    get_old_address_data( l_old_address_data);
		    ghr_history_conv_rg.conv_addresses_rg_to_hist_rg
                    (
                    p_addresses_data  => l_old_address_data,
		    p_history_data    => l_old_address_hist_data
                    );

		    ghr_history_api.set_operation_info
                   (
		    p_table_name 		=> ghr_history_api.g_addres_table,
		    p_program_name		=> l_session_var.program_name,
		    p_date_Effective 		=> l_session_var.date_effective,
		    p_table_pk_id		=> :new.address_id,
		    p_operation			=> 'update',
		    p_old_record_data           => l_old_address_hist_data,
		    p_row_id			=> :new.rowid
		    );
		 else  --  ie deleting
		   hr_utility.set_location( l_proc , 120);
		   ghr_history_api.get_g_session_var( l_session_var);
		   NULL;
		 end if;
              else  -- Not a known type
		hr_utility.set_location('Unknown Program Name - ' || l_session_var.program_name ||' :' || l_proc , 10);
		hr_utility.set_message( 8301, 'GHR_UNKNOWN_PGM_TYPE');
		fnd_message.set_token('PROGRAM_TYPE', l_session_var.program_name);
		hr_utility.raise_error;			-- History not maintained
	      end if;
            end if;
            hr_utility.set_location('Leaving:'|| l_proc , 1);
          end if;
   end GHR_PER_ADDRESSES_AFIUD;

/
ALTER TRIGGER "APPS"."GHR_PER_ADDRESSES_AFIUD" ENABLE;
