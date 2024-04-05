--------------------------------------------------------
--  DDL for Trigger GHR_PER_ALL_PEOPLE_F_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_ALL_PEOPLE_F_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_ALL_PEOPLE_F" FOR EACH ROW
DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_old_people_data		per_all_people_f%rowtype;
	l_old_people_hist_data	ghr_pa_history%rowtype;
	l_session_date		date;
	l_proc			varchar2(30):='per_all_people_f_afiud';

	PROCEDURE get_old_people_data( p_old_people_record IN OUT NOCOPY per_all_people_f%rowtype) IS
        v_old_people_record per_all_people_f%rowtype;
	BEGIN
             --Initilization for NOCOPY Changes
             --
             v_old_people_record := p_old_people_record;

		ghr_history_conv_rg.conv_to_people_rg (
                       p_person_id                       => :old.person_id                          ,
                       p_effective_start_date            => :old.effective_start_date               ,
                       p_effective_end_date              => :old.effective_end_date                 ,
                       p_business_group_id               => :old.business_group_id                  ,
                       p_person_type_id                  => :old.person_type_id                     ,
                       p_last_name                       => :old.last_name                          ,
                       p_start_date                      => :old.start_date                         ,
                       p_applicant_number                => :old.applicant_number                   ,
                       p_background_check_status         => :old.background_check_status            ,
                       p_background_date_check           => :old.background_date_check              ,
                       p_blood_type                      => :old.blood_type                         ,
                       p_comment_id                      => :old.comment_id                         ,
                       p_correspondence_language         => :old.correspondence_language            ,
                       p_current_applicant_flag          => :old.current_applicant_flag             ,
                       p_current_emp_or_apl_flag         => :old.current_emp_or_apl_flag            ,
                       p_current_employee_flag           => :old.current_employee_flag              ,
                       p_date_employee_data_verified     => :old.date_employee_data_verified        ,
                       p_date_of_birth                   => :old.date_of_birth                      ,
                       p_email_address                   => :old.email_address                      ,
                       p_employee_number                 => :old.employee_number                    ,
                       p_expense_check_send_to_add       => :old.expense_check_send_to_address      ,
                       p_fast_path_employee              => :old.fast_path_employee                 ,
                       p_first_name                      => :old.first_name                         ,
                       p_fte_capacity                    => :old.fte_capacity                       ,
                       p_full_name                       => :old.full_name                          ,
                       p_hold_applicant_date_until       => :old.hold_applicant_date_until          ,
                       p_honors                          => :old.honors                             ,
                       p_internal_location               => :old.internal_location                  ,
                       p_known_as                        => :old.known_as                           ,
                       p_last_medical_test_by            => :old.last_medical_test_by               ,
                       p_last_medical_test_date          => :old.last_medical_test_date             ,
                       p_mailstop                        => :old.mailstop                           ,
                       p_marital_status                  => :old.marital_status                     ,
                       p_middle_names                    => :old.middle_names                       ,
                       p_nationality                     => :old.nationality                        ,
                       p_national_identifier             => :old.national_identifier                ,
                       p_office_number                   => :old.office_number                      ,
                       p_on_military_service             => :old.on_military_service                ,
                       p_order_name                      => :old.order_name                         ,
                       p_pre_name_adjunct                => :old.pre_name_adjunct                   ,
                       p_previous_last_name              => :old.previous_last_name                 ,
                       p_projected_start_date            => :old.projected_start_date               ,
                       p_rehire_authorizor               => :old.rehire_authorizor                  ,
                       p_rehire_recommendation           => :old.rehire_recommendation              ,
                       p_resume_exists                   => :old.resume_exists                      ,
                       p_resume_last_updated             => :old.resume_last_updated                ,
                       p_registered_disabled_flag        => :old.registered_disabled_flag           ,
                       p_second_passport_exists          => :old.second_passport_exists             ,
                       p_sex                             => :old.sex                                ,
                       p_student_status                  => :old.student_status                     ,
                       p_suffix                          => :old.suffix                             ,
                       p_title                           => :old.title                              ,
                       p_vendor_id                       => :old.vendor_id                          ,
                       p_work_schedule                   => :old.work_schedule                      ,
                       p_work_telephone                  => :old.work_telephone                     ,
                       p_request_id                      => :old.request_id                         ,
                       p_program_application_id          => :old.program_application_id             ,
                       p_program_id                      => :old.program_id                         ,
                       p_program_update_date             => :old.program_update_date                ,
                       p_attribute_category              => :old.attribute_category                 ,
                       p_attribute1                      => :old.attribute1                         ,
                       p_attribute2                      => :old.attribute2                         ,
                       p_attribute3                      => :old.attribute3                         ,
                       p_attribute4                      => :old.attribute4                         ,
                       p_attribute5                      => :old.attribute5                         ,
                       p_attribute6                      => :old.attribute6                         ,
                       p_attribute7                      => :old.attribute7                         ,
                       p_attribute8                      => :old.attribute8                         ,
                       p_attribute9                      => :old.attribute9                         ,
                       p_attribute10                     => :old.attribute10                        ,
                       p_attribute11                     => :old.attribute11                        ,
                       p_attribute12                     => :old.attribute12                        ,
                       p_attribute13                     => :old.attribute13                        ,
                       p_attribute14                     => :old.attribute14                        ,
                       p_attribute15                     => :old.attribute15                        ,
                       p_attribute16                     => :old.attribute16                        ,
                       p_attribute17                     => :old.attribute17                        ,
                       p_attribute18                     => :old.attribute18                        ,
                       p_attribute19                     => :old.attribute19                        ,
                       p_attribute20                     => :old.attribute20                        ,
                       p_attribute21                     => :old.attribute21                        ,
                       p_attribute22                     => :old.attribute22                        ,
                       p_attribute23                     => :old.attribute23                        ,
                       p_attribute24                     => :old.attribute24                        ,
                       p_attribute25                     => :old.attribute25                        ,
                       p_attribute26                     => :old.attribute26                        ,
                       p_attribute27                     => :old.attribute27                        ,
                       p_attribute28                     => :old.attribute28                        ,
                       p_attribute29                     => :old.attribute29                        ,
                       p_attribute30                     => :old.attribute30                        ,
                       p_per_information_category        => :old.per_information_category           ,
                       p_per_information1                => :old.per_information1                   ,
                       p_per_information2                => :old.per_information2                   ,
                       p_per_information3                => :old.per_information3                   ,
                       p_per_information4                => :old.per_information4                   ,
                       p_per_information5                => :old.per_information5                   ,
                       p_per_information6                => :old.per_information6                   ,
                       p_per_information7                => :old.per_information7                   ,
                       p_per_information8                => :old.per_information8                   ,
                       p_per_information9                => :old.per_information9                   ,
                       p_per_information10               => :old.per_information10                  ,
                       p_per_information11               => :old.per_information11                  ,
                       p_per_information12               => :old.per_information12                  ,
                       p_per_information13               => :old.per_information13                  ,
                       p_per_information14               => :old.per_information14                  ,
                       p_per_information15               => :old.per_information15                  ,
                       p_per_information16               => :old.per_information16                  ,
                       p_per_information17               => :old.per_information17                  ,
                       p_per_information18               => :old.per_information18                  ,
                       p_per_information19               => :old.per_information19                  ,
                       p_per_information20               => :old.per_information20                  ,
                       p_per_information21               => :old.per_information21                  ,
                       p_per_information22               => :old.per_information22                  ,
                       p_per_information23               => :old.per_information23                  ,
                       p_per_information24               => :old.per_information24                  ,
                       p_per_information25               => :old.per_information25                  ,
                       p_per_information26               => :old.per_information26                  ,
                       p_per_information27               => :old.per_information27                  ,
                       p_per_information28               => :old.per_information28                  ,
                       p_per_information29               => :old.per_information29                  ,
                       p_per_information30               => :old.per_information30                  ,
                       p_date_of_death                   => :old.date_of_death                      ,
                       p_rehire_reason                   => :old.rehire_reason                      ,
                       p_people_data                     => p_old_people_record
		);
EXCEPTION
  when others then
     -- NOCOPY Changes
     -- Reset IN OUT params and Set OUT params to null
     p_old_people_record := v_old_people_record;
     raise;
	END get_old_people_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);
	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);

	IF l_session_var.fire_trigger = 'Y' THEN
	      hr_utility.set_location('Fire Trigger Y :'|| l_proc , 10);
		IF lower(l_session_var.program_name) = 'core' THEN
			hr_utility.set_location( l_proc , 180);

			if l_session_var.person_id is null then
				l_session_var.person_id := :new.person_id;
			end if;
			ghr_history_api.get_session_date( l_session_date);
			IF inserting THEN
				hr_utility.set_location( l_proc , 170);
				IF :new.effective_start_date >= l_session_date THEN
					hr_utility.set_location( l_proc , 160);
					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);

					ghr_history_api.set_operation_info(
					  p_table_name 		=> lower(ghr_history_api.g_peop_table),
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.person_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_people_hist_data,
					  p_row_id			=> :new.rowid
					  );
				ELSE
				hr_utility.set_location( l_proc , 150);
					/* As core form creates a new record for the old record and
					end dates it. This is not the record which needs to be
					considered for history.
					*/
					NULL;
				END IF;
			ELSIF updating THEN
				IF l_session_date between :new.effective_start_date and
                                                  :new.effective_end_date       THEN
				hr_utility.set_location( l_proc , 140);
					get_old_people_data(l_old_people_data);
					ghr_history_conv_rg.conv_people_rg_to_hist_rg( p_people_data  => l_old_people_data,
									   p_history_data => l_old_people_hist_data);

					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);

					ghr_history_api.set_operation_info(
						p_table_name 		=> lower(ghr_history_api.g_peop_table),
						p_program_name		=> l_session_var.program_name,
						p_date_Effective 		=> l_session_var.date_effective,
						p_table_pk_id		=> :new.person_id,
						p_operation			=> 'update',
						p_old_record_data       => l_old_people_hist_data,
						p_row_id			=> :new.rowid
						);
				ELSE
				hr_utility.set_location( l_proc , 130);
					/* This is the case when a record is end dated. No need to
					maintain History for this record
					*/
					NULL;
				END IF;
			ELSE /* ie deleting */
				hr_utility.set_location( l_proc , 120);
				ghr_history_api.get_g_session_var( l_session_var);
				/* Should we allow deletes from core. How should it be handled?? */
				NULL;
			END IF;
		ELSIF lower(l_session_var.program_name) = 'sf50' THEN
			IF inserting THEN
				hr_utility.set_location( l_proc , 110);
				ghr_history_api.set_operation_info(
				p_program_name	=> l_session_var.program_name,
				p_date_effective 	=> l_session_var.date_effective,
				p_table_name	=> lower(ghr_history_api.g_peop_table),
				p_table_pk_id	=> :new.person_id,
				p_operation		=> 'insert',
				p_old_record_data => l_old_people_hist_data,
				p_row_id 		=> :new.rowid);
			ELSIF updating THEN
				IF (:new.effective_end_date <> :old.effective_end_date) THEN
				hr_utility.set_location( l_proc , 100);
					NULL;
				ELSE
				hr_utility.set_location('sf50 Updating '|| l_proc , 20);
					get_old_people_data (l_old_people_data);

					ghr_history_conv_rg.conv_people_rg_to_hist_rg(
					p_people_data 	=> l_old_people_data,
					p_history_data	=> l_old_people_hist_data);

					ghr_history_api.set_operation_info(
					p_program_name	=> l_session_var.program_name,
					p_date_effective 	=> l_session_var.date_effective,
					p_table_name	=> lower(ghr_history_api.g_peop_table),
					p_table_pk_id	=> :new.person_id,
					p_operation		=> 'update',
					p_old_record_data => l_old_people_hist_data,
					p_row_id 		=> :new.rowid);

				END IF;
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
END GHR_PER_ALL_PEOPLE_F_AFIUD;


/
ALTER TRIGGER "APPS"."GHR_PER_ALL_PEOPLE_F_AFIUD" ENABLE;
