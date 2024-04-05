--------------------------------------------------------
--  DDL for Trigger FND_PROD_LIC_TGR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_PROD_LIC_TGR" 
    AFTER UPDATE or INSERT on "APPLSYS"."FND_PRODUCT_INSTALLATIONS"
    FOR EACH ROW
BEGIN
  DECLARE
    l_AppShortCode varchar(50);
  BEGIN
    select APPLICATION_SHORT_NAME
    into l_AppShortCode
    from fnd_application
    where application_id = :new.APPLICATION_ID;

    wf_event_functions_pkg.UpdateLicenseStatus(l_AppShortCode,  :new.status);

 END;
END;



/
ALTER TRIGGER "APPS"."FND_PROD_LIC_TGR" ENABLE;
