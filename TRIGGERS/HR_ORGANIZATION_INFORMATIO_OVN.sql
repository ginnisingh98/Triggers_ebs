--------------------------------------------------------
--  DDL for Trigger HR_ORGANIZATION_INFORMATIO_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_ORGANIZATION_INFORMATIO_OVN" 
BEFORE INSERT OR UPDATE ON "HR"."HR_ORGANIZATION_INFORMATION"
FOR EACH ROW
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
 IF NOT hr_ori_shd.return_api_dml_status THEN
   IF INSERTING THEN
     :NEW.object_version_number := 1;
   ELSE
     :NEW.object_version_number := :OLD.object_version_number + 1;
   END IF;
 END IF;

end if;
END HR_ORGANIZATION_INFORMATIO_OVN;


/
ALTER TRIGGER "APPS"."HR_ORGANIZATION_INFORMATIO_OVN" ENABLE;
