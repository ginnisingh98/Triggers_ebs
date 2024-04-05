--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ADDR_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ADDR_HIST_BRI" 
-- $Header: pahraddr.sql 120.1 2005/06/16 18:14:09 appldev  $
BEFORE INSERT
ON "HR"."PER_ADDRESSES"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_exists             VARCHAR2(1) := 'N';
BEGIN

       v_return_status := FND_API.G_RET_STS_SUCCESS;

       -- Add check whether resource already in pa_resources_denorm.

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

       -- IF (PA_INSTALL.is_prm_licensed = 'Y' OR
       --     PA_INSTALL.is_utilization_implemented = 'Y') THEN

       If nvl(:new.primary_flag,'N')  = 'Y' then
        -- call the work flow to update pa objects
         pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'INSERT'
            ,p_table_name         => 'PER_ADDRESSES'
            ,p_person_id          => :new.person_id
            ,p_country_old        => NULL
            ,p_country_new        => :new.country
            ,p_city_old           => NULL
            ,p_city_new           => :new.town_or_city
            ,p_region2_old        => NULL
            ,p_region2_new        => :new.region_2
            ,p_start_date_old      => NULL
            ,p_start_date_new      => :new.date_from
            ,p_end_date_old        => NULL
            ,p_end_date_new        => :new.date_to
            ,p_primary_flag_old    => NULL
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
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ADDR_HIST_BRI" ENABLE;
