--------------------------------------------------------
--  DDL for Trigger GHR_PERSON_ANALYSES_AFIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PERSON_ANALYSES_AFIUD" AFTER INSERT OR UPDATE OR DELETE ON "HR"."PER_PERSON_ANALYSES" FOR EACH ROW

DECLARE

	l_session_var			ghr_history_api.g_session_var_type;
	l_old_peranalyses_data		per_person_analyses%rowtype;
	l_old_peranalyses_hist_data	ghr_pa_history%rowtype;
	l_sequence_number			number;
	l_proc				varchar2(40):='per_person_analyses_afiud';

	PROCEDURE get_old_person_analysis_data( p_person_analyses_data in out per_person_analyses%rowtype) IS
	BEGIN
	ghr_history_conv_rg.conv_to_peranalyses_rg(
      p_person_analysis_id             => :old.person_analysis_id             ,
      p_business_group_id              => :old.business_group_id              ,
      p_analysis_criteria_id           => :old.analysis_criteria_id           ,
      p_person_id                      => :old.person_id                      ,
--    p_comments                       => :old.comments                       ,
      p_date_from                      => :old.date_from                      ,
      p_date_to                        => :old.date_to                        ,
      p_id_flex_num                    => :old.id_flex_num                    ,
      p_request_id                     => :old.request_id                     ,
      p_program_application_id         => :old.program_application_id         ,
      p_program_id                     => :old.program_id                     ,
      p_program_update_date            => :old.program_update_date            ,
      p_attribute_category             => :old.attribute_category             ,
      p_attribute1                     => :old.attribute1                     ,
      p_attribute2                     => :old.attribute2                     ,
      p_attribute3                     => :old.attribute3                     ,
      p_attribute4                     => :old.attribute4                     ,
      p_attribute5                     => :old.attribute5                     ,
      p_attribute6                     => :old.attribute6                     ,
      p_attribute7                     => :old.attribute7                     ,
      p_attribute8                     => :old.attribute8                     ,
      p_attribute9                     => :old.attribute9                     ,
      p_attribute10                    => :old.attribute10                    ,
      p_attribute11                    => :old.attribute11                    ,
      p_attribute12                    => :old.attribute12                    ,
      p_attribute13                    => :old.attribute13                    ,
      p_attribute14                    => :old.attribute14                    ,
      p_attribute15                    => :old.attribute15                    ,
      p_attribute16                    => :old.attribute16                    ,
      p_attribute17                    => :old.attribute17                    ,
      p_attribute18                    => :old.attribute18                    ,
      p_attribute19                    => :old.attribute19                    ,
      p_attribute20                    => :old.attribute20                    ,
      p_peranalyses_data               => p_person_analyses_data);

	END get_old_person_analysis_data;

BEGIN
      hr_utility.set_location('Entering:'|| l_proc , 1);
	ghr_history_api.get_g_session_var( l_session_var);

	hr_utility.set_location('Program Name : ' || l_session_var.program_name, 1);
	hr_utility.set_location('Fire Trigger : ' || l_session_var.fire_trigger, 1);


	IF l_session_var.fire_trigger = 'Y' THEN
		-- if session variable person_id id null assign it the value
		if l_session_var.person_id is null then
			l_session_var.person_id := :new.person_id;
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
					  p_table_name 		=> ghr_history_api.g_perana_table,
					  p_program_name  	=> l_session_var.program_name,
					  p_date_effective 	=> l_session_var.date_effective,
					  p_table_pk_id		=> :new.person_analysis_id,
					  p_operation		=> 'insert',
					  p_old_record_data     => l_old_peranalyses_hist_data,
					  p_row_id			=> :new.rowid
					  );
			ELSIF updating THEN
				ghr_history_api.get_g_session_var( l_session_var);
				hr_utility.set_location( l_proc , 140);
				get_old_person_analysis_data( l_old_peranalyses_data);
				ghr_history_conv_rg.conv_peranalyses_rg_to_hist_rg(
					p_peranalyses_data  => l_old_peranalyses_data,
					p_history_data => l_old_peranalyses_hist_data);

				ghr_history_api.set_operation_info(
					p_table_name 		=> ghr_history_api.g_perana_table,
					p_program_name		=> l_session_var.program_name,
					p_date_Effective 		=> l_session_var.date_effective,
					p_table_pk_id		=> :new.person_analysis_id,
					p_operation			=> 'update',
					p_old_record_data       => l_old_peranalyses_hist_data,
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
	End if;
      hr_utility.set_location('Leaving:'|| l_proc , 1);
END GHR_PERSON_ANALYSES_AFIUD;


/
ALTER TRIGGER "APPS"."GHR_PERSON_ANALYSES_AFIUD" ENABLE;
