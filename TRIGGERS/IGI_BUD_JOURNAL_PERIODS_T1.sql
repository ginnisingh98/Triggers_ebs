--------------------------------------------------------
--  DDL for Trigger IGI_BUD_JOURNAL_PERIODS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_BUD_JOURNAL_PERIODS_T1" 
AFTER INSERT ON "IGI"."IGI_BUD_JOURNAL_PERIODS"
FOR EACH ROW
  WHEN (NEW.RECORD_TYPE = 'U') DECLARE

/* Bug 1979303 sekhar 13-sep-01
 added cursor to get the user je source name */
 CURSOR get_user_je_source IS
 select user_je_source_name
 from gl_je_sources
 where je_source_name = 'IGIGBMJL'
 and language = userenv('LANG');

  /* Bug 1979303 sekhar 13-sep-01
  added following variable for user_je_source name     */
  l_user_je_source_name varchar2(25);


BEGIN

  IF IGI_GEN.IS_REQ_INSTALLED('BUD') THEN

 /* bug 1979303 sekhar
    Modified and correct parameter is passed */

    OPEN get_user_je_source;
    FETCH get_user_je_source INTO l_user_je_source_name;
    CLOSE get_user_je_source;
    INSERT INTO GL_INTERFACE (
		STATUS,
		CREATED_BY,
		DATE_CREATED,
		GROUP_ID,
		SET_OF_BOOKS_ID,
		ACTUAL_FLAG,
		USER_JE_CATEGORY_NAME,
		USER_JE_SOURCE_NAME,
		BUDGET_VERSION_ID,
		CURRENCY_CODE,
		ACCOUNTING_DATE,
		CODE_COMBINATION_ID,
		ENTERED_CR,
		ENTERED_DR,
		PERIOD_NAME,
		REFERENCE1,
		REFERENCE2,
		REFERENCE4,
		REFERENCE5,
		REFERENCE7,
		REFERENCE10,
		REFERENCE21,
		REFERENCE22,
		REFERENCE23,
		REFERENCE24,
		REFERENCE25,
		REFERENCE26,
		REFERENCE27,
		REFERENCE28,
		REFERENCE29,
		REFERENCE30)
    SELECT
		'NEW-IGIGBJ',
		'-1',
		SYSDATE,
		jubjb.BE_BATCH_ID,
		jubjb.SET_OF_BOOKS_ID,
		'B',
		gjc.USER_JE_CATEGORY_NAME,
		l_user_je_source_name,
		jubjh.BUDGET_VERSION_ID,
		jubjh.CURRENCY_CODE,
		SYSDATE,
		jubjl.CODE_COMBINATION_ID,
		:NEW.ENTERED_CR,
		:NEW.ENTERED_DR,
		:NEW.PERIOD_NAME,
		jubjb.NAME,
		jubjb.NAME,
		jubjh.NAME,
		jubjh.DESCRIPTION,
		'N',
		jubjl.DESCRIPTION,
		'IGIGBUDPR',
		jubjb.BE_BATCH_ID,
		jubjl.PROFILE_CODE,
		jubjl.REASON_CODE,
		jubjl.START_PERIOD,
		jubjl.RECURRING_ENTRY,
		jubjl.FYE_PYE_ENTRY,
		:NEW.NEXT_YEAR_BUDGET,
		jubjh.BE_HEADER_ID,
		:NEW.BE_LINE_NUM
   FROM
		IGI_BUD_JOURNAL_BATCHES jubjb,
		IGI_BUD_JOURNAL_HEADERS jubjh,
		IGI_BUD_JOURNAL_LINES   jubjl,
		GL_JE_CATEGORIES gjc
   WHERE
		jubjb.BE_BATCH_ID = :NEW.BE_BATCH_ID
   AND		jubjh.BE_HEADER_ID = :NEW.BE_HEADER_ID
   AND		jubjl.BE_HEADER_ID = :NEW.BE_HEADER_ID
   AND		jubjl.BE_LINE_NUM = :NEW.BE_LINE_NUM
   AND		gjc.JE_CATEGORY_NAME = jubjh.JE_CATEGORY_NAME;

  END IF; -- is req installed check

END;

/
ALTER TRIGGER "APPS"."IGI_BUD_JOURNAL_PERIODS_T1" ENABLE;
