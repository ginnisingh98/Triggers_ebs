--------------------------------------------------------
--  DDL for Trigger GHR_PER_ASSIGN_EI_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_ASSIGN_EI_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_ASSIGNMENT_EXTRA_INFO" FOR EACH ROW

DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_old_assignment_ei_data		per_assignment_extra_info%rowtype;
	l_old_assignment_ei_hist_data	ghr_pa_history%rowtype;
	l_sequence_number		number;
	l_proc			varchar2(40):='per_assignment_extra_info_afiud';

	PROCEDURE get_old_assignment_ei_data( p_old_assignment_ei_record in out per_assignment_extra_info%rowtype) IS
	BEGIN
		ghr_history_conv_rg.conv_to_asgnei_rg(
			p_assignment_extra_info_id	=> :old.assignment_extra_info_id	,
			p_assignment_id			=> :old.assignment_id			,
			p_information_type		=> :old.information_type		,
			p_aei_information_category	=> :old.aei_information_category	,
			p_aei_information1		=> :old.aei_information1		,
			p_aei_information2		=> :old.aei_information2		,
			p_aei_information3		=> :old.aei_information3		,
			p_aei_information4		=> :old.aei_information4		,
			p_aei_information5		=> :old.aei_information5		,
			p_aei_information6		=> :old.aei_information6		,
			p_aei_information7		=> :old.aei_information7		,
			p_aei_information8		=> :old.aei_information8		,
			p_aei_information9		=> :old.aei_information9		,
			p_aei_information10		=> :old.aei_information10		,
			p_aei_information11		=> :old.aei_information11		,
			p_aei_information12		=> :old.aei_information12		,
			p_aei_information13		=> :old.aei_information13		,
			p_aei_information14		=> :old.aei_information14		,
			p_aei_information15		=> :old.aei_information15		,
			p_aei_information16		=> :old.aei_information16		,
			p_aei_information17		=> :old.aei_information17		,
			p_aei_information18		=> :old.aei_information18		,
			p_aei_information19		=> :old.aei_information19		,
			p_aei_information20		=> :old.aei_information20		,
			p_aei_information21		=> :old.aei_information21		,
			p_aei_information22		=> :old.aei_information22		,
			p_aei_information23		=> :old.aei_information23		,
			p_aei_information24		=> :old.aei_information24		,
			p_aei_information25		=> :old.aei_information25		,
			p_aei_information26		=> :old.aei_information26		,
			p_aei_information27		=> :old.aei_information27		,
			p_aei_information28		=> :old.aei_information28		,
			p_aei_information29		=> :old.aei_information29		,
			p_aei_information30		=> :old.aei_information30		,
			p_aei_attribute_category	=> :old.aei_attribute_category	,
			p_aei_attribute1			=> :old.aei_attribute1			,
			p_aei_attribute2			=> :old.aei_attribute2			,
			p_aei_attribute3			=> :old.aei_attribute3			,
			p_aei_attribute4			=> :old.aei_attribute4			,
			p_aei_attribute5			=> :old.aei_attribute5			,
			p_aei_attribute6			=> :old.aei_attribute6			,
			p_aei_attribute7			=> :old.aei_attribute7			,
			p_aei_attribute8			=> :old.aei_attribute8			,
			p_aei_attribute9			=> :old.aei_attribute9			,
			p_aei_attribute10			=> :old.aei_attribute10			,
			p_aei_attribute11			=> :old.aei_attribute11			,
			p_aei_attribute12			=> :old.aei_attribute12			,
			p_aei_attribute13			=> :old.aei_attribute13			,
			p_aei_attribute14			=> :old.aei_attribute14			,
			p_aei_attribute15			=> :old.aei_attribute15			,
			p_aei_attribute16			=> :old.aei_attribute16			,
			p_aei_attribute17			=> :old.aei_attribute17			,
			p_aei_attribute18			=> :old.aei_attribute18			,
			p_aei_attribute19			=> :old.aei_attribute19			,
			p_aei_attribute20			=> :old.aei_attribute20			,
--			p_object_version_number		=> :old.object_version_number 	,
			p_asgnei_data			=> p_old_assignment_ei_record		);

	END get_old_assignment_ei_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);

	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);

	IF l_session_var.fire_trigger = 'Y' THEN
	      hr_utility.set_location('Fire Trigger Y :'|| l_proc , 10);
		-- if session variable assignment_id id null assign it the value
		if l_session_var.assignment_id is null then
			l_session_var.assignment_id := :new.assignment_id;
			ghr_history_api.set_g_session_var( l_session_var);
		end if;

		IF lower(l_session_var.program_name) = 'core' then
			ghr_history_api.get_session_date( l_session_var.date_effective);
			ghr_history_api.set_g_session_var (l_session_var);
		END IF;
		IF (lower(l_session_var.program_name) = 'sf50' or lower(l_session_var.program_name) = 'core') then
			IF inserting THEN
				hr_utility.set_location( l_proc , 170);
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 160);
					ghr_history_api.set_operation_info(
					  p_table_name 		=> ghr_history_api.g_asgnei_table,
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.assignment_extra_info_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_assignment_ei_hist_data,
					  p_row_id			=> :new.rowid
					  );
			ELSIF updating THEN
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 140);
				get_old_assignment_ei_data( l_old_assignment_ei_data);
				ghr_history_conv_rg.conv_asgnei_rg_to_hist_rg( p_asgnei_data  => l_old_assignment_ei_data,
								   p_history_data => l_old_assignment_ei_hist_data);

				ghr_history_api.set_operation_info(
					p_table_name 		=> ghr_history_api.g_asgnei_table,
					p_program_name		=> l_session_var.program_name,
					p_date_Effective 		=> l_session_var.date_effective,
					p_table_pk_id		=> :new.assignment_extra_info_id,
					p_operation			=> 'update',
					p_old_record_data       => l_old_assignment_ei_hist_data,
					p_row_id			=> :new.rowid
					);
			ELSE /* ie deleting */
				hr_utility.set_location( l_proc , 120);
				ghr_history_api.get_g_session_var( l_session_var);
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
END GHR_PER_ASSIGN_EI_AFIUD;



/
ALTER TRIGGER "APPS"."GHR_PER_ASSIGN_EI_AFIUD" ENABLE;
