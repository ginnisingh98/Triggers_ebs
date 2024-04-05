--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ADDR_HIST_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ADDR_HIST_BRU" 
-- $Header: pahraddr.sql 120.1 2005/06/16 18:14:09 appldev  $
BEFORE UPDATE OF
COUNTRY,
TOWN_OR_CITY,
REGION_2,
DATE_FROM,
DATE_TO,
PRIMARY_FLAG
ON "HR"."PER_ADDRESSES"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_exists             VARCHAR2(1) := 'N';
BEGIN
       v_return_status := FND_API.G_RET_STS_SUCCESS;
       -- Add an additional OR to check whether resource already in
       -- pa_resources_denorm.
       BEGIN
       SELECT 'Y'
       INTO   l_exists
       FROM   dual
       WHERE  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  person_id = :new.person_id
                      AND    rownum = 1);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             l_exists := 'N';
       END;

       IF (l_exists = 'Y') THEN -- Bug 4387456 - only update if person exists
           -- PA_INSTALL.is_prm_licensed = 'Y' OR
           -- PA_INSTALL.is_utilization_implemented = 'Y') THEN
          -- call the work flow to update pa objects
       IF  nvl(:old.primary_flag,'N') = 'Y' or nvl(:new.primary_flag,'N') = 'Y' then
         pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'UPDATE'
            ,p_table_name         => 'PER_ADDRESSES'
            ,p_person_id          => :new.person_id
            ,p_country_old        => :old.country
            ,p_country_new        => :new.country
            ,p_city_old           => :old.town_or_city
            ,p_city_new           => :new.town_or_city
            ,p_region2_old        => :old.region_2
            ,p_region2_new        => :new.region_2
            ,p_start_date_old      => :old.date_from
            ,p_start_date_new      => :new.date_from
            ,p_end_date_old        =>:old.date_to
            ,p_end_date_new        => :new.date_to
            ,p_primary_flag_old    => :old.primary_flag
            ,p_primary_flag_new    => :new.primary_flag
            ,x_return_status      => v_return_status
            ,x_error_message_code => v_error_message_code);
      End if;
     END IF;

Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ADDR_HIST_BRU" ENABLE;
