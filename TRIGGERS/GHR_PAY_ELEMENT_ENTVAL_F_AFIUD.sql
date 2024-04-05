--------------------------------------------------------
--  DDL for Trigger GHR_PAY_ELEMENT_ENTVAL_F_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PAY_ELEMENT_ENTVAL_F_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PAY_ELEMENT_ENTRY_VALUES_F" FOR EACH ROW

DECLARE

	l_session_var				ghr_history_api.g_session_var_type;
	l_session_date				date;
	l_old_element_entvl_data		pay_element_entry_values_f%rowtype;
	l_old_element_entvl_hist_data		ghr_pa_history%rowtype;
	l_proc					varchar2(50):='pay_element_entry_values_f_Afiud';

	PROCEDURE get_old_elmtenvl_data( p_old_elmtenvl_record in out pay_element_entry_values_f%rowtype) IS
	BEGIN
		ghr_history_conv_rg.conv_to_element_entval_rg (
			p_element_entry_value_id	=> :old.element_entry_value_id,
			p_effective_start_date		=> :old.effective_start_date,
			p_effective_end_date     	=> :old.effective_end_date,
			p_input_value_id			=> :old.input_value_id,
			p_element_entry_id       	=> :old.element_entry_id,
			p_screen_entry_value		=> :old.screen_entry_value,
			p_elmeval_data			=> p_old_elmtenvl_record);


	END get_old_elmtenvl_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);
	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);

	IF l_session_var.fire_trigger = 'Y' THEN
		if l_session_var.element_entry_id is null then
			l_session_var.element_entry_id := :new.element_entry_id;
		end if;

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
					  p_table_name 		=> lower(ghr_history_api.g_eleevl_table),
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.element_entry_value_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_element_entvl_hist_data,
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
					get_old_elmtenvl_data( l_old_element_entvl_data);
					ghr_history_conv_rg.conv_element_entval_rg_to_hist(
							p_element_entval_data  => l_old_element_entvl_data,
							p_history_data => l_old_element_entvl_hist_data);

					-- For core forms effective date must be set to effective start date.
					-- Currently this is not set correctly thru core form. As it sets the
					-- effective date to session date.
					l_session_var.date_effective := :new.effective_start_date;
					ghr_history_api.set_g_session_var( l_session_var);

					ghr_history_api.set_operation_info(
						p_table_name 		=> lower(ghr_history_api.g_eleevl_table),
						p_program_name		=> l_session_var.program_name,
						p_date_Effective 		=> l_session_var.date_effective,
						p_table_pk_id		=> :new.element_entry_value_id,
						p_operation			=> 'update',
						p_old_record_data       => l_old_element_entvl_hist_data,
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
				p_table_name	=> lower(ghr_history_api.g_eleevl_table),
				p_table_pk_id	=> :new.element_entry_value_id,
				p_operation		=> 'insert',
				p_old_record_data => l_old_element_entvl_hist_data,
				p_row_id 		=> :new.rowid);
			ELSIF updating THEN
				IF (:new.effective_end_date <> :old.effective_end_date) THEN
				hr_utility.set_location( l_proc , 100);
					NULL;
				ELSE
				hr_utility.set_location('sf50 Updating '|| l_proc , 20);
					get_old_elmtenvl_data (	l_old_element_entvl_data);
					ghr_history_conv_rg.conv_element_entval_rg_to_hist(
					p_element_entval_data 	=> l_old_element_entvl_data,
					p_history_data	=> l_old_element_entvl_hist_data);
					ghr_history_api.set_operation_info(
					p_program_name	=> l_session_var.program_name,
					p_date_effective 	=> l_session_var.date_effective,
					p_table_name	=> lower(ghr_history_api.g_eleevl_table),
					p_table_pk_id	=> :new.element_entry_value_id,
					p_operation		=> 'update',
					p_old_record_data => l_old_element_entvl_hist_data,
					p_row_id 		=> :new.rowid);

				END IF;
			ELSE /* deleting */
				hr_utility.set_location('sf50 deleting '|| l_proc , 30);
				null;
				-- get_old_elmtevl_data(l_old_elmtevl_date);
				--	ghr_history_conv_rg.conv_element_entval_rg_to_hist(
				--	p_element_entvl_data 	=> l_old_element_entvl_data,
				--	p_history_data	=> l_old_element_entvl_hist_data);
				--	ghr_history_api.set_operation_info(
				--	p_program_name	=> l_session_var.program_name,
				--	p_date_effective 	=> l_session_var.date_effective,
				--	p_table_name	=> lower(ghr_history_api.g_eleevl_table),
				--	p_table_pk_id	=> :new.element_entry_value_id,
				--	p_operation		=> 'delete',
				--	p_old_record_data => l_old_element_entvl_data,
				--	p_row_id 		=> :new.rowid);
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
END GHR_PAY_ELEMENT_ENTVAL_F_AFIUD;



/
ALTER TRIGGER "APPS"."GHR_PAY_ELEMENT_ENTVAL_F_AFIUD" ENABLE;
