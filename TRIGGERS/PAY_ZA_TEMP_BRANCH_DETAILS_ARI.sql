--------------------------------------------------------
--  DDL for Trigger PAY_ZA_TEMP_BRANCH_DETAILS_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ARI" 
after insert on           "HR"."PAY_ZA_TEMP_BRANCH_DETAILS"
for each row
begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      insert into pay_za_branch_cdv_details (
        BRANCH_CODE
      , SSV_ALLOWED
      , ONE_DAY_SS
      , TWO_DAY_SS
      , FIVE_DAY_SS
      , STREAM_CODE
      , BANK_NAME
      , BRANCH_NAME
      , STREET_ADDRESS_LINE_1
      , STREET_ADDRESS_LINE_2
      , PO_BOX_NUMBER
      , PO_BOX_POST_OFFICE
      , POSTAL_CODE
      , TELEPHONE_NUMBER
      , DIALING_CODE
      , TELEX1
      , TELEX2
      , DELETION_DATE
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.ssv_allowed,
         :new.one_day_ss,
         :new.two_day_ss,
         :new.five_day_ss,
         :new.stream_code,
         null,
         :new.branch_name,
         :new.street_address_line_1,
         :new.street_address_line_2,
         :new.po_box_number,
         :new.po_box_post_office,
         :new.postal_code,
         :new.telephone_number,
         :new.dialing_code,
         :new.telex1,
         :new.telex2,
         :new.deletion_date,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_1,
         :new.modulus_1,
         :new.fudge_factor_1,
         substr(:new.cdv_weightings_1,  1, 2),
         substr(:new.cdv_weightings_1,  3, 2),
         substr(:new.cdv_weightings_1,  5, 2),
         substr(:new.cdv_weightings_1,  7, 2),
         substr(:new.cdv_weightings_1,  9, 2),
         substr(:new.cdv_weightings_1, 11, 2),
         substr(:new.cdv_weightings_1, 13, 2),
         substr(:new.cdv_weightings_1, 15, 2),
         substr(:new.cdv_weightings_1, 17, 2),
         substr(:new.cdv_weightings_1, 19, 2),
         substr(:new.cdv_weightings_1, 21, 2),
         :new.exception_code_1,
         :new.account_ind_1,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_2,
         :new.modulus_2,
         :new.fudge_factor_2,
         substr(:new.cdv_weightings_2,  1, 2),
         substr(:new.cdv_weightings_2,  3, 2),
         substr(:new.cdv_weightings_2,  5, 2),
         substr(:new.cdv_weightings_2,  7, 2),
         substr(:new.cdv_weightings_2,  9, 2),
         substr(:new.cdv_weightings_2, 11, 2),
         substr(:new.cdv_weightings_2, 13, 2),
         substr(:new.cdv_weightings_2, 15, 2),
         substr(:new.cdv_weightings_2, 17, 2),
         substr(:new.cdv_weightings_2, 19, 2),
         substr(:new.cdv_weightings_2, 21, 2),
         :new.exception_code_2,
         :new.account_ind_2,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_3,
         :new.modulus_3,
         :new.fudge_factor_3,
         substr(:new.cdv_weightings_3,  1, 2),
         substr(:new.cdv_weightings_3,  3, 2),
         substr(:new.cdv_weightings_3,  5, 2),
         substr(:new.cdv_weightings_3,  7, 2),
         substr(:new.cdv_weightings_3,  9, 2),
         substr(:new.cdv_weightings_3, 11, 2),
         substr(:new.cdv_weightings_3, 13, 2),
         substr(:new.cdv_weightings_3, 15, 2),
         substr(:new.cdv_weightings_3, 17, 2),
         substr(:new.cdv_weightings_3, 19, 2),
         substr(:new.cdv_weightings_3, 21, 2),
         :new.exception_code_3,
         :new.account_ind_3,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_4,
         :new.modulus_4,
         :new.fudge_factor_4,
         substr(:new.cdv_weightings_4,  1, 2),
         substr(:new.cdv_weightings_4,  3, 2),
         substr(:new.cdv_weightings_4,  5, 2),
         substr(:new.cdv_weightings_4,  7, 2),
         substr(:new.cdv_weightings_4,  9, 2),
         substr(:new.cdv_weightings_4, 11, 2),
         substr(:new.cdv_weightings_4, 13, 2),
         substr(:new.cdv_weightings_4, 15, 2),
         substr(:new.cdv_weightings_4, 17, 2),
         substr(:new.cdv_weightings_4, 19, 2),
         substr(:new.cdv_weightings_4, 21, 2),
         :new.exception_code_4,
         :new.account_ind_4,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_5,
         :new.modulus_5,
         :new.fudge_factor_5,
         substr(:new.cdv_weightings_5,  1, 2),
         substr(:new.cdv_weightings_5,  3, 2),
         substr(:new.cdv_weightings_5,  5, 2),
         substr(:new.cdv_weightings_5,  7, 2),
         substr(:new.cdv_weightings_5,  9, 2),
         substr(:new.cdv_weightings_5, 11, 2),
         substr(:new.cdv_weightings_5, 13, 2),
         substr(:new.cdv_weightings_5, 15, 2),
         substr(:new.cdv_weightings_5, 17, 2),
         substr(:new.cdv_weightings_5, 19, 2),
         substr(:new.cdv_weightings_5, 21, 2),
         :new.exception_code_5,
         :new.account_ind_5,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_6,
         :new.modulus_6,
         :new.fudge_factor_6,
         substr(:new.cdv_weightings_6,  1, 2),
         substr(:new.cdv_weightings_6,  3, 2),
         substr(:new.cdv_weightings_6,  5, 2),
         substr(:new.cdv_weightings_6,  7, 2),
         substr(:new.cdv_weightings_6,  9, 2),
         substr(:new.cdv_weightings_6, 11, 2),
         substr(:new.cdv_weightings_6, 13, 2),
         substr(:new.cdv_weightings_6, 15, 2),
         substr(:new.cdv_weightings_6, 17, 2),
         substr(:new.cdv_weightings_6, 19, 2),
         substr(:new.cdv_weightings_6, 21, 2),
         :new.exception_code_6,
         :new.account_ind_6,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_7,
         :new.modulus_7,
         :new.fudge_factor_7,
         substr(:new.cdv_weightings_7,  1, 2),
         substr(:new.cdv_weightings_7,  3, 2),
         substr(:new.cdv_weightings_7,  5, 2),
         substr(:new.cdv_weightings_7,  7, 2),
         substr(:new.cdv_weightings_7,  9, 2),
         substr(:new.cdv_weightings_7, 11, 2),
         substr(:new.cdv_weightings_7, 13, 2),
         substr(:new.cdv_weightings_7, 15, 2),
         substr(:new.cdv_weightings_7, 17, 2),
         substr(:new.cdv_weightings_7, 19, 2),
         substr(:new.cdv_weightings_7, 21, 2),
         :new.exception_code_7,
         :new.account_ind_7,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_8,
         :new.modulus_8,
         :new.fudge_factor_8,
         substr(:new.cdv_weightings_8,  1, 2),
         substr(:new.cdv_weightings_8,  3, 2),
         substr(:new.cdv_weightings_8,  5, 2),
         substr(:new.cdv_weightings_8,  7, 2),
         substr(:new.cdv_weightings_8,  9, 2),
         substr(:new.cdv_weightings_8, 11, 2),
         substr(:new.cdv_weightings_8, 13, 2),
         substr(:new.cdv_weightings_8, 15, 2),
         substr(:new.cdv_weightings_8, 17, 2),
         substr(:new.cdv_weightings_8, 19, 2),
         substr(:new.cdv_weightings_8, 21, 2),
         :new.exception_code_8,
         :new.account_ind_8,
         null,
         null,
         null,
         null,
         null
      );

      insert into pay_za_cdv_parameters (
        BRANCH_CODE
      , ACCOUNT_TYPE
      , MODULUS
      , FUDGE_FACTOR
      , CDV_WEIGHTING1
      , CDV_WEIGHTING2
      , CDV_WEIGHTING3
      , CDV_WEIGHTING4
      , CDV_WEIGHTING5
      , CDV_WEIGHTING6
      , CDV_WEIGHTING7
      , CDV_WEIGHTING8
      , CDV_WEIGHTING9
      , CDV_WEIGHTING10
      , CDV_WEIGHTING11
      , EXCEPTION_CODE
      , ACCOUNT_INDICATOR
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      , LAST_UPDATE_LOGIN
      , CREATED_BY
      , CREATION_DATE
      )
      values
      (
         lpad(:new.branch_code, 6, 0),
         :new.account_type_9,
         :new.modulus_9,
         :new.fudge_factor_9,
         substr(:new.cdv_weightings_9,  1, 2),
         substr(:new.cdv_weightings_9,  3, 2),
         substr(:new.cdv_weightings_9,  5, 2),
         substr(:new.cdv_weightings_9,  7, 2),
         substr(:new.cdv_weightings_9,  9, 2),
         substr(:new.cdv_weightings_9, 11, 2),
         substr(:new.cdv_weightings_9, 13, 2),
         substr(:new.cdv_weightings_9, 15, 2),
         substr(:new.cdv_weightings_9, 17, 2),
         substr(:new.cdv_weightings_9, 19, 2),
         substr(:new.cdv_weightings_9, 21, 2),
         :new.exception_code_9,
         :new.account_ind_9,
         null,
         null,
         null,
         null,
         null
      );

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ARI" ENABLE;
