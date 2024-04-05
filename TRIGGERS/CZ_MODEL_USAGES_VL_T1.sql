--------------------------------------------------------
--  DDL for Trigger CZ_MODEL_USAGES_VL_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_MODEL_USAGES_VL_T1" 
INSTEAD OF INSERT OR UPDATE ON CZ_MODEL_USAGES_VL
REFERENCING NEW AS NEW_ROW OLD AS OLD_ROW
DECLARE
  curr_lang varchar2(4);
BEGIN
  curr_lang:=userenv('LANG');
  IF UPDATING THEN

     UPDATE cz_model_usages
     SET
     model_usage_id =:NEW_ROW.model_usage_id,
     NAME=:NEW_ROW.name,
     NOTE=:NEW_ROW.NOTE,
     IN_USE=:NEW_ROW.IN_USE
     WHERE model_usage_id =:NEW_ROW.model_usage_id;


     IF (:NEW_ROW.IN_USE=:OLD_ROW.IN_USE)  /*either being created ir just ordinary updates*/
     THEN

        UPDATE cz_model_usages_TL SET
        DESCRIPTION=:NEW_ROW.DESCRIPTION,
        SOURCE_LANG = curr_lang
        WHERE model_usage_id=:NEW_ROW.model_usage_id
        AND curr_lang IN (LANGUAGE,SOURCE_LANG);

     ELSE

        IF(:NEW_ROW.IN_USE='1')/*reusing a deleted usage*/
        THEN

            UPDATE cz_model_usages_TL SET
            DESCRIPTION=:NEW_ROW.DESCRIPTION,
            SOURCE_LANG = curr_lang
            WHERE model_usage_id=:NEW_ROW.model_usage_id;

        ELSE /*usage being deleted*/

           UPDATE cz_model_usages_tl set description=:NEW_ROW.NAME
           where MODEL_USAGE_ID =:NEW_ROW.MODEL_USAGE_ID;

	END IF;
     END if;

  END if;

  IF INSERTING  THEN
      INSERT INTO cz_model_usages(
        MODEL_USAGE_ID,
        NAME,
        NOTE,
        IN_USE
      ) VALUES (
 	:NEW_ROW.MODEL_USAGE_ID,
         :NEW_ROW.NAME,
 	:NEW_ROW.NOTE,
 	:NEW_ROW.IN_USE
     );

      INSERT INTO CZ_MODEL_USAGES_TL (
 	MODEL_USAGE_ID,
         DESCRIPTION,
         LANGUAGE,
 	SOURCE_LANG
      ) SELECT
          :NEW_ROW.MODEL_USAGE_ID,
          :NEW_ROW.DESCRIPTION,
          L.LANGUAGE_CODE,
          curr_lang
       FROM FND_LANGUAGES L
       WHERE L.INSTALLED_FLAG in ('I', 'B')
       AND NOT EXISTS
        (SELECT NULL
        FROM cz_model_usages_TL T
        WHERE T.MODEL_USAGE_ID =:NEW_ROW.MODEL_USAGE_ID
        AND T.LANGUAGE = L.LANGUAGE_CODE);
  END IF;
END CZ_MODEL_USAGES_VL_T1;

/
ALTER TRIGGER "APPS"."CZ_MODEL_USAGES_VL_T1" ENABLE;
