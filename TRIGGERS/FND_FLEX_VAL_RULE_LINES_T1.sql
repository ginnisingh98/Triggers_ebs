--------------------------------------------------------
--  DDL for Trigger FND_FLEX_VAL_RULE_LINES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T1" 
  BEFORE INSERT ON "APPLSYS"."FND_FLEX_VALIDATION_RULE_LINES" FOR EACH ROW
       WHEN (old.rule_line_id is null) DECLARE
    id_num  FND_FLEX_VALIDATION_RULE_LINES.RULE_LINE_ID%TYPE;
  BEGIN
    select FND_FLEX_VAL_RULE_LINES_S.nextval into id_num from sys.dual;
    :new.rule_line_id := id_num;
  EXCEPTION
    when OTHERS then
      FND_MESSAGE.set_name('FND', 'FLEX-SSV EXCEPTION');
      FND_MESSAGE.set_token('MSG', 'fnd_flex_val_rule_lines_t1() exception:  '
			    || SQLERRM);
      FND_MESSAGE.RAISE_ERROR;
  END;



/
ALTER TRIGGER "APPS"."FND_FLEX_VAL_RULE_LINES_T1" ENABLE;
