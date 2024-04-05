--------------------------------------------------------
--  DDL for Trigger FND_FLEX_VAL_RULE_LINES_T4
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T4" 
  BEFORE DELETE ON "APPLSYS"."FND_FLEX_VALIDATION_RULE_LINES" FOR EACH ROW
  
BEGIN
    if(FND_FLEX_TRIGGER.delete_rule_line(:old.rule_line_id,
		:old.application_id, :old.id_flex_code, :old.id_flex_num,
		:old.include_exclude_indicator) = FALSE) then
      FND_MESSAGE.RAISE_ERROR;
    end if;

  EXCEPTION
    when OTHERS then
      IF (SQLCODE = -20001) THEN
         FND_MESSAGE.RAISE_ERROR;
      ELSE
	 FND_MESSAGE.set_name('FND', 'FLEX-SSV EXCEPTION');
	 FND_MESSAGE.set_token('MSG', 'fnd_flex_val_rule_lines_t4() exception:  '
			       || SQLERRM);
	 FND_MESSAGE.RAISE_ERROR;
      END IF;
  END;



/
ALTER TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T4" ENABLE;
