--------------------------------------------------------
--  DDL for Trigger GHR_HR_ALL_POSITIONS_F_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_AD" 
after delete
on "HR"."HR_ALL_POSITIONS_F"
BEGIN
    ghr_utility.g_position_being_deleted := FALSE;
END;

/
ALTER TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_AD" ENABLE;
