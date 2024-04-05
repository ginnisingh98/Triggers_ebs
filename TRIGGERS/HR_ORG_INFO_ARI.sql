--------------------------------------------------------
--  DDL for Trigger HR_ORG_INFO_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_ORG_INFO_ARI" AFTER INSERT
ON "HR"."HR_ORGANIZATION_INFORMATION"  FOR EACH ROW
/*
-- Copyright (C) 1992 Oracle Corporation UK Ltd., Chertsey, England.
-- All rights reserved.
-- Name : hr_org_info_ari :Trigger will insert Business Group details when
--        Org is defined as a business group.
-- 70.0 02-DEC-92 SZWILLIA  Date Created
-- 70.1 03-DEC-92 SZWILLIA  Failed again
-- 70.2 12-JAN-93 SZWILLIA  Corrected WHEN statement.
-- 70.3 20-JAN-93 SZWILLIA  Corrected error handling
-- 70.4 12-MAR-93 PKATTWOOD Added exit to end of file
-- 70.5 20-MAY-93 AMCGHEE   Removed alot of comments (RDBMS bug)
-- 70.10 26-APR-95 JTHURING context = 'Business Group Information'; was:
--			    context='CLASS' and org_info1='HR_BG'
-- 110.1 20-aug-97 KHABIBUL removed drop trigger command and changed
--			    create to create or replace. This was done
--			    to avoid the ORA- error which would have been
--			    raised by the drop command if the trigger
--			    didn't exist (Part of Clean up process for R11).
-- 115.0 25-Jan-99 sxshah  HRMS Data migrator changes.
-- 115.1 05-Jun-00 ccarter  Added org_information6 parameter to
--                          insert_bus_grp_details in order to be
--                          able to create a Job Group each time a
--                          Business Group is created.
-- 115.2 25-jan-02 mbocutt  added dbdrv and checkfile
-- 115.9 06-aug-02 vbanner  changed checkfile to nocheck so file always runs
*/

   WHEN (new.org_information_context = 'Business Group Information' ) begin
 if hr_general.g_data_migrator_mode <> 'Y' then
  hr_organization.insert_bus_grp_details(:new.organization_id
                                        ,:new.org_information9
				        ,:new.org_information6
                                        ,:new.last_update_date
                                        ,:new.last_updated_by
                                        ,:new.last_update_login
                                        ,:new.created_by
                                        ,:new.creation_date);
 end if;
end hr_org_info_ari;


/
ALTER TRIGGER "APPS"."HR_ORG_INFO_ARI" ENABLE;
