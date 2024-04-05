--------------------------------------------------------
--  DDL for Trigger FTP_IRCS_VL_IR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FTP_IRCS_VL_IR1" 
 INSTEAD OF INSERT OR DELETE OR UPDATE  ON FTP_IRCS_vl
REFERENCING NEW AS NEW OLD AS OLD
BEGIN
-- *****************************************************************
-- ** INSTEAD-OF INSERT trigger on FTP_IRCS_VL(view). **
-- *****************************************************************
-- For each row, instead of insert on FTP_IRCS_VL,
-- insert into FTP_IRCS_TL for every language
IF INSERTING THEN
   INSERT INTO FTP_IRCS_B (
      interest_rate_code,
      irc_name,
      irc_format_code,
      iso_currency_code,
      compound_basis_code,
      accrual_basis_id,
      creation_date,
      created_by,
      last_updated_by,
      last_update_date,
      last_update_login,
      object_version_number)
      VALUES (
      :new.interest_rate_code,
      :new.irc_name,
      :new.irc_format_code,
      :new.iso_currency_code,
      :new.compound_basis_code,
      :new.accrual_basis_id,
      :new.creation_date,
      :new.created_by,
      :new.last_updated_by,
      :new.last_update_date,
      :new.last_update_login,
      :new.object_version_number);

   INSERT INTO FTP_IRCS_TL (
       interest_rate_code,
       description,
       language,
       source_lang,
       creation_date,
       created_by,
       last_updated_by,
       last_update_date,
       last_update_login,
       object_version_number)
       SELECT
       :new.interest_rate_code,
       :new.description,
       l.language_code,
       USERENV('LANG'),
       :new.creation_date,
       :new.created_by,
       :new.last_updated_by,
       :new.last_update_date,
       :new.last_update_login,
       :new.object_version_number
      FROM fnd_languages l
      WHERE l.installed_flag in ('I', 'B')
      AND NOT EXISTS
         (SELECT NULL FROM FTP_IRCS_TL tl
            WHERE tl.interest_rate_code = :new.interest_rate_code
            AND tl.language = l.language_code);

-- ** INSTEAD-OF UPDATE trigger on FTP_IRCS_VL(view). **
-- *****************************************************************
-- For each row, instead of updating FTP_IRCS_VL,
-- update FTP_IRCS_B and FTP_IRCS_TL
ELSIF UPDATING THEN
   UPDATE FTP_IRCS_B SET
      interest_rate_code = :new.interest_rate_code,
      irc_name = :new.irc_name,
      irc_format_code	 = :new.irc_format_code,
      iso_currency_code  = :new.iso_currency_code,
      compound_basis_code = :new.compound_basis_code,
      accrual_basis_id = :new.accrual_basis_id,
      last_updated_by = :new.last_updated_by,
      last_update_date = :new.last_update_date,
      last_update_login = :new.last_update_login,
      object_version_number =:new.object_version_number
      WHERE interest_rate_code = :old.interest_rate_code;

   UPDATE FTP_IRCS_TL SET
      description = :new.description,
      language = USERENV('LANG'),
      last_updated_by = :new.last_updated_by,
      last_update_date = :new.last_update_date,
      last_update_login = :new.last_update_login,
      object_version_number =:new.object_version_number
      WHERE interest_rate_code = :old.interest_rate_code
      AND language = USERENV('LANG');
-- *****************************************************************
-- ** INSTEAD-OF DELETE trigger on FTP_IRCS_VL(view). **
-- *****************************************************************
-- For each row, instead of deleting from FTP_IRCS_VL,
-- delete from FTP_IRCS_B and FTP_IRCS_TL
ELSIF DELETING THEN
   DELETE FTP_IRCS_TL
   WHERE interest_rate_code = :old.interest_rate_code;

   DELETE FTP_IRCS_B
   WHERE interest_rate_code = :old.interest_rate_code;
END IF;
END FTP_IRCS_VL_IR1;



/
ALTER TRIGGER "APPS"."FTP_IRCS_VL_IR1" ENABLE;
