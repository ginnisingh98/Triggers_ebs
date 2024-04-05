--------------------------------------------------------
--  DDL for Trigger FND_FLEX_VALIDATION_RULES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_FLEX_VALIDATION_RULES_T3" 
  AFTER DELETE ON "APPLSYS"."FND_FLEX_VALIDATION_RULES" FOR EACH ROW
  
BEGIN
    if(FND_FLEX_TRIGGER.update_cvr_stats(:old.application_id,
		:old.id_flex_code, :old.id_flex_num, -1, 0, 0) = FALSE) then
      FND_MESSAGE.RAISE_ERROR;
    end if;
  EXCEPTION
    when OTHERS then
      IF (SQLCODE = -20001) THEN
         FND_MESSAGE.RAISE_ERROR;
      ELSE
	 FND_MESSAGE.set_name('FND', 'FLEX-SSV EXCEPTION');
	 FND_MESSAGE.set_token('MSG', 'fnd_flex_validation_rules_t3() exception: '
			       || SQLERRM);
	 FND_MESSAGE.RAISE_ERROR;
      END IF;
  END;



/
ALTER TRIGGER "APPS"."FND_FLEX_VALIDATION_RULES_T3" ENABLE;
