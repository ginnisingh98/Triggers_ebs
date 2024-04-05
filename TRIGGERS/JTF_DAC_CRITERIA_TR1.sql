--------------------------------------------------------
--  DDL for Trigger JTF_DAC_CRITERIA_TR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JTF_DAC_CRITERIA_TR1" 
AFTER INSERT ON JTF.JTF_DAC_CRITERIA
FOR EACH ROW
DECLARE
    PRINCIPAL_NAME VARCHAR2(255) ;
    PERMISSION_NAME VARCHAR2(255) ;
    ROLE_PERM_REC JTF_DAC_ROLE_PERMS%ROWTYPE;
BEGIN

SELECT * INTO ROLE_PERM_REC FROM JTF_DAC_ROLE_PERMS WHERE ROLE_PERM_ID = :new.ROLE_PERM_ID;

SELECT PERMISSION_NAME INTO PERMISSION_NAME FROM JTF_AUTH_PERMISSIONS_B WHERE
  JTF_AUTH_PERMISSION_ID = ROLE_PERM_REC.PERMISSION_ID;

SELECT PRINCIPAL_NAME INTO PRINCIPAL_NAME FROM JTF_AUTH_PRINCIPALS_B WHERE
  JTF_AUTH_PRINCIPAL_ID = ROLE_PERM_REC.ROLE_ID;

INSERT INTO JTF_DAC_ROLE_PERM_CRIT(ROLE_PERM_CRIT_ID,ROLE_PERM_ID,CRITERIA_ID,JTF_AUTH_PRINCIPAL_ID,
   JTF_AUTH_PERMISSION_ID,PRINCIPAL_NAME,PERMISSION_NAME,BASE_OBJECT,BASE_OBJECT_TYPE,START_ACTIVE_DATE,
   END_ACTIVE_DATE,PROPERTY_NAME, OPERATOR, PROPERTY_VALUE, PROPERTY_VALUE_TYPE, CREATION_DATE,
   CREATED_BY,LAST_UPDATE_DATE,LAST_UPDATED_BY,LAST_UPDATE_LOGIN,OBJECT_VERSION_NUMBER)
   values (JTF_DAC_ROLE_PERM_CRIT_S1.nextVal, :new.ROLE_PERM_ID, :new.CRITERIA_ID,ROLE_PERM_REC.ROLE_ID,
   ROLE_PERM_REC.PERMISSION_ID,PRINCIPAL_NAME, PERMISSION_NAME, ROLE_PERM_REC.BASE_OBJECT,
   ROLE_PERM_REC.BASE_OBJECT_TYPE,ROLE_PERM_REC.START_ACTIVE_DATE, ROLE_PERM_REC.END_ACTIVE_DATE,
   :new.property_name, :new.operator,:new.property_value,:new.property_value_type, SYSDATE,
   :new.created_by,SYSDATE, :new.LAST_UPDATED_BY,:new.last_update_login,:new.object_version_number);
END ;


/
ALTER TRIGGER "APPS"."JTF_DAC_CRITERIA_TR1" ENABLE;
