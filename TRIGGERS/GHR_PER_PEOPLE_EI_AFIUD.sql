--------------------------------------------------------
--  DDL for Trigger GHR_PER_PEOPLE_EI_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_PEOPLE_EI_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_PEOPLE_EXTRA_INFO" FOR EACH ROW

DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_old_peopleei_data		per_people_extra_info%rowtype;
	l_old_peopleei_hist_data	ghr_pa_history%rowtype;
	l_sequence_number		number;
	l_proc			varchar2(40):='per_people_ei_afiud';

	PROCEDURE get_old_peopleei_data( p_old_peopleei_record in out per_people_extra_info%rowtype) IS
	BEGIN
		ghr_history_conv_rg.conv_to_peopleei_rg(
                 p_person_extra_info_id     => :old.person_extra_info_id            ,
                 p_person_id                => :old.person_id                       ,
                 p_information_type         => :old.information_type                ,
                 p_request_id               => :old.request_id                      ,
                 p_program_application_id   => :old.program_application_id          ,
                 p_program_id               => :old.program_id                      ,
                 p_program_update_date      => :old.program_update_date             ,
                 p_pei_attribute_category   => :old.pei_attribute_category          ,
                 p_pei_attribute1           => :old.pei_attribute1                  ,
                 p_pei_attribute2           => :old.pei_attribute2                  ,
                 p_pei_attribute3           => :old.pei_attribute3                  ,
                 p_pei_attribute4           => :old.pei_attribute4                  ,
                 p_pei_attribute5           => :old.pei_attribute5                  ,
                 p_pei_attribute6           => :old.pei_attribute6                  ,
                 p_pei_attribute7           => :old.pei_attribute7                  ,
                 p_pei_attribute8           => :old.pei_attribute8                  ,
                 p_pei_attribute9           => :old.pei_attribute9                  ,
                 p_pei_attribute10          => :old.pei_attribute10                 ,
                 p_pei_attribute11          => :old.pei_attribute11                 ,
                 p_pei_attribute12          => :old.pei_attribute12                 ,
                 p_pei_attribute13          => :old.pei_attribute13                 ,
                 p_pei_attribute14          => :old.pei_attribute14                 ,
                 p_pei_attribute15          => :old.pei_attribute15                 ,
                 p_pei_attribute16          => :old.pei_attribute16                 ,
                 p_pei_attribute17          => :old.pei_attribute17                 ,
                 p_pei_attribute18          => :old.pei_attribute18                 ,
                 p_pei_attribute19          => :old.pei_attribute19                 ,
                 p_pei_attribute20          => :old.pei_attribute20                 ,
                 p_pei_information_category => :old.pei_information_category        ,
                 p_pei_information1         => :old.pei_information1                ,
                 p_pei_information2         => :old.pei_information2                ,
                 p_pei_information3         => :old.pei_information3                ,
                 p_pei_information4         => :old.pei_information4                ,
                 p_pei_information5         => :old.pei_information5                ,
                 p_pei_information6         => :old.pei_information6                ,
                 p_pei_information7         => :old.pei_information7                ,
                 p_pei_information8         => :old.pei_information8                ,
                 p_pei_information9         => :old.pei_information9                ,
                 p_pei_information10        => :old.pei_information10               ,
                 p_pei_information11        => :old.pei_information11               ,
                 p_pei_information12        => :old.pei_information12               ,
                 p_pei_information13        => :old.pei_information13               ,
                 p_pei_information14        => :old.pei_information14               ,
                 p_pei_information15        => :old.pei_information15               ,
                 p_pei_information16        => :old.pei_information16               ,
                 p_pei_information17        => :old.pei_information17               ,
                 p_pei_information18        => :old.pei_information18               ,
                 p_pei_information19        => :old.pei_information19               ,
                 p_pei_information20        => :old.pei_information20               ,
                 p_pei_information21        => :old.pei_information21               ,
                 p_pei_information22        => :old.pei_information22               ,
                 p_pei_information23        => :old.pei_information23               ,
                 p_pei_information24        => :old.pei_information24               ,
                 p_pei_information25        => :old.pei_information25               ,
                 p_pei_information26        => :old.pei_information26               ,
                 p_pei_information27        => :old.pei_information27               ,
                 p_pei_information28        => :old.pei_information28               ,
                 p_pei_information29        => :old.pei_information29               ,
                 p_pei_information30        => :old.pei_information30               ,
		     p_peopleei_data            => p_old_peopleei_record);

	END get_old_peopleei_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);
	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);


	IF l_session_var.fire_trigger = 'Y' THEN
		IF l_session_var.person_id is null then
			l_session_var.person_id := :new.person_id;
			ghr_history_api.set_g_session_var (l_session_var);
		END IF;
		IF lower(l_session_var.program_name) = 'core' then
			ghr_history_api.get_session_date( l_session_var.date_effective);
			ghr_history_api.set_g_session_var (l_session_var);
		END IF;
		IF (lower(l_session_var.program_name) = 'sf50' or
                lower(l_session_var.program_name) = 'core') then
			IF inserting THEN
				hr_utility.set_location( l_proc , 170);
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 160);
					ghr_history_api.set_operation_info(
					  p_table_name 		=> lower(ghr_history_api.g_peopei_table),
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.person_extra_info_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_peopleei_hist_data,
					  p_row_id			=> :new.rowid
					  );
			ELSIF updating THEN
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 140);
				get_old_peopleei_data( l_old_peopleei_data);
				ghr_history_conv_rg.conv_peopleei_rg_to_hist_rg(
					p_people_ei_data  => l_old_peopleei_data,
					p_history_data => l_old_peopleei_hist_data);

				ghr_history_api.set_operation_info(
					p_table_name 		=> lower(ghr_history_api.g_peopei_table),
					p_program_name		=> l_session_var.program_name,
					p_date_Effective 		=> l_session_var.date_effective,
					p_table_pk_id		=> :new.person_extra_info_id,
					p_operation			=> 'update',
					p_old_record_data=> l_old_peopleei_hist_data,
					p_row_id			=> :new.rowid
					);
			ELSE /* ie deleting */
				hr_utility.set_location( l_proc , 120);
				/* Should we allow deletes from core. How should it be handled?? */
				NULL;
			END IF;
		ELSE /* Not a known type */
		      hr_utility.set_location('Unknown Program Name - ' || l_session_var.program_name ||' :' || l_proc , 10);
			hr_utility.set_message( 8301, 'GHR_UNKNOWN_PGM_TYPE');
			fnd_message.set_token('PROGRAM_TYPE', l_session_var.program_name);
			hr_utility.raise_error;
			/* History not maintained */
		END IF;
	END IF;
      hr_utility.set_location('Leaving:'|| l_proc , 1);
END GHR_PER_PEOPLE_EI_AFIUD;



/
ALTER TRIGGER "APPS"."GHR_PER_PEOPLE_EI_AFIUD" ENABLE;
