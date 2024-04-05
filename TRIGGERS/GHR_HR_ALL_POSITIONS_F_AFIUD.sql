--------------------------------------------------------
--  DDL for Trigger GHR_HR_ALL_POSITIONS_F_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."HR_ALL_POSITIONS_F" FOR EACH ROW
DECLARE
	l_session_var		 ghr_history_api.g_session_var_type;
      l_session_date           date;
	l_old_position_data	 hr_all_positions_f%rowtype;
	l_old_position_hist_data ghr_pa_history%rowtype;
	l_sequence_number		 number;
	l_proc			 varchar2(40):='hr_all_positions_f_afiud';

	PROCEDURE get_old_position_data( p_old_position_record in out NOCOPY hr_all_positions_f%rowtype) is
	BEGIN
		ghr_history_conv_rg.conv_to_position_rg(
            p_position_id                  =>	:old.position_id,
            p_effective_start_date         =>   :old.effective_start_date,
            p_effective_end_date           =>   :old.effective_end_date,
            p_availability_status_id       =>   :old.availability_status_id,
		p_business_group_id    	       =>	:old.business_group_id,
            p_entry_step_id                =>   :old.entry_Step_id,
		p_job_id				 =>	:old.job_id,
		p_location_id                  =>	:old.location_id,
		p_organization_id			 =>   :old.organization_id,
            p_pay_freq_payroll_id          =>   :old.pay_freq_payroll_id,
		p_successor_position_id        =>	:old.successor_position_id,
		p_supervisor_position_id       =>	:old.supervisor_position_id,
		p_prior_position_id            =>	:old.prior_position_id,
		p_relief_position_id           =>	:old.relief_position_id,
            p_amendment_date               =>   :old.amendment_date,
            p_amendment_recommendation     =>   :old.amendment_recommendation,
            p_amendment_ref_number         =>   :old.amendment_ref_number,
            p_bargaining_unit_cd           =>   :old.bargaining_unit_cd,
            p_current_job_prop_end_date    =>   :old.current_job_prop_end_date,
            p_current_org_prop_end_date    =>   :old.current_org_prop_end_date,
            p_avail_status_prop_end_date   =>   :old.avail_status_prop_end_date,
		p_position_definition_id       =>	:old.position_definition_id,
		p_position_transaction_id      =>	:old.position_transaction_id,
	  	p_date_effective               =>	:old.date_effective,
--		p_comments                     =>	:old.comments,
		p_date_end                     =>	:old.date_end,
            p_earliest_hire_date           =>   :old.earliest_hire_date,
            p_fill_by_date                 =>   :old.fill_by_date,
		p_frequency                    =>	:old.frequency,
            p_fte                          =>   :old.fte,
            p_max_persons                  =>   :old.max_persons,
		p_name                         =>	:old.name,
            p_overlap_period               =>   :old.overlap_period,
            p_overlap_unit_cd              =>   :old.overlap_unit_cd,
            p_pay_term_end_day_cd          =>   :old.pay_term_end_day_cd,
            p_pay_term_end_month_cd        =>   :old.pay_term_end_month_cd,
            p_permanent_temporary_flag     =>   :old.permanent_temporary_flag,
            p_permit_recruitment_flag      =>   :old.permit_recruitment_flag,
            p_position_type                =>   :old.position_type,
            p_posting_description          =>   :old.posting_description,
		p_probation_period             =>	:old.probation_period,
		p_probation_period_unit_cd     =>	:old.probation_period_unit_cd,
		p_replacement_required_flag    =>	:old.replacement_required_flag,
            p_review_flag                  =>   :old.review_flag,
            p_seasonal_flag                =>   :old.seasonal_flag,
            p_security_requirements        =>   :old.security_requirements,
            p_term_start_day_cd            =>   :old.term_start_day_cd,
            p_term_start_month_cd          =>   :old.term_start_month_cd,
		p_time_normal_finish           =>	:old.time_normal_finish,
		p_time_normal_start            =>	:old.time_normal_start,
            p_update_source_cd             =>   :old.update_source_cd,
		p_working_hours                =>	:old.working_hours,
            p_works_council_approval_flag  =>   :old.works_council_approval_flag,
            p_work_period_type_cd          =>   :old.work_period_type_cd,
            p_work_term_end_day_cd         =>   :old.work_term_end_day_cd,
            p_work_term_end_month_cd       =>   :old.work_term_end_month_cd,
            p_entry_grade_id               =>   :old.entry_grade_id,
            p_entry_grade_rule_id          =>   :old.entry_grade_rule_id,
            p_proposed_fte_for_layoff      =>   :old.proposed_fte_for_layoff,
            p_proposed_date_for_layoff     =>   :old.proposed_date_for_layoff,
            p_pay_basis_id                 =>   :old.pay_basis_id,
            p_supervisor_id                =>   :old.supervisor_id,
            p_copied_to_old_table_flag     =>   :old.copied_to_old_table_flag,
            p_request_id               	 => 	:old.request_id,
            p_program_application_id   	 => 	:old.program_application_id,
            p_program_id               	 => 	:old.program_id,
            p_program_update_date      	 => 	:old.program_update_date,
		p_attribute_category           =>	:old.attribute_category,
		p_attribute1                   =>	:old.attribute1,
		p_attribute2                   =>	:old.attribute2,
		p_attribute3                   =>	:old.attribute3,
		p_attribute4                   =>	:old.attribute4,
		p_attribute5                   =>	:old.attribute5,
		p_attribute6                   =>	:old.attribute6,
		p_attribute7                   =>	:old.attribute7,
		p_attribute8                   =>	:old.attribute8,
		p_attribute9                   =>	:old.attribute9,
		p_attribute10                  =>	:old.attribute10,
		p_attribute11                  =>	:old.attribute11,
		p_attribute12                  =>	:old.attribute12,
		p_attribute13                  =>	:old.attribute13,
		p_attribute14                  =>	:old.attribute14,
		p_attribute15                  =>	:old.attribute15,
		p_attribute16                  =>	:old.attribute16,
		p_attribute17                  =>	:old.attribute17,
		p_attribute18                  =>	:old.attribute18,
		p_attribute19                  =>	:old.attribute19,
		p_attribute20                  =>	:old.attribute20,
		p_attribute21                  =>	:old.attribute21,
		p_attribute22                  =>	:old.attribute22,
		p_attribute23                  =>	:old.attribute23,
		p_attribute24                  =>	:old.attribute24,
		p_attribute25                  =>	:old.attribute25,
		p_attribute26                  =>	:old.attribute26,
		p_attribute27                  =>	:old.attribute27,
		p_attribute28                  =>	:old.attribute28,
		p_attribute29                  =>	:old.attribute29,
		p_attribute30                  =>	:old.attribute30,
		p_information_category         =>	:old.information_category,
		p_information1                 =>	:old.information1,
		p_information2                 =>	:old.information2,
		p_information3                 =>	:old.information3,
		p_information4                 =>	:old.information4,
		p_information5                 =>	:old.information5,
		p_information6                 =>	:old.information6,
		p_information7                 =>	:old.information7,
		p_information8                 =>	:old.information8,
		p_information9                 =>	:old.information9,
		p_information10                =>	:old.information10,
		p_information11                =>	:old.information11,
		p_information12                =>	:old.information12,
		p_information13                =>	:old.information13,
		p_information14                =>	:old.information14,
		p_information15                =>	:old.information15,
		p_information16                =>	:old.information16,
		p_information17                =>	:old.information17,
		p_information18                =>	:old.information18,
		p_information19                =>	:old.information19,
		p_information20                =>	:old.information20,
		p_information21                =>	:old.information21,
		p_information22                =>	:old.information22,
		p_information23                =>	:old.information23,
		p_information24                =>	:old.information24,
		p_information25                =>	:old.information25,
		p_information26                =>	:old.information26,
		p_information27                =>	:old.information27,
		p_information28                =>	:old.information28,
		p_information29                =>	:old.information29,
		p_information30                =>	:old.information30,
		p_status                       =>	:old.status,
		p_position_data			 => 	p_old_position_record);
            null;
	END get_old_position_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);

	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);

	IF l_session_var.fire_trigger = 'Y' THEN
	      hr_utility.set_location('Fire Trigger Y :'|| l_proc , 10);
                IF lower(l_session_var.program_name) = 'core' THEN
                   hr_utility.set_location( l_proc , 180);
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
                                                            p_table_name => ghr_history_api.g_posn_table,
                                                            p_program_name => l_session_var.program_name,
                                                            p_date_effective => l_session_var.date_effective,
                                                            p_table_pk_id => :new.position_id,
                                                            p_operation => 'insert',
                                                            p_old_record_data => l_old_position_hist_data,
                                                            p_row_id => :new.rowid
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
                                               :new.effective_end_date
                     THEN
                        hr_utility.set_location( l_proc , 140);
			      get_old_position_data(l_old_position_data);
				ghr_history_conv_rg.conv_position_rg_to_hist_rg( p_position_data  => l_old_position_data,
								                         p_history_data => l_old_position_hist_data);
                        -- For core forms effective date must be set to effective start date.
                        -- Currently this is not set correctly thru core form. As it sets the
                        -- effective date to session date.
                        l_session_var.date_effective := :new.effective_start_date;
                        ghr_history_api.set_g_session_var( l_session_var);

				ghr_history_api.set_operation_info(
					p_table_name 		=> ghr_history_api.g_posn_table,
					p_program_name		=> l_session_var.program_name,
					p_date_Effective 		=> l_session_var.date_effective,
					p_table_pk_id		=> :new.position_id,
					p_operation			=> 'update',
					p_old_record_data       => l_old_position_hist_data,
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
                                                       p_table_name => ghr_history_api.g_posn_table,
                                                       p_program_name => l_session_var.program_name,
                                                       p_date_effective => l_session_var.date_effective,
                                                       p_table_pk_id => :new.position_id,
                                                       p_operation => 'insert',
                                                       p_old_record_data => l_old_position_hist_data,
                                                       p_row_id => :new.rowid
                                                       );
                   ELSIF updating THEN
                      IF (:new.effective_end_date <> :old.effective_end_date) THEN
                        hr_utility.set_location( l_proc , 100);
                        NULL;
                      ELSE
                        hr_utility.set_location('sf50 Updating '|| l_proc , 20);
			      get_old_position_data(l_old_position_data);
				ghr_history_conv_rg.conv_position_rg_to_hist_rg( p_position_data  => l_old_position_data,
								                         p_history_data   => l_old_position_hist_data);
                        ghr_history_api.set_operation_info(
                                                       p_table_name => ghr_history_api.g_posn_table,
                                                       p_program_name => l_session_var.program_name,
                                                       p_date_effective => l_session_var.date_effective,
                                                       p_table_pk_id => :new.position_id,
                                                       p_operation => 'update',
                                                       p_old_record_data => l_old_position_hist_data,
                                                       p_row_id => :new.rowid
                                                       );
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
END GHR_HR_ALL_POSITIONS_F_AFIUD;

/
ALTER TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_AFIUD" ENABLE;
