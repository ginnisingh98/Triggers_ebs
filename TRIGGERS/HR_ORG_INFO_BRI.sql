--------------------------------------------------------
--  DDL for Trigger HR_ORG_INFO_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_ORG_INFO_BRI" BEFORE INSERT
ON "HR"."HR_ORGANIZATION_INFORMATION"
FOR EACH ROW
     WHEN (new.org_information_context = 'Business Group Information' ) DECLARE

CURSOR c_sg_enabled
IS
SELECT 'Y'
  FROM fnd_profile_options fpo
      ,fnd_profile_option_values pov
 WHERE fpo.profile_option_name = 'ENABLE_SECURITY_GROUPS'
   AND fpo.profile_option_id = pov.profile_option_id
   AND fpo.application_id = pov.application_id
   AND pov.level_id = 10002
   AND pov.profile_option_value = 'Y'
   AND to_number(pov.level_value) BETWEEN 800 AND 900;
--
CURSOR c_sec_grp_name_curs IS
SELECT substrb(security_group_name, 1, 80)
  FROM fnd_security_groups_tl;
--
CURSOR c_sec_grp_name_length (p_owner VARCHAR2) IS
SELECT data_length
  FROM all_tab_columns
 WHERE column_name='SECURITY_GROUP_NAME'
   AND table_name='FND_SECURITY_GROUPS_TL'
   AND owner = p_owner;
--
l_security_group_name  hr_all_organization_units.name%TYPE;
l_exists               VARCHAR2(1)  DEFAULT NULL;
l_sg_enabled           BOOLEAN      DEFAULT FALSE;
l_sg_name              VARCHAR2(80);
l_bg_name              VARCHAR2(80);
l_sec_length           NUMBER;
--
-- Variables for GET_APP_INFO
--
l_out_status           VARCHAR2(30);
l_out_industry         VARCHAR2(30);
l_owner                VARCHAR2(30);
l_value                BOOLEAN;
--
-- End of Variables for GET_APP_INFO
--

begin

  --
  -- Find the schema for FND
  --
  l_value := FND_INSTALLATION.GET_APP_INFO ('FND', l_out_status,
                                          l_out_industry, l_owner);

   --
   -- Create a security group for the new business group, and populate the
   -- org_information14 column with the id
   --

   IF hr_general.g_data_migrator_mode <> 'Y' THEN
      --
      -- If security groups are enabled then create one for the
      -- business group that is about to be inserted.
      --
      OPEN c_sg_enabled;
      --
      FETCH c_sg_enabled INTO l_exists;
      --
      IF c_sg_enabled%FOUND THEN
         l_sg_enabled := TRUE;
      ELSE
         l_sg_enabled := FALSE;
      END IF;
      --
      CLOSE c_sg_enabled;
      --
      IF l_sg_enabled THEN
         SELECT hou.name
           INTO l_security_group_name
           FROM hr_all_organization_units hou
          WHERE hou.organization_id = :new.organization_id;
         --
         -- Create the security group
         --
         -- If the setup business group is being created then do not
         -- create a security group - just use the standard SG
         --
         IF :new.organization_id = 0 THEN
           :new.org_information14 := 0;
         ELSE
           --
           OPEN c_sec_grp_name_length(l_owner);
           --
           FETCH c_sec_grp_name_length INTO l_sec_length;
           --
           CLOSE c_sec_grp_name_length;
           --
           IF l_sec_length = 80 THEN
              --
              -- If length of fnd_security_groups_tl.security_group_name = 80
              -- (therefore has not been expanded to 240) then truncate
              -- business group name to 80.
              --
              OPEN c_sec_grp_name_curs;
              --
              FETCH c_sec_grp_name_curs INTO l_sg_name;
              --
              IF substrb(l_security_group_name, 1, 80) = l_sg_name THEN
                 --
                 -- If first 80 chars of existing sg name match first 80 chars
                 -- of new sg name then raise error.
                 --
                 CLOSE c_sec_grp_name_curs;
                 --
                 hr_utility.set_message(800, 'PER_289704_80CHAR_MATCH_SG');
                 hr_utility.raise_error;
                 --
              ELSE
                 --
                 CLOSE c_sec_grp_name_curs;
                 --
                 l_bg_name := substrb(l_security_group_name, 1, 80);
                 --
                 :new.org_information14 :=
                 fnd_security_groups_api.Create_Group
                    (to_char(:new.organization_id) -- security group key
                    ,l_bg_name                     -- business group name
                    ,' '                           -- description
                    );
              END IF;
            END IF;
          END IF;
   ELSE
      -- if security groups are not enabled then default the
      -- org_information14 column to 0.
      :new.org_information14 := 0;
   END IF;
  END IF;
END hr_org_info_bri;



/
ALTER TRIGGER "APPS"."HR_ORG_INFO_BRI" ENABLE;
