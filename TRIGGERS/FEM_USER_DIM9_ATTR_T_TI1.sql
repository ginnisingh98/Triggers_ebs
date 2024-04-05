--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM9_ATTR_T_TI1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM9_ATTR_T_TI1" 
before insert on "FEM"."FEM_USER_DIM9_ATTR_T"
referencing new as FEM_USER_DIM9_ATTR_T
for each row
declare
e_duplicate_assign exception;
 ---
begin

IF :FEM_USER_DIM9_ATTR_T.attribute_assign_value IS NOT NULL THEN
   IF :FEM_USER_DIM9_ATTR_T.CALPATTR_CAL_DISPLAY_CODE IS NOT NULL
     OR :FEM_USER_DIM9_ATTR_T.CALPATTR_DIMGRP_DISPLAY_CODE IS NOT NULL
     OR :FEM_USER_DIM9_ATTR_T.CALPATTR_END_DATE IS NOT NULL
     OR :FEM_USER_DIM9_ATTR_T.CALPATTR_PERIOD_NUM IS NOT NULL THEN
     RAISE e_duplicate_assign;
   END IF;
END IF;


exception
   when e_duplicate_assign then
      raise_application_error(-20100,'You may not populate the ATTRIBUTE_ASSIGN_VALUE column and the various CALPATTR columns for the same row');

end;

/
ALTER TRIGGER "APPS"."FEM_USER_DIM9_ATTR_T_TI1" ENABLE;
