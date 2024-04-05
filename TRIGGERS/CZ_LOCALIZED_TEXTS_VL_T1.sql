--------------------------------------------------------
--  DDL for Trigger CZ_LOCALIZED_TEXTS_VL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_VL_T1" 
	INSTEAD OF INSERT OR UPDATE OR DELETE
	ON CZ_LOCALIZED_TEXTS_VL
	REFERENCING NEW AS NEW_ROW OLD AS OLD_ROW

DECLARE
  text_id				number;			-- language-independent ID of the string
  curr_lang				varchar2 (4);	-- Current language, set from USERENV ('LANG')
  update_to_absent_row	boolean;		-- Flag indicates when a client UPDATE has fired against a 'foreign' row ;
  										-- This condition requires the _insertion_ of a new 'native' row
  upd8absent			number;
  NUMERICTRUE			constant NUMBER := 1;
  NUMERICFALSE			constant NUMBER := 0;
  converted_text		CZ_LOCALIZED_TEXTS.LOCALIZED_STR%TYPE;
begin
  curr_lang := userenv ('LANG');

  --	Get the language-independent ID
  if deleting then
  	text_id := :OLD_ROW.INTL_TEXT_ID;
  else
  	text_id := :NEW_ROW.INTL_TEXT_ID;
  end if;


  if updating then
  	-- UPDATE THE BASE TABLE
  	update cz_localized_texts
  	set
		deleted_flag 		= :NEW_ROW.deleted_flag,
		localized_str		= :NEW_ROW.text_str,
		source_lang			= curr_lang,
		orig_sys_ref		= :NEW_ROW.orig_sys_ref,
		eff_from			= :NEW_ROW.eff_from,
		eff_to				= :NEW_ROW.eff_to,
		eff_mask			= :NEW_ROW.eff_mask,
		checkout_user		= :NEW_ROW.checkout_user,
		security_mask		= :NEW_ROW.security_mask,
            model_id                = :NEW_ROW.model_id,
            ui_def_id               = :NEW_ROW.ui_def_id,
            persistent_intl_text_id = :NEW_ROW.persistent_intl_text_id,
            ui_page_id              = :NEW_ROW.ui_page_id,
            ui_page_element_id      = :NEW_ROW.ui_page_element_id,
            last_update_login       = :NEW_ROW.last_update_login
	WHERE intl_text_id = text_id and (language = curr_lang or source_lang = curr_lang);


	-- Did we find one to update?  If not, we need to insert the row
	-- Use the boolean flag...
	update_to_absent_row := (sql%rowcount = 0);
  else
  	update_to_absent_row := false;
  end if;

	if inserting or update_to_absent_row then
		IF update_to_absent_row then
			upd8absent := NUMERICTRUE;
		else
			upd8absent := NUMERICFALSE;
		end if;
		insert into cz_localized_texts (
			intl_text_id, language,
			deleted_flag, localized_str, source_lang,
			orig_sys_ref,
			eff_from, eff_to, eff_mask,
			checkout_user, security_mask,
                        model_id, ui_def_id, persistent_intl_text_id, ui_page_id, ui_page_element_id,
                  last_update_login
		)
		SELECT
			:new_row.intl_text_id,
			FND_LANGUAGES.LANGUAGE_CODE,
			nvl(:new_row.deleted_flag,'0'),
			:NEW_ROW.text_str,
			curr_lang,
			:new_row.orig_sys_ref,
			:new_row.eff_from, :new_row.eff_to, :new_row.eff_mask,
			:new_row.checkout_user, :new_row.security_mask,
                        :new_row.model_id, :new_row.ui_def_id, :new_row.persistent_intl_text_id,
                        :new_row.ui_page_id, :new_row.ui_page_element_id,
                  :new_row.last_update_login
		FROM FND_LANGUAGES
		WHERE INSTALLED_FLAG IN ('B', 'I')
		AND (NOT EXISTS (SELECT 1 FROM CZ_LOCALIZED_TEXTS
			WHERE LANGUAGE = FND_LANGUAGES.LANGUAGE_CODE
			AND INTL_TEXT_ID = :new_row.intl_text_id)
		OR (LANGUAGE_CODE = curr_lang and upd8absent = NUMERICTRUE)
		OR upd8absent = NUMERICFALSE
		);

	end if;

	if deleting then
		-- DELETE FROM SOURCE TABLE
		delete from cz_localized_texts
		where intl_text_id = text_id ;
	end if;

end CZ_LOCALIZED_TEXTS_VL_T1;

/
ALTER TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_VL_T1" ENABLE;
