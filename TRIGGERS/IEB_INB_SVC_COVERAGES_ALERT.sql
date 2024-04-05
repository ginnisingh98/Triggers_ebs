--------------------------------------------------------
--  DDL for Trigger IEB_INB_SVC_COVERAGES_ALERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IEB_INB_SVC_COVERAGES_ALERT" 
 AFTER DELETE OR INSERT OR UPDATE OF ISVCCOV_ID, MIN_AGENT, PERCENTAGE, TIME_THRESHOLD, REROUTE_TIME, MAX_WAIT_TIME, REROUTE_WARNING_TIME, SCHEDULE_TYPE, REGULAR_SCHD_DAY, SVCPLN_SVCPLN_ID, SPEC_SCHD_DATE, BEGIN_TIME_HHMM, END_TIME_HHMM
 ON "IEB"."IEB_INB_SVC_COVERAGES"
BEGIN
DBMS_ALERT.SIGNAL('IEB_INB_SVC_COVERAGES_ALERT', 'IEB_INB_SVC_COVERAGES');
END IEB_INB_SVC_COVERAGES_ALERT;



/
ALTER TRIGGER "APPS"."IEB_INB_SVC_COVERAGES_ALERT" ENABLE;
