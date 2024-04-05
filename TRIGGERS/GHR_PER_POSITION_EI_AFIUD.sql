--------------------------------------------------------
--  DDL for Trigger GHR_PER_POSITION_EI_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PER_POSITION_EI_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_POSITION_EXTRA_INFO" FOR EACH ROW

DECLARE
	l_session_var		ghr_history_api.g_session_var_type;
	l_old_position_ei_data		per_position_extra_info%rowtype;
	l_old_position_ei_hist_data	ghr_pa_history%rowtype;
	l_proc			varchar2(40):='per_position_ei_afiud';

	PROCEDURE get_old_position_ei_data( p_old_position_ei_record in out per_position_extra_info%rowtype) IS
	BEGIN
		ghr_history_conv_rg.conv_to_positionei_rg (
			p_position_extra_info_id	=> :old.position_extra_info_id	,
			p_position_id			=> :old.position_id			,
			p_information_type		=> :old.information_type		,
			p_poei_information_category	=> :old.poei_information_category	,
			p_poei_information1		=> :old.poei_information1		,
			p_poei_information2		=> :old.poei_information2		,
			p_poei_information3		=> :old.poei_information3		,
			p_poei_information4		=> :old.poei_information4		,
			p_poei_information5		=> :old.poei_information5		,
			p_poei_information6		=> :old.poei_information6		,
			p_poei_information7		=> :old.poei_information7		,
			p_poei_information8		=> :old.poei_information8		,
			p_poei_information9		=> :old.poei_information9		,
			p_poei_information10		=> :old.poei_information10		,
			p_poei_information11		=> :old.poei_information11		,
			p_poei_information12		=> :old.poei_information12		,
			p_poei_information13		=> :old.poei_information13		,
			p_poei_information14		=> :old.poei_information14		,
			p_poei_information15		=> :old.poei_information15		,
			p_poei_information16		=> :old.poei_information16		,
			p_poei_information17		=> :old.poei_information17		,
			p_poei_information18		=> :old.poei_information18		,
			p_poei_information19		=> :old.poei_information19		,
			p_poei_information20		=> :old.poei_information20		,
			p_poei_information21		=> :old.poei_information21		,
			p_poei_information22		=> :old.poei_information22		,
			p_poei_information23		=> :old.poei_information23		,
			p_poei_information24		=> :old.poei_information24		,
			p_poei_information25		=> :old.poei_information25		,
			p_poei_information26		=> :old.poei_information26		,
			p_poei_information27		=> :old.poei_information27		,
			p_poei_information28		=> :old.poei_information28		,
			p_poei_information29		=> :old.poei_information29		,
			p_poei_information30		=> :old.poei_information30		,
			p_poei_attribute_category	=> :old.poei_attribute_category	,
			p_poei_attribute1			=> :old.poei_attribute1			,
			p_poei_attribute2			=> :old.poei_attribute2			,
			p_poei_attribute3			=> :old.poei_attribute3			,
			p_poei_attribute4			=> :old.poei_attribute4			,
			p_poei_attribute5			=> :old.poei_attribute5			,
			p_poei_attribute6			=> :old.poei_attribute6			,
			p_poei_attribute7			=> :old.poei_attribute7			,
			p_poei_attribute8			=> :old.poei_attribute8			,
			p_poei_attribute9			=> :old.poei_attribute9			,
			p_poei_attribute10		=> :old.poei_attribute10			,
			p_poei_attribute11		=> :old.poei_attribute11			,
			p_poei_attribute12		=> :old.poei_attribute12			,
			p_poei_attribute13		=> :old.poei_attribute13			,
			p_poei_attribute14		=> :old.poei_attribute14			,
			p_poei_attribute15		=> :old.poei_attribute15			,
			p_poei_attribute16		=> :old.poei_attribute16			,
			p_poei_attribute17		=> :old.poei_attribute17			,
			p_poei_attribute18		=> :old.poei_attribute18			,
			p_poei_attribute19		=> :old.poei_attribute19			,
			p_poei_attribute20		=> :old.poei_attribute20			,
--			p_object_version_number		=> :old.object_version_number 	,
			p_position_extra_info_data	=> p_old_position_ei_record		);
	END get_old_position_ei_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var (l_session_var);

	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);


	IF l_session_var.fire_trigger = 'Y' THEN
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
					  p_table_name 		=> ghr_history_api.g_posnei_table,
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.position_extra_info_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_position_ei_hist_data,
					  p_row_id			=> :new.rowid
					  );
			ELSIF updating THEN
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 140);
				get_old_position_ei_data( l_old_position_ei_data);
				ghr_history_conv_rg.conv_positionei_rg_to_hist_rg( p_position_ei_data  => l_old_position_ei_data,
								   p_history_data => l_old_position_ei_hist_data);

				ghr_history_api.set_operation_info(
					p_table_name 		=> ghr_history_api.g_posnei_table,
					p_program_name		=> l_session_var.program_name,
					p_date_Effective 		=> l_session_var.date_effective,
					p_table_pk_id		=> :new.position_extra_info_id,
					p_operation			=> 'update',
					p_old_record_data       => l_old_position_ei_hist_data,
					p_row_id			=> :new.rowid
					);
			ELSE /* ie deleting */
				hr_utility.set_location( l_proc , 120);
				ghr_history_api.get_g_session_var( l_session_var);
				/* Need to discuss with functionals to decide if we should allow deletes */
				NULL;
			END IF;
		ELSE /* Not a known type */
		      hr_utility.set_location('Unknown Program Name - ' || l_session_var.program_name ||' :' || l_proc , 10);
			hr_utility.set_message( 8301, 'GHR_UNKNOWN_PGM_TYPE');
			fnd_message.set_token('PROGRAM_TYPE', l_session_var.program_name);
			hr_utility.raise_error;			-- raise error
			/* History not maintained */
		END IF;
	END IF;
      hr_utility.set_location('Leaving:'|| l_proc , 1);
END GHR_PER_POSITION_EI_AFIUD;



/
ALTER TRIGGER "APPS"."GHR_PER_POSITION_EI_AFIUD" ENABLE;
