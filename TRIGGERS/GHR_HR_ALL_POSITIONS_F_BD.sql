--------------------------------------------------------
--  DDL for Trigger GHR_HR_ALL_POSITIONS_F_BD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_BD" 
before delete
on "HR"."HR_ALL_POSITIONS_F"
BEGIN
    ghr_utility.g_position_being_deleted := TRUE;
END;

/
ALTER TRIGGER "APPS"."GHR_HR_ALL_POSITIONS_F_BD" ENABLE;
