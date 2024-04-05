--------------------------------------------------------
--  DDL for Trigger FEM_BUDGETS_ATTR_T_TI1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUDGETS_ATTR_T_TI1" 
before insert on "FEM"."FEM_BUDGETS_ATTR_T"
referencing new as FEM_BUDGETS_ATTR_T
for each row
declare
/* Listing local variables. */
l_cal_period_id FEM_BUDGETS_ATTR_T.attribute_assign_value%type;

l_cal_display_code FEM_BUDGETS_ATTR_T.calpattr_cal_display_code%type;
l_dimgrp_display_code FEM_BUDGETS_ATTR_T.calpattr_dimgrp_display_code%type;
l_end_date date;
l_period_num number;
/* Listing Exceptions used. */
e_duplicate_assign exception;
/* Done listing local variables for this trigger. */
begin

/* Check 1 : If the row is for BUDGET_FIRST_PERIOD or BUDGET_LAST_PERIOD, the populate the
             Cal Period attribute columns instead of data in the ATTRIBUTE_ASSIGN_VALUE column. */

IF :FEM_BUDGETS_ATTR_T.attribute_varchar_label = 'BUDGET_FIRST_PERIOD' OR :FEM_BUDGETS_ATTR_T.attribute_varchar_label = 'BUDGET_LAST_PERIOD' THEN
   IF :FEM_BUDGETS_ATTR_T.attribute_assign_value IS NOT NULL THEN /* If the value is null, it means that the data is already populated (or) is an error condition. */
      l_cal_period_id := :FEM_BUDGETS_ATTR_T.attribute_assign_value;

      /* Query for cal_display_code */
      select calendar_display_code into l_cal_display_code
      from fem_calendars_vl
      where calendar_id = (select calendar_id
                           from FEM_CAL_PERIODS_VL
                           where cal_period_id = l_cal_period_id);

      /* Query for dimgrp_display_code */
      select dimension_group_display_code into l_dimgrp_display_code
      from FEM_DIMENSION_GRPS_VL
      where dimension_group_id = (select dimension_group_id
                                  from FEM_CAL_PERIODS_VL
                                  where cal_period_id = l_cal_period_id);

      /* Query for end_date */
      select s1.date_assign_value into l_end_date
      from FEM_CAL_PERIODS_ATTR s1
      where s1.attribute_id = (select attribute_id
                               from FEM_DIM_ATTRIBUTES_VL
                               where dimension_id = (select dimension_id
                                                     from fem_dimensions_vl
                                                     where dimension_varchar_label = 'CAL_PERIOD') and
                                     attribute_varchar_label = 'CAL_PERIOD_END_DATE') and
            s1.cal_period_id = l_cal_period_id;

      /* Query for period_num */
      select s1.number_assign_value into l_period_num
      from FEM_CAL_PERIODS_ATTR s1
      where s1.attribute_id = (select attribute_id
                               from FEM_DIM_ATTRIBUTES_VL
                               where dimension_id = (select dimension_id
                                                     from fem_dimensions_vl
                                                     where dimension_varchar_label = 'CAL_PERIOD') and
                                     attribute_varchar_label = 'GL_PERIOD_NUM') and
            s1.cal_period_id = l_cal_period_id;

      /* Now that all Cal Period columns data is retrieved, update the table columns correspondingly. */
      :FEM_BUDGETS_ATTR_T.attribute_assign_value := null;
      :FEM_BUDGETS_ATTR_T.CALPATTR_CAL_DISPLAY_CODE := l_cal_display_code;
      :FEM_BUDGETS_ATTR_T.CALPATTR_DIMGRP_DISPLAY_CODE := l_dimgrp_display_code;
      :FEM_BUDGETS_ATTR_T.CALPATTR_END_DATE := l_end_date;
      :FEM_BUDGETS_ATTR_T.CALPATTR_PERIOD_NUM := l_period_num;
   END IF;
END IF;

/* Check 2 : Both ATTRIBUTE_ASSIGN_VALUE and Cal Period Attribute Columns should not be populated for the same row. */
IF :FEM_BUDGETS_ATTR_T.attribute_assign_value IS NOT NULL THEN
   IF :FEM_BUDGETS_ATTR_T.CALPATTR_CAL_DISPLAY_CODE IS NOT NULL
     OR :FEM_BUDGETS_ATTR_T.CALPATTR_DIMGRP_DISPLAY_CODE IS NOT NULL
     OR :FEM_BUDGETS_ATTR_T.CALPATTR_END_DATE IS NOT NULL
     OR :FEM_BUDGETS_ATTR_T.CALPATTR_PERIOD_NUM IS NOT NULL THEN
     RAISE e_duplicate_assign;
   END IF;
END IF;


exception
   when e_duplicate_assign then
      raise_application_error(-20100,'You may not populate the ATTRIBUTE_ASSIGN_VALUE column and the various CALPATTR columns for the same row');

end;

/
ALTER TRIGGER "APPS"."FEM_BUDGETS_ATTR_T_TI1" ENABLE;
