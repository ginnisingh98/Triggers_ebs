--------------------------------------------------------
--  DDL for Trigger GHR_PAY_ELEMENT_ENTRS_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PAY_ELEMENT_ENTRS_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PAY_ELEMENT_ENTRIES_F" FOR EACH ROW

DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_session_date		date;
	l_old_elmten_data		pay_element_entries_f%rowtype;
	l_old_elmten_hist_data	ghr_pa_history%rowtype;
	l_proc			varchar2(30):='pay_element_entries_f_afiud';

	PROCEDURE get_old_elmten_data( p_old_elmten_record in out pay_element_entries_f%rowtype) IS
	BEGIN
		ghr_history_conv_rg.conv_to_element_entry_rg (
		p_element_entry_id		=>	:old.element_entry_id,
		p_effective_start_date		=>	:old.effective_start_date,
		p_effective_end_date		=>	:old.effective_end_date,
		p_cost_allocation_keyflex_id  =>  	:old.cost_allocation_keyflex_id,
		p_assignment_id               => 	:old.assignment_id,
		p_updating_action_id          =>	:old.updating_action_id,
		p_element_link_id             =>	:old.element_link_id,
		p_original_entry_id           =>	:old.original_entry_id,
		p_creator_type                =>	:old.creator_type,
		p_entry_type                  =>	:old.entry_type,
		p_comment_id                  =>	:old.comment_id,
		p_creator_id                  =>	:old.creator_id,
		p_reason                      =>	:old.reason,
		p_target_entry_id             =>	:old.target_entry_id,
		p_attribute_category          =>	:old.attribute_category,
		p_attribute1                  =>	:old.attribute1,
		p_attribute2                  =>	:old.attribute2,
		p_attribute3                  =>	:old.attribute3,
		p_attribute4                  =>	:old.attribute4,
		p_attribute5                  =>	:old.attribute5,
		p_attribute6                  =>	:old.attribute6,
		p_attribute7                  =>	:old.attribute7,
		p_attribute8                  =>	:old.attribute8,
		p_attribute9                  =>	:old.attribute9,
		p_attribute10                 =>	:old.attribute10,
		p_attribute11                 =>	:old.attribute11,
		p_attribute12                 =>	:old.attribute12,
		p_attribute13                 =>	:old.attribute13,
		p_attribute14                 =>	:old.attribute14,
		p_attribute15                 =>	:old.attribute15,
		p_attribute16                 =>	:old.attribute16,
		p_attribute17                 =>	:old.attribute17,
		p_attribute18                 =>	:old.attribute18,
		p_attribute19                 =>	:old.attribute19,
		p_attribute20                 =>	:old.attribute20,
		p_subpriority                 =>	:old.subpriority,
		p_personal_payment_method_id  =>	:old.personal_payment_method_id,
		p_date_earned                 =>	:old.date_earned,
		p_element_entry_data	    	=>	p_old_elmten_record);
		END get_old_elmten_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);

	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);



	IF l_session_var.fire_trigger = 'Y' THEN
		if l_session_var.assignment_id is null then
			l_session_var.assignment_id := :new.assignment_id;
		end if;
		ghr_history_api.set_g_session_var( l_session_var);

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
					  p_table_name 		=> lower(ghr_history_api.g_eleent_table),
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.element_entry_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_elmten_hist_data,
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
					get_old_elmten_data( l_old_elmten_data);
					ghr_history_conv_rg.conv_element_entry_rg_to_hist( p_element_entries_data  => l_old_elmten_data,
									   p_history_data => l_old_elmten_hist_data);

					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);
					ghr_history_api.set_operation_info(
						p_table_name 		=> lower(ghr_history_api.g_eleent_table),
						p_program_name		=> l_session_var.program_name,
						p_date_Effective 		=> l_session_var.date_effective,
						p_table_pk_id		=> :new.element_entry_id,
						p_operation			=> 'update',
						p_old_record_data       => l_old_elmten_hist_data,
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
				p_table_name	=> lower(ghr_history_api.g_eleent_table),
				p_table_pk_id	=> :new.element_entry_id,
				p_operation		=> 'insert',
				p_old_record_data => l_old_elmten_hist_data,
				p_row_id 		=> :new.rowid);
			ELSIF updating THEN
				IF (:new.effective_end_date <> :old.effective_end_date) THEN
				hr_utility.set_location( l_proc , 100);
					NULL;
				ELSE
				hr_utility.set_location('sf50 Updating '|| l_proc , 20);
					get_old_elmten_data (	l_old_elmten_data);
					ghr_history_conv_rg.conv_element_entry_rg_to_hist(
					p_element_entries_data 	=> l_old_elmten_data,
					p_history_data		=> l_old_elmten_hist_data);
					ghr_history_api.set_operation_info(
					p_program_name	=> l_session_var.program_name,
					p_date_effective 	=> l_session_var.date_effective,
					p_table_name	=> lower(ghr_history_api.g_eleent_table),
					p_table_pk_id	=> :new.element_entry_id,
					p_operation		=> 'update',
					p_old_record_data => l_old_elmten_hist_data,
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
END GHR_PAY_ELEMENT_ENTRS_AFIUD;



/
ALTER TRIGGER "APPS"."GHR_PAY_ELEMENT_ENTRS_AFIUD" ENABLE;
