--------------------------------------------------------
--  DDL for Trigger SSP_MAT_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_MAT_T2" 
AFTER INSERT OR DELETE OR UPDATE
OF ACTUAL_BIRTH_DATE
,  DUE_DATE
,  LIVE_BIRTH_FLAG
,  MPP_START_DATE
,  NOTIFICATION_OF_BIRTH_DATE
,  PAY_SMP_AS_LUMP_SUM
,  START_DATE_WITH_NEW_EMPLOYER
ON "SSP"."SSP_MATERNITIES"

DECLARE
BEGIN
  ssp_smp_support_pkg.recalculate_ssp_and_smp;
END;



/
ALTER TRIGGER "APPS"."SSP_MAT_T2" ENABLE;
