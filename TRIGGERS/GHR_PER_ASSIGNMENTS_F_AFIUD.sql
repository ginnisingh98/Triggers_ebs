--------------------------------------------------------
--  DDL for Trigger GHR_PER_ASSIGNMENTS_F_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_ASSIGNMENTS_F_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_ALL_ASSIGNMENTS_F" FOR EACH ROW
DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_session_date		date;
	l_old_asgn_data		per_all_assignments_f%rowtype;
	l_old_asgn_hist_data	ghr_pa_history%rowtype;
	l_sequence_number		number;
	l_proc			varchar2(30):='per_all_assignments_f_afiud';

	PROCEDURE get_old_asgn_data( p_old_asgn_record IN OUT NOCOPY per_all_assignments_f%rowtype) IS
        v_old_asgn_record per_all_assignments_f%rowtype;
	BEGIN
              --Initilization for NOCOPY Changes
              --
              v_old_asgn_record := p_old_asgn_record;

		ghr_history_conv_rg.conv_to_asgn_rg (
                       p_assignment_id                   => p_old_asgn_record.assignment_id                        ,
                       p_effective_start_date            => p_old_asgn_record.effective_start_date                 ,
                       p_effective_end_date              => p_old_asgn_record.effective_end_date                   ,
                       p_business_group_id               => p_old_asgn_record.business_group_id                    ,
                       p_recruiter_id                    => p_old_asgn_record.recruiter_id                         ,
                       p_grade_id                        => p_old_asgn_record.grade_id                             ,
                       p_position_id                     => p_old_asgn_record.position_id                          ,
                       p_job_id                          => p_old_asgn_record.job_id                               ,
                       p_assignment_status_type_id       => p_old_asgn_record.assignment_status_type_id            ,
                       p_payroll_id                      => p_old_asgn_record.payroll_id                           ,
                       p_location_id                     => p_old_asgn_record.location_id                          ,
                       p_person_referred_by_id           => p_old_asgn_record.person_referred_by_id                ,
                       p_supervisor_id                   => p_old_asgn_record.supervisor_id                        ,
                       p_special_ceiling_step_id         => p_old_asgn_record.special_ceiling_step_id              ,
                       p_person_id                       => p_old_asgn_record.person_id                            ,
                       p_recruitment_activity_id         => p_old_asgn_record.recruitment_activity_id              ,
                       p_source_organization_id          => p_old_asgn_record.source_organization_id               ,
                       p_organization_id                 => p_old_asgn_record.organization_id                      ,
                       p_people_group_id                 => p_old_asgn_record.people_group_id                      ,
                       p_soft_coding_keyflex_id          => p_old_asgn_record.soft_coding_keyflex_id               ,
                       p_vacancy_id                      => p_old_asgn_record.vacancy_id                           ,
                       p_pay_basis_id                    => p_old_asgn_record.pay_basis_id                         ,
                       p_assignment_sequence             => p_old_asgn_record.assignment_sequence                  ,
                       p_assignment_type                 => p_old_asgn_record.assignment_type                      ,
                       p_primary_flag                    => p_old_asgn_record.primary_flag                         ,
                       p_application_id                  => p_old_asgn_record.application_id                       ,
                       p_assignment_number               => p_old_asgn_record.assignment_number                    ,
                       p_change_reason                   => p_old_asgn_record.change_reason                        ,
                       p_comment_id                      => p_old_asgn_record.comment_id                           ,
                       p_date_probation_end              => p_old_asgn_record.date_probation_end                   ,
                       p_default_code_comb_id            => p_old_asgn_record.default_code_comb_id                 ,
                       p_employment_category             => p_old_asgn_record.employment_category                  ,
                       p_frequency                       => p_old_asgn_record.frequency                            ,
                       p_internal_address_line           => p_old_asgn_record.internal_address_line                ,
                       p_manager_flag                    => p_old_asgn_record.manager_flag                         ,
                       p_normal_hours                    => p_old_asgn_record.normal_hours                         ,
                       p_perf_review_period              => p_old_asgn_record.perf_review_period                   ,
                       p_perf_review_period_frequency    => p_old_asgn_record.perf_review_period_frequency         ,
                       p_period_of_service_id            => p_old_asgn_record.period_of_service_id                 ,
                       p_probation_period                => p_old_asgn_record.probation_period                     ,
                       p_probation_unit                  => p_old_asgn_record.probation_unit                       ,
                       p_sal_review_period               => p_old_asgn_record.sal_review_period                    ,
                       p_sal_review_period_frequency     => p_old_asgn_record.sal_review_period_frequency          ,
                       p_set_of_books_id                 => p_old_asgn_record.set_of_books_id                      ,
                       p_source_type                     => p_old_asgn_record.source_type                          ,
                       p_time_normal_finish              => p_old_asgn_record.time_normal_finish                   ,
                       p_time_normal_start               => p_old_asgn_record.time_normal_start                    ,
                       p_request_id                      => p_old_asgn_record.request_id                           ,
                       p_program_application_id          => p_old_asgn_record.program_application_id               ,
                       p_program_id                      => p_old_asgn_record.program_id                           ,
                       p_program_update_date             => p_old_asgn_record.program_update_date                  ,
                       p_ass_attribute_category          => p_old_asgn_record.ass_attribute_category               ,
                       p_ass_attribute1                  => p_old_asgn_record.ass_attribute1                       ,
                       p_ass_attribute2                  => p_old_asgn_record.ass_attribute2                       ,
                       p_ass_attribute3                  => p_old_asgn_record.ass_attribute3                       ,
                       p_ass_attribute4                  => p_old_asgn_record.ass_attribute4                       ,
                       p_ass_attribute5                  => p_old_asgn_record.ass_attribute5                       ,
                       p_ass_attribute6                  => p_old_asgn_record.ass_attribute6                       ,
                       p_ass_attribute7                  => p_old_asgn_record.ass_attribute7                       ,
                       p_ass_attribute8                  => p_old_asgn_record.ass_attribute8                       ,
                       p_ass_attribute9                  => p_old_asgn_record.ass_attribute9                       ,
                       p_ass_attribute10                 => p_old_asgn_record.ass_attribute10                      ,
                       p_ass_attribute11                 => p_old_asgn_record.ass_attribute11                      ,
                       p_ass_attribute12                 => p_old_asgn_record.ass_attribute12                      ,
                       p_ass_attribute13                 => p_old_asgn_record.ass_attribute13                      ,
                       p_ass_attribute14                 => p_old_asgn_record.ass_attribute14                      ,
                       p_ass_attribute15                 => p_old_asgn_record.ass_attribute15                      ,
                       p_ass_attribute16                 => p_old_asgn_record.ass_attribute16                      ,
                       p_ass_attribute17                 => p_old_asgn_record.ass_attribute17                      ,
                       p_ass_attribute18                 => p_old_asgn_record.ass_attribute18                      ,
                       p_ass_attribute19                 => p_old_asgn_record.ass_attribute19                      ,
                       p_ass_attribute20                 => p_old_asgn_record.ass_attribute20                      ,
                       p_ass_attribute21                 => p_old_asgn_record.ass_attribute21                      ,
                       p_ass_attribute22                 => p_old_asgn_record.ass_attribute22                      ,
                       p_ass_attribute23                 => p_old_asgn_record.ass_attribute23                      ,
                       p_ass_attribute24                 => p_old_asgn_record.ass_attribute24                      ,
                       p_ass_attribute25                 => p_old_asgn_record.ass_attribute25                      ,
                       p_ass_attribute26                 => p_old_asgn_record.ass_attribute26                      ,
                       p_ass_attribute27                 => p_old_asgn_record.ass_attribute27                      ,
                       p_ass_attribute28                 => p_old_asgn_record.ass_attribute28                      ,
                       p_ass_attribute29                 => p_old_asgn_record.ass_attribute29                      ,
                       p_ass_attribute30                 => p_old_asgn_record.ass_attribute30                      ,
                       p_title                           => p_old_asgn_record.title                                ,
--                       p_object_version_number           => p_old_asgn_record.object_version_number                ,
                       p_asgn_data                       => p_old_asgn_record);
  EXCEPTION
  when others then
     -- NOCOPY Changes
     -- Reset IN OUT params and Set OUT params to null
     p_old_asgn_record := v_old_asgn_record;
     raise;
	END get_old_asgn_data;

BEGIN

      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);
	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);



	IF l_session_var.fire_trigger = 'Y' THEN
		-- if session var (person_id , assignment_id) are  null then assign the value
		if l_session_var.person_id is null then
			l_session_var.person_id := :new.person_id;
		end if;
		if l_session_var.assignment_id is null then
			l_session_var.assignment_id := :new.assignment_id;
		end if;
		ghr_history_api.set_g_session_var( l_session_var);

	      hr_utility.set_location('Fire Trigger Y :'|| l_proc , 10);
		IF lower(l_session_var.program_name) = 'core' THEN
			hr_utility.set_location( l_proc , 180);
			ghr_history_api.get_session_date( l_session_date);

			IF inserting THEN
				hr_utility.set_location( l_proc , 170);
				ghr_history_api.get_g_session_var( l_session_var);
				IF :new.effective_start_date >= l_session_date THEN
					hr_utility.set_location( l_proc , 160);
					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);

					ghr_history_api.set_operation_info(
					  p_table_name 		=> lower(ghr_history_api.g_asgn_table),
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.assignment_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_asgn_hist_data,
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
				ghr_history_api.get_g_session_var( l_session_var);
				IF l_session_date between :new.effective_start_date and
                                                  :new.effective_end_date       THEN

				hr_utility.set_location( l_proc , 140);
					get_old_asgn_data( l_old_asgn_data);
					ghr_history_conv_rg.conv_asgn_rg_to_hist_rg(
							p_assignment_data  => l_old_asgn_data,
							p_history_data => l_old_asgn_hist_data);

					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);

					ghr_history_api.set_operation_info(
						p_table_name 		=> lower(ghr_history_api.g_asgn_table),
						p_program_name		=> l_session_var.program_name,
						p_date_Effective 		=> l_session_var.date_effective,
						p_table_pk_id		=> :new.assignment_id,
						p_operation			=> 'update',
						p_old_record_data       => l_old_asgn_hist_data,
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
				p_table_name	=> lower(ghr_history_api.g_asgn_table),
				p_table_pk_id	=> :new.assignment_id,
				p_operation		=> 'insert',
				p_old_record_data => l_old_asgn_hist_data,
				p_row_id 		=> :new.rowid);
			ELSIF updating THEN
				IF (:new.effective_end_date <> :old.effective_end_date) THEN
				hr_utility.set_location( l_proc , 100);
					NULL;
				ELSE
				hr_utility.set_location('sf50 Updating '|| l_proc , 20);
					get_old_asgn_data (	l_old_asgn_data);
					ghr_history_conv_rg.conv_asgn_rg_to_hist_rg(
						p_assignment_data => l_old_asgn_data,
						p_history_data	=> l_old_asgn_hist_data);
					ghr_history_api.set_operation_info(
					p_program_name	=> l_session_var.program_name,
					p_date_effective 	=> l_session_var.date_effective,
					p_table_name	=> lower(ghr_history_api.g_asgn_table),
					p_table_pk_id	=> :new.person_id,
					p_operation		=> 'update',
					p_old_record_data => l_old_asgn_hist_data,
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
END GHR_PER_ASSIGNMENTS_F_AFIUD;


/
ALTER TRIGGER "APPS"."GHR_PER_ASSIGNMENTS_F_AFIUD" ENABLE;
