--------------------------------------------------------
--  DDL for Trigger FND_FLEX_VAL_RULE_LINES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T2" 
  AFTER INSERT ON "APPLSYS"."FND_FLEX_VALIDATION_RULE_LINES" FOR EACH ROW
  
BEGIN
    if(FND_FLEX_TRIGGER.insert_rule_line(:new.rule_line_id,:new.application_id,
	:new.id_flex_code, :new.id_flex_num, :new.flex_validation_rule_name,
	:new.include_exclude_indicator, :new.enabled_flag, :new.created_by,
	:new.creation_date, :new.last_update_date, :new.last_updated_by,
	:new.last_update_login, :new.concatenated_segments_low,
	:new.concatenated_segments_high) = FALSE) then
      FND_MESSAGE.RAISE_ERROR;
    end if;

  EXCEPTION
    when OTHERS then
      IF (SQLCODE = -20001) THEN
         FND_MESSAGE.RAISE_ERROR;
      ELSE
	 FND_MESSAGE.set_name('FND', 'FLEX-SSV EXCEPTION');
	 FND_MESSAGE.set_token('MSG', 'fnd_flex_val_rule_lines_t2() exception:  '
			       || SQLERRM);
	 FND_MESSAGE.RAISE_ERROR;
      END IF;
  END;



/
ALTER TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T2" ENABLE;
