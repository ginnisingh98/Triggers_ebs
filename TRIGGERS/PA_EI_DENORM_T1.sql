--------------------------------------------------------
--  DDL for Trigger PA_EI_DENORM_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_EI_DENORM_T1" 
/* $Header: PAXTROT1.pls 115.3 99/07/16 15:35:26 porting ship  $ */
  BEFORE INSERT OR DELETE OR UPDATE
  ON "PA"."PA_EI_DENORM"
  FOR EACH ROW


DECLARE

	x_profile_audit_flag VARCHAR2(1);
	x_pte_reference NUMBER;
	x_exp_class_code VARCHAR2(2);
	x_exp_stat_code VARCHAR2(30);

	x_inc_by_person_id NUMBER;
	x_exp_id NUMBER;
	x_denorm_id NUMBER;
	x_proj_id NUMBER;
	x_task_id NUMBER;
	x_exp_type VARCHAR2(30);
	x_sys_link_func VARCHAR2(30);
	x_exp_item_date DATE;
	x_quantity NUMBER(22,5);
	x_attr_cat VARCHAR2(30);
	x_attr1 VARCHAR2(150);
        x_attr2 VARCHAR2(150);
        x_attr3 VARCHAR2(150);
        x_attr4 VARCHAR2(150);
        x_attr5 VARCHAR2(150);
        x_attr6 VARCHAR2(150);
        x_attr7 VARCHAR2(150);
        x_attr8 VARCHAR2(150);
	x_attr9 VARCHAR2(150);
	x_attr10 VARCHAR2(150);
	x_comment VARCHAR2(240);
	x_adj_exp_item_id NUMBER;
        x_created_by NUMBER(15);
        x_creation_date DATE;
        x_last_updated_by NUMBER(15);
        x_last_update_date DATE;
        x_last_update_login NUMBER(15);
	x_change_code VARCHAR2(30);

	PROCEDURE Insert_Audit_Rec IS

	BEGIN

          -- The check of expenditure_type is because the copy routine in PAXTRONE
          -- allows for not copying the expenditure_type and if so there can't be any
          -- eis being inserted into table pa_ei_denorm for the denorm record
          -- and there should be nothing to insert into the history table.
          --
          -- Also if there are no eis in the denorm table and project, task, or exp type
          -- are changed and saved then again no records should be inserted into the
          -- history table.
          --
          -- Note: Project and task are always required in the denorm table

          IF x_exp_type IS NOT NULL THEN

               x_created_by := TO_NUMBER(FND_PROFILE.VALUE('USER_ID'));
               x_last_updated_by := TO_NUMBER(FND_PROFILE.VALUE('USER_ID'));
               x_last_update_login := TO_NUMBER(FND_PROFILE.VALUE('LOGIN_ID'));
               x_creation_date := SYSDATE;
               x_last_update_date := SYSDATE;

     		INSERT INTO PA_EXPENDITURE_HISTORY
	         (INCURRED_BY_PERSON_ID,
     		  EXPENDITURE_ID,
	          DENORM_ID,
          	  PROJECT_ID,
     		  TASK_ID,
     		  EXPENDITURE_CLASS_CODE,
     		  EXPENDITURE_SOURCE_CODE,
     		  EXPENDITURE_TYPE,
     		  SYSTEM_LINKAGE_FUNCTION,
     		  EXPENDITURE_ITEM_DATE,
     		  QUANTITY,
     		  ATTRIBUTE_CATEGORY,
     		  ATTRIBUTE1,
     		  ATTRIBUTE2,
     		  ATTRIBUTE3,
     		  ATTRIBUTE4,
     		  ATTRIBUTE5,
     		  ATTRIBUTE6,
     		  ATTRIBUTE7,
     		  ATTRIBUTE8,
     		  ATTRIBUTE9,
     		  ATTRIBUTE10,
     		  EXPENDITURE_ITEM_COMMENT,
     		  ADJUSTED_EXPENDITURE_ITEM_ID,
     		  CHANGE_CODE,
     		  CREATION_DATE,
     		  CREATED_BY,
     		  LAST_UPDATE_DATE,
     		  LAST_UPDATED_BY,
     		  LAST_UPDATE_LOGIN)
     		VALUES (
             	  x_inc_by_person_id,
             	  x_exp_id,
             	  x_denorm_id,
             	  x_proj_id,
             	  x_task_id,
     		  x_exp_class_code,
     		  'OLE',
             	  x_exp_type,
             	  x_sys_link_func,
             	  x_exp_item_date,
             	  x_quantity,
             	  x_attr_cat,
             	  x_attr1,
             	  x_attr2,
             	  x_attr3,
             	  x_attr4,
             	  x_attr5,
             	  x_attr6,
             	  x_attr7,
     		  x_attr8,
     		  x_attr9,
     		  x_attr10,
             	  x_comment,
             	  x_adj_exp_item_id,
             	  x_change_code,
     		  x_creation_date,
     		  x_created_by,
     		  x_last_update_date,
     		  x_last_updated_by,
     		  x_last_update_login);

          END IF;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE;

	END Insert_Audit_Rec;

BEGIN
	x_profile_audit_flag := FND_PROFILE.VALUE('PA_ONLINE_EXP_AUDIT');
	IF NVL(x_profile_audit_flag,'N') = 'Y' THEN
		SELECT EXPENDITURE_CLASS_CODE,
		       PTE_REFERENCE,
		       INCURRED_BY_PERSON_ID,
		       EXPENDITURE_STATUS_CODE
		INTO   x_exp_class_code,
		       x_pte_reference,
                       x_inc_by_person_id,
		       x_exp_stat_code
		FROM pa_expenditures_all
		WHERE EXPENDITURE_ID = NVL(:OLD.expenditure_id,:NEW.expenditure_id);

		IF x_exp_class_code IN ('OT','OE') AND
                   x_exp_stat_code IN ('WORKING','REJECTED') AND
                   x_pte_reference IS NULL THEN

		   IF INSERTING THEN
				x_change_code := 'INSERTING';
                    		x_denorm_id := :NEW.DENORM_ID;
                    		x_exp_id := :NEW.EXPENDITURE_ID;
                    		x_proj_id := :NEW.PROJECT_ID;
                    		x_task_id := :NEW.TASK_ID;
                    		x_exp_type := :NEW.EXPENDITURE_TYPE;
			        x_created_by := :NEW.CREATED_BY;
			        x_creation_date := :NEW.CREATION_DATE;
			        x_last_updated_by := :NEW.LAST_UPDATED_BY;
			        x_last_update_date := :NEW.LAST_UPDATE_DATE;
			        x_last_update_login := :NEW.LAST_UPDATE_LOGIN;

 			IF :NEW.QUANTITY_1 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_1;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_1;
                                        x_quantity := :NEW.QUANTITY_1;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_1;
                                        x_attr1 := :NEW.ATTRIBUTE1_1;
                                        x_attr2 := :NEW.ATTRIBUTE1_2;
                                        x_attr3 := :NEW.ATTRIBUTE1_3;
                                        x_attr4 := :NEW.ATTRIBUTE1_4;
                                        x_attr5 := :NEW.ATTRIBUTE1_5;
                                        x_attr6 := :NEW.ATTRIBUTE1_6;
                                        x_attr7 := :NEW.ATTRIBUTE1_7;
                                        x_attr8 := :NEW.ATTRIBUTE1_8;
                                        x_attr9 := :NEW.ATTRIBUTE1_9;
                                        x_attr10 := :NEW.ATTRIBUTE1_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_1;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_1;
                                        Insert_Audit_Rec;

			END IF;

                    	IF :NEW.QUANTITY_2 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_2;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_2;
                                        x_quantity := :NEW.QUANTITY_2;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_2;
                                        x_attr1 := :NEW.ATTRIBUTE2_1;
                                        x_attr2 := :NEW.ATTRIBUTE2_2;
                                        x_attr3 := :NEW.ATTRIBUTE2_3;
                                        x_attr4 := :NEW.ATTRIBUTE2_4;
                                        x_attr5 := :NEW.ATTRIBUTE2_5;
                                        x_attr6 := :NEW.ATTRIBUTE2_6;
                                        x_attr7 := :NEW.ATTRIBUTE2_7;
                                        x_attr8 := :NEW.ATTRIBUTE2_8;
                                        x_attr9 := :NEW.ATTRIBUTE2_9;
                                        x_attr10 := :NEW.ATTRIBUTE2_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_2;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_2;
                                        Insert_Audit_Rec;

                    	END IF;

                    	IF :NEW.QUANTITY_3 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_3;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_3;
                                        x_quantity := :NEW.QUANTITY_3;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_3;
                                        x_attr1 := :NEW.ATTRIBUTE3_1;
                                        x_attr2 := :NEW.ATTRIBUTE3_2;
                                        x_attr3 := :NEW.ATTRIBUTE3_3;
                                        x_attr4 := :NEW.ATTRIBUTE3_4;
                                        x_attr5 := :NEW.ATTRIBUTE3_5;
                                        x_attr6 := :NEW.ATTRIBUTE3_6;
                                        x_attr7 := :NEW.ATTRIBUTE3_7;
                                        x_attr8 := :NEW.ATTRIBUTE3_8;
                                        x_attr9 := :NEW.ATTRIBUTE3_9;
                                        x_attr10 := :NEW.ATTRIBUTE3_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_3;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_3;
                                        Insert_Audit_Rec;

                    	END IF;

                    	IF :NEW.QUANTITY_4 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_4;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_4;
                                        x_quantity := :NEW.QUANTITY_4;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_4;
                                        x_attr1 := :NEW.ATTRIBUTE4_1;
                                        x_attr2 := :NEW.ATTRIBUTE4_2;
                                        x_attr3 := :NEW.ATTRIBUTE4_3;
                                        x_attr4 := :NEW.ATTRIBUTE4_4;
                                        x_attr5 := :NEW.ATTRIBUTE4_5;
                                        x_attr6 := :NEW.ATTRIBUTE4_6;
                                        x_attr7 := :NEW.ATTRIBUTE4_7;
                                        x_attr8 := :NEW.ATTRIBUTE4_8;
                                        x_attr9 := :NEW.ATTRIBUTE4_9;
                                        x_attr10 := :NEW.ATTRIBUTE4_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_4;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_4;
                                        Insert_Audit_Rec;

                    	END IF;

                    	IF :NEW.QUANTITY_5 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_5;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_5;
                                        x_quantity := :NEW.QUANTITY_5;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_5;
                                        x_attr1 := :NEW.ATTRIBUTE5_1;
                                        x_attr2 := :NEW.ATTRIBUTE5_2;
                                        x_attr3 := :NEW.ATTRIBUTE5_3;
                                        x_attr4 := :NEW.ATTRIBUTE5_4;
                                        x_attr5 := :NEW.ATTRIBUTE5_5;
                                        x_attr6 := :NEW.ATTRIBUTE5_6;
                                        x_attr7 := :NEW.ATTRIBUTE5_7;
                                        x_attr8 := :NEW.ATTRIBUTE5_8;
                                        x_attr9 := :NEW.ATTRIBUTE5_9;
                                        x_attr10 := :NEW.ATTRIBUTE5_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_5;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_5;
                                        Insert_Audit_Rec;

                     	END IF;

                     	IF :NEW.QUANTITY_6 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_6;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_6;
                                        x_quantity := :NEW.QUANTITY_6;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_6;
                                        x_attr1 := :NEW.ATTRIBUTE6_1;
                                        x_attr2 := :NEW.ATTRIBUTE6_2;
                                        x_attr3 := :NEW.ATTRIBUTE6_3;
                                        x_attr4 := :NEW.ATTRIBUTE6_4;
                                        x_attr5 := :NEW.ATTRIBUTE6_5;
                                        x_attr6 := :NEW.ATTRIBUTE6_6;
                                        x_attr7 := :NEW.ATTRIBUTE6_7;
                                        x_attr8 := :NEW.ATTRIBUTE6_8;
                                        x_attr9 := :NEW.ATTRIBUTE6_9;
                                        x_attr10 := :NEW.ATTRIBUTE6_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_6;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_6;
                                        Insert_Audit_Rec;

                      	END IF;

                      	IF :NEW.QUANTITY_7 IS NOT NULL THEN
                                        x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_7;
                                        x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_7;
                                        x_quantity := :NEW.QUANTITY_7;
                                        x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_7;
                                        x_attr1 := :NEW.ATTRIBUTE7_1;
                                        x_attr2 := :NEW.ATTRIBUTE7_2;
                                        x_attr3 := :NEW.ATTRIBUTE7_3;
                                        x_attr4 := :NEW.ATTRIBUTE7_4;
                                        x_attr5 := :NEW.ATTRIBUTE7_5;
                                        x_attr6 := :NEW.ATTRIBUTE7_6;
                                        x_attr7 := :NEW.ATTRIBUTE7_7;
                                        x_attr8 := :NEW.ATTRIBUTE7_8;
                                        x_attr9 := :NEW.ATTRIBUTE7_9;
                                        x_attr10 := :NEW.ATTRIBUTE7_10;
                                        x_comment := :NEW.EXPENDITURE_COMMENT_7;
                                        x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_7;
                                        Insert_Audit_Rec;
                    	END IF;

		ELSIF UPDATING THEN

                    		x_denorm_id := :NEW.DENORM_ID;
                    		x_exp_id := :NEW.EXPENDITURE_ID;
                    		x_proj_id := :NEW.PROJECT_ID;
                    		x_task_id := :NEW.TASK_ID;
                    		x_exp_type := :NEW.EXPENDITURE_TYPE;
			     	x_created_by := :NEW.CREATED_BY;
			     	x_creation_date := :NEW.CREATION_DATE;
			     	x_last_updated_by := :NEW.LAST_UPDATED_BY;
			     	x_last_update_date := :NEW.LAST_UPDATE_DATE;
			     	x_last_update_login := :NEW.LAST_UPDATE_LOGIN;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	    	    :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_ITEM_DATE_1,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_1,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_1,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_1,'-999999999') <> NVL(:NEW.ATTRIBUTE1_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_2,'-999999999') <> NVL(:NEW.ATTRIBUTE1_2,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_3,'-999999999') <> NVL(:NEW.ATTRIBUTE1_3,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_4,'-999999999') <> NVL(:NEW.ATTRIBUTE1_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_5,'-999999999') <> NVL(:NEW.ATTRIBUTE1_5,'-999999999') OR
                        	    NVL(:OLD.ATTRIBUTE1_6,'-999999999') <> NVL(:NEW.ATTRIBUTE1_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_7,'-999999999') <> NVL(:NEW.ATTRIBUTE1_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_8,'-999999999') <> NVL(:NEW.ATTRIBUTE1_8,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_9,'-999999999') <> NVL(:NEW.ATTRIBUTE1_9,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE1_10,'-999999999') <> NVL(:NEW.ATTRIBUTE1_10,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_COMMENT_1,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_1,'-999999999') OR
                                   (:OLD.QUANTITY_1 IS NULL AND :NEW.QUANTITY_1 IS NOT NULL) OR
                                   (:OLD.QUANTITY_1 IS NOT NULL AND :NEW.QUANTITY_1 IS NULL) OR
                                   (:OLD.QUANTITY_1 IS NOT NULL AND :NEW.QUANTITY_1 IS NOT NULL) THEN
					  x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_1;
					  x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_1;
					  x_quantity := :NEW.QUANTITY_1;
					  x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_1;
					  x_attr1 := :NEW.ATTRIBUTE1_1;
                           		  x_attr2 := :NEW.ATTRIBUTE1_2;
                           		  x_attr3 := :NEW.ATTRIBUTE1_3;
                           		  x_attr4 := :NEW.ATTRIBUTE1_4;
                           		  x_attr5 := :NEW.ATTRIBUTE1_5;
                           		  x_attr6 := :NEW.ATTRIBUTE1_6;
                           		  x_attr7 := :NEW.ATTRIBUTE1_7;
                           		  x_attr8 := :NEW.ATTRIBUTE1_8;
                           		  x_attr9 := :NEW.ATTRIBUTE1_9;
                           		  x_attr10 := :NEW.ATTRIBUTE1_10;
					  x_comment := :NEW.EXPENDITURE_COMMENT_1;
					  x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_1;
					  IF :OLD.QUANTITY_1 IS NOT NULL AND :NEW.QUANTITY_1 IS NULL THEN
					       	x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                   			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_1;
                                		 ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_1;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_1;
	         				x_quantity := :OLD.QUANTITY_1;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_1;
			       		  	x_attr1 := :OLD.ATTRIBUTE1_1;
                                		x_attr2 := :OLD.ATTRIBUTE1_2;
                                		x_attr3 := :OLD.ATTRIBUTE1_3;
                                		x_attr4 := :OLD.ATTRIBUTE1_4;
                                		x_attr5 := :OLD.ATTRIBUTE1_5;
                                		x_attr6 := :OLD.ATTRIBUTE1_6;
                                		x_attr7 := :OLD.ATTRIBUTE1_7;
                                		x_attr8 := :OLD.ATTRIBUTE1_8;
                                		x_attr9 := :OLD.ATTRIBUTE1_9;
                                		x_attr10 := :OLD.ATTRIBUTE1_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_1;
     					        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_1;
                                		Insert_Audit_Rec;
					  END IF;
					  IF :OLD.QUANTITY_1 IS NULL AND :NEW.QUANTITY_1 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					  END IF;
                           		  IF :OLD.QUANTITY_1 IS NOT NULL AND :NEW.QUANTITY_1 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_1 <> :NEW.QUANTITY_1 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		  END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	    	    :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_ITEM_DATE_2,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_2,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_2,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_2,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_1,'-999999999') <> NVL(:NEW.ATTRIBUTE2_1,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_2,'-999999999') <> NVL(:NEW.ATTRIBUTE2_2,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_3,'-999999999') <> NVL(:NEW.ATTRIBUTE2_3,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_4,'-999999999') <> NVL(:NEW.ATTRIBUTE2_4,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_5,'-999999999') <> NVL(:NEW.ATTRIBUTE2_5,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_6,'-999999999') <> NVL(:NEW.ATTRIBUTE2_6,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_7,'-999999999') <> NVL(:NEW.ATTRIBUTE2_7,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_8,'-999999999') <> NVL(:NEW.ATTRIBUTE2_8,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_9,'-999999999') <> NVL(:NEW.ATTRIBUTE2_9,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE2_10,'-999999999') <> NVL(:NEW.ATTRIBUTE2_10,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_COMMENT_2,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_2,'-999999999') OR
                        	    (:OLD.QUANTITY_2 IS NULL AND :NEW.QUANTITY_2 IS NOT NULL) OR
                        	    (:OLD.QUANTITY_2 IS NOT NULL AND :NEW.QUANTITY_2 IS NULL) OR
                        	    (:OLD.QUANTITY_2 IS NOT NULL AND :NEW.QUANTITY_2 IS NOT NULL) THEN
					  x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_2;
					  x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_2;
					  x_quantity := :NEW.QUANTITY_2;
					  x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_2;
					  x_attr1 := :NEW.ATTRIBUTE2_1;
                           		  x_attr2 := :NEW.ATTRIBUTE2_2;
                           		  x_attr3 := :NEW.ATTRIBUTE2_3;
                           		  x_attr4 := :NEW.ATTRIBUTE2_4;
                           		  x_attr5 := :NEW.ATTRIBUTE2_5;
                           		  x_attr6 := :NEW.ATTRIBUTE2_6;
                           		  x_attr7 := :NEW.ATTRIBUTE2_7;
                           		  x_attr8 := :NEW.ATTRIBUTE2_8;
                           		  x_attr9 := :NEW.ATTRIBUTE2_9;
                           		  x_attr10 := :NEW.ATTRIBUTE2_10;
					  x_comment := :NEW.EXPENDITURE_COMMENT_2;
					  x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_2;
					  IF :OLD.QUANTITY_2 IS NOT NULL AND :NEW.QUANTITY_2 IS NULL THEN
					       	x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                		   x_exp_type := :OLD.EXPENDITURE_TYPE;
						   x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_2;
                                		ELSE
                                		   x_exp_type := :NEW.EXPENDITURE_TYPE;
						   x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_2;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_2;
	         				x_quantity := :OLD.QUANTITY_2;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_2;
			       		        x_attr1 := :OLD.ATTRIBUTE2_1;
                                		x_attr2 := :OLD.ATTRIBUTE2_2;
                                		x_attr3 := :OLD.ATTRIBUTE2_3;
                                		x_attr4 := :OLD.ATTRIBUTE2_4;
                                		x_attr5 := :OLD.ATTRIBUTE2_5;
                                		x_attr6 := :OLD.ATTRIBUTE2_6;
                                		x_attr7 := :OLD.ATTRIBUTE2_7;
                                		x_attr8 := :OLD.ATTRIBUTE2_8;
                                		x_attr9 := :OLD.ATTRIBUTE2_9;
                                		x_attr10 := :OLD.ATTRIBUTE2_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_2;
     					        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_2;
                                		Insert_Audit_Rec;
					  END IF;
					  IF :OLD.QUANTITY_2 IS NULL AND :NEW.QUANTITY_2 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					  END IF;
                           		  IF :OLD.QUANTITY_2 IS NOT NULL AND :NEW.QUANTITY_2 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_2 <> :NEW.QUANTITY_2 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	            :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_ITEM_DATE_3,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_3,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	            NVL(:OLD.ATTRIBUTE_CATEGORY_3,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_3,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_1,'-999999999') <> NVL(:NEW.ATTRIBUTE3_1,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_2,'-999999999') <> NVL(:NEW.ATTRIBUTE3_2,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_3,'-999999999') <> NVL(:NEW.ATTRIBUTE3_3,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_4,'-999999999') <> NVL(:NEW.ATTRIBUTE3_4,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_5,'-999999999') <> NVL(:NEW.ATTRIBUTE3_5,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_6,'-999999999') <> NVL(:NEW.ATTRIBUTE3_6,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_7,'-999999999') <> NVL(:NEW.ATTRIBUTE3_7,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_8,'-999999999') <> NVL(:NEW.ATTRIBUTE3_8,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_9,'-999999999') <> NVL(:NEW.ATTRIBUTE3_9,'-999999999') OR
                  	            NVL(:OLD.ATTRIBUTE3_10,'-999999999') <> NVL(:NEW.ATTRIBUTE3_10,'-999999999') OR
                  	            NVL(:OLD.EXPENDITURE_COMMENT_3,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_3,'-999999999') OR
                                    (:OLD.QUANTITY_3 IS NULL AND :NEW.QUANTITY_3 IS NOT NULL) OR
                                    (:OLD.QUANTITY_3 IS NOT NULL AND :NEW.QUANTITY_3 IS NULL) OR
                                    (:OLD.QUANTITY_3 IS NOT NULL AND :NEW.QUANTITY_3 IS NOT NULL) THEN
					  x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_3;
					  x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_3;
					  x_quantity := :NEW.QUANTITY_3;
					  x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_3;
					  x_attr1 := :NEW.ATTRIBUTE3_1;
                           		  x_attr2 := :NEW.ATTRIBUTE3_2;
                           		  x_attr3 := :NEW.ATTRIBUTE3_3;
                           		  x_attr4 := :NEW.ATTRIBUTE3_4;
                           		  x_attr5 := :NEW.ATTRIBUTE3_5;
                           		  x_attr6 := :NEW.ATTRIBUTE3_6;
                           		  x_attr7 := :NEW.ATTRIBUTE3_7;
                           		  x_attr8 := :NEW.ATTRIBUTE3_8;
                           		  x_attr9 := :NEW.ATTRIBUTE3_9;
                           		  x_attr10 := :NEW.ATTRIBUTE3_10;
					  x_comment := :NEW.EXPENDITURE_COMMENT_3;
					  x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_3;
					  IF :OLD.QUANTITY_3 IS NOT NULL AND :NEW.QUANTITY_3 IS NULL THEN
					       	x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_3;
                                		ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_3;
                                		END IF;
     					        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_3;
	         				x_quantity := :OLD.QUANTITY_3;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_3;
			       		        x_attr1 := :OLD.ATTRIBUTE3_1;
                                		x_attr2 := :OLD.ATTRIBUTE3_2;
                                		x_attr3 := :OLD.ATTRIBUTE3_3;
                                		x_attr4 := :OLD.ATTRIBUTE3_4;
                                		x_attr5 := :OLD.ATTRIBUTE3_5;
                                		x_attr6 := :OLD.ATTRIBUTE3_6;
                                		x_attr7 := :OLD.ATTRIBUTE3_7;
                                		x_attr8 := :OLD.ATTRIBUTE3_8;
                                		x_attr9 := :OLD.ATTRIBUTE3_9;
                                		x_attr10 := :OLD.ATTRIBUTE3_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_3;
     					        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_3;
                                		Insert_Audit_Rec;
					  END IF;
					  IF :OLD.QUANTITY_3 IS NULL AND :NEW.QUANTITY_3 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					  END IF;
                           		  IF :OLD.QUANTITY_3 IS NOT NULL AND :NEW.QUANTITY_3 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_3 <> :NEW.QUANTITY_3 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		  END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	            :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_ITEM_DATE_4,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_4,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_4,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_1,'-999999999') <> NVL(:NEW.ATTRIBUTE4_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_2,'-999999999') <> NVL(:NEW.ATTRIBUTE4_2,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_3,'-999999999') <> NVL(:NEW.ATTRIBUTE4_3,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_4,'-999999999') <> NVL(:NEW.ATTRIBUTE4_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_5,'-999999999') <> NVL(:NEW.ATTRIBUTE4_5,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_6,'-999999999') <> NVL(:NEW.ATTRIBUTE4_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_7,'-999999999') <> NVL(:NEW.ATTRIBUTE4_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_8,'-999999999') <> NVL(:NEW.ATTRIBUTE4_8,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_9,'-999999999') <> NVL(:NEW.ATTRIBUTE4_9,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE4_10,'-999999999') <> NVL(:NEW.ATTRIBUTE4_10,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_COMMENT_4,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_4,'-999999999') OR
                        	    (:OLD.QUANTITY_4 IS NULL AND :NEW.QUANTITY_4 IS NOT NULL) OR
                        	    (:OLD.QUANTITY_4 IS NOT NULL AND :NEW.QUANTITY_4 IS NULL) OR
                        	    (:OLD.QUANTITY_4 IS NOT NULL AND :NEW.QUANTITY_4 IS NOT NULL) THEN
					x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_4;
					x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_4;
					x_quantity := :NEW.QUANTITY_4;
					x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_4;
					x_attr1 := :NEW.ATTRIBUTE4_1;
                           		x_attr2 := :NEW.ATTRIBUTE4_2;
                           		x_attr3 := :NEW.ATTRIBUTE4_3;
                           		x_attr4 := :NEW.ATTRIBUTE4_4;
                           		x_attr5 := :NEW.ATTRIBUTE4_5;
                           		x_attr6 := :NEW.ATTRIBUTE4_6;
                           		x_attr7 := :NEW.ATTRIBUTE4_7;
                           		x_attr8 := :NEW.ATTRIBUTE4_8;
                           		x_attr9 := :NEW.ATTRIBUTE4_9;
                           		x_attr10 := :NEW.ATTRIBUTE4_10;
					x_comment := :NEW.EXPENDITURE_COMMENT_4;
					x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_4;
					IF :OLD.QUANTITY_4 IS NOT NULL AND :NEW.QUANTITY_4 IS NULL THEN
						x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                   			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_4;
                                		ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_4;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_4;
	         				x_quantity := :OLD.QUANTITY_4;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_4;
			       		        x_attr1 := :OLD.ATTRIBUTE4_1;
                                		x_attr2 := :OLD.ATTRIBUTE4_2;
                                		x_attr3 := :OLD.ATTRIBUTE4_3;
                                		x_attr4 := :OLD.ATTRIBUTE4_4;
                                		x_attr5 := :OLD.ATTRIBUTE4_5;
                                		x_attr6 := :OLD.ATTRIBUTE4_6;
                                		x_attr7 := :OLD.ATTRIBUTE4_7;
                                		x_attr8 := :OLD.ATTRIBUTE4_8;
                                		x_attr9 := :OLD.ATTRIBUTE4_9;
                                		x_attr10 := :OLD.ATTRIBUTE4_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_4;
     					  	x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_4;
                                		Insert_Audit_Rec;
					  END IF;
					  IF :OLD.QUANTITY_4 IS NULL AND :NEW.QUANTITY_4 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					  END IF;
                           		  IF :OLD.QUANTITY_4 IS NOT NULL AND :NEW.QUANTITY_4 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_4 <> :NEW.QUANTITY_4 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		  END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	            :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_ITEM_DATE_5,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_5,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_5,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_5,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_1,'-999999999') <> NVL(:NEW.ATTRIBUTE5_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_2,'-999999999') <> NVL(:NEW.ATTRIBUTE5_2,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_3,'-999999999') <> NVL(:NEW.ATTRIBUTE5_3,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_4,'-999999999') <> NVL(:NEW.ATTRIBUTE5_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_5,'-999999999') <> NVL(:NEW.ATTRIBUTE5_5,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_6,'-999999999') <> NVL(:NEW.ATTRIBUTE5_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_7,'-999999999') <> NVL(:NEW.ATTRIBUTE5_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_8,'-999999999') <> NVL(:NEW.ATTRIBUTE5_8,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_9,'-999999999') <> NVL(:NEW.ATTRIBUTE5_9,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE5_10,'-999999999') <> NVL(:NEW.ATTRIBUTE5_10,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_COMMENT_5,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_5,'-999999999') OR
                        	    (:OLD.QUANTITY_5 IS NULL AND :NEW.QUANTITY_5 IS NOT NULL) OR
                        	    (:OLD.QUANTITY_5 IS NOT NULL AND :NEW.QUANTITY_5 IS NULL) OR
                        	    (:OLD.QUANTITY_5 IS NOT NULL AND :NEW.QUANTITY_5 IS NOT NULL) THEN
					x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_5;
					x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_5;
					x_quantity := :NEW.QUANTITY_5;
					x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_5;
					x_attr1 := :NEW.ATTRIBUTE5_1;
                           		x_attr2 := :NEW.ATTRIBUTE5_2;
                           		x_attr3 := :NEW.ATTRIBUTE5_3;
                           		x_attr4 := :NEW.ATTRIBUTE5_4;
                           		x_attr5 := :NEW.ATTRIBUTE5_5;
                           		x_attr6 := :NEW.ATTRIBUTE5_6;
                           		x_attr7 := :NEW.ATTRIBUTE5_7;
                           		x_attr8 := :NEW.ATTRIBUTE5_8;
                           		x_attr9 := :NEW.ATTRIBUTE5_9;
                           		x_attr10 := :NEW.ATTRIBUTE5_10;
					x_comment := :NEW.EXPENDITURE_COMMENT_5;
					x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_5;
					IF :OLD.QUANTITY_5 IS NOT NULL AND :NEW.QUANTITY_5 IS NULL THEN
						x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                   			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_5;
                                		ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_5;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_5;
	         				x_quantity := :OLD.QUANTITY_5;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_5;
			       		  	x_attr1 := :OLD.ATTRIBUTE5_1;
                                		x_attr2 := :OLD.ATTRIBUTE5_2;
                                		x_attr3 := :OLD.ATTRIBUTE5_3;
                                		x_attr4 := :OLD.ATTRIBUTE5_4;
                                		x_attr5 := :OLD.ATTRIBUTE5_5;
                                		x_attr6 := :OLD.ATTRIBUTE5_6;
                                		x_attr7 := :OLD.ATTRIBUTE5_7;
                                		x_attr8 := :OLD.ATTRIBUTE5_8;
                                		x_attr9 := :OLD.ATTRIBUTE5_9;
                                		x_attr10 := :OLD.ATTRIBUTE5_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_5;
     					        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_5;
                                		Insert_Audit_Rec;
					END IF;
					IF :OLD.QUANTITY_5 IS NULL AND :NEW.QUANTITY_5 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					END IF;
                           		IF :OLD.QUANTITY_5 IS NOT NULL AND :NEW.QUANTITY_5 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_5 <> :NEW.QUANTITY_5 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	    	    :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_ITEM_DATE_6,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_6,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_6,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_1,'-999999999') <> NVL(:NEW.ATTRIBUTE6_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_2,'-999999999') <> NVL(:NEW.ATTRIBUTE6_2,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_3,'-999999999') <> NVL(:NEW.ATTRIBUTE6_3,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_4,'-999999999') <> NVL(:NEW.ATTRIBUTE6_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_5,'-999999999') <> NVL(:NEW.ATTRIBUTE6_5,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_6,'-999999999') <> NVL(:NEW.ATTRIBUTE6_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_7,'-999999999') <> NVL(:NEW.ATTRIBUTE6_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_8,'-999999999') <> NVL(:NEW.ATTRIBUTE6_8,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_9,'-999999999') <> NVL(:NEW.ATTRIBUTE6_9,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE6_10,'-999999999') <> NVL(:NEW.ATTRIBUTE6_10,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_COMMENT_6,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_6,'-999999999') OR
                        	    (:OLD.QUANTITY_6 IS NULL AND :NEW.QUANTITY_6 IS NOT NULL) OR
                        	    (:OLD.QUANTITY_6 IS NOT NULL AND :NEW.QUANTITY_6 IS NULL) OR
                        	    (:OLD.QUANTITY_6 IS NOT NULL AND :NEW.QUANTITY_6 IS NOT NULL) THEN
					x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_6;
					x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_6;
					x_quantity := :NEW.QUANTITY_6;
					x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_6;
					x_attr1 := :NEW.ATTRIBUTE6_1;
                           		x_attr2 := :NEW.ATTRIBUTE6_2;
                           		x_attr3 := :NEW.ATTRIBUTE6_3;
                           		x_attr4 := :NEW.ATTRIBUTE6_4;
                           		x_attr5 := :NEW.ATTRIBUTE6_5;
                           		x_attr6 := :NEW.ATTRIBUTE6_6;
                           		x_attr7 := :NEW.ATTRIBUTE6_7;
                           		x_attr8 := :NEW.ATTRIBUTE6_8;
                           		x_attr9 := :NEW.ATTRIBUTE6_9;
                           		x_attr10 := :NEW.ATTRIBUTE6_10;
					x_comment := :NEW.EXPENDITURE_COMMENT_6;
					x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_6;
					IF :OLD.QUANTITY_6 IS NOT NULL AND :NEW.QUANTITY_6 IS NULL THEN
						x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                   			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_6;
                                		ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_6;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_6;
	         				x_quantity := :OLD.QUANTITY_6;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_6;
			       		  	x_attr1 := :OLD.ATTRIBUTE6_1;
                                		x_attr2 := :OLD.ATTRIBUTE6_2;
                                		x_attr3 := :OLD.ATTRIBUTE6_3;
                                		x_attr4 := :OLD.ATTRIBUTE6_4;
                                		x_attr5 := :OLD.ATTRIBUTE6_5;
                                		x_attr6 := :OLD.ATTRIBUTE6_6;
                                		x_attr7 := :OLD.ATTRIBUTE6_7;
                                		x_attr8 := :OLD.ATTRIBUTE6_8;
                                		x_attr9 := :OLD.ATTRIBUTE6_9;
                                		x_attr10 := :OLD.ATTRIBUTE6_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_6;
     					        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_6;
                                		Insert_Audit_Rec;
			  		END IF;
					IF :OLD.QUANTITY_6 IS NULL AND :NEW.QUANTITY_6 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
					END IF;
                           		IF :OLD.QUANTITY_6 IS NOT NULL AND :NEW.QUANTITY_6 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_6 <> :NEW.QUANTITY_6 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		END IF;
				END IF;

				IF  :OLD.PROJECT_ID <> :NEW.PROJECT_ID OR
                  	            :OLD.TASK_ID <> :NEW.TASK_ID OR
				    NVL(:OLD.EXPENDITURE_TYPE,'-999999999') <> NVL(:NEW.EXPENDITURE_TYPE,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_ITEM_DATE_7,TO_DATE('01-01-51','DD-MM-RR')) <> NVL(:NEW.EXPENDITURE_ITEM_DATE_7,TO_DATE('01-01-51','DD-MM-RR')) OR
                  	    	    NVL(:OLD.ATTRIBUTE_CATEGORY_7,'-999999999') <> NVL(:NEW.ATTRIBUTE_CATEGORY_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_1,'-999999999') <> NVL(:NEW.ATTRIBUTE7_1,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_2,'-999999999') <> NVL(:NEW.ATTRIBUTE7_2,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_3,'-999999999') <> NVL(:NEW.ATTRIBUTE7_3,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_4,'-999999999') <> NVL(:NEW.ATTRIBUTE7_4,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_5,'-999999999') <> NVL(:NEW.ATTRIBUTE7_5,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_6,'-999999999') <> NVL(:NEW.ATTRIBUTE7_6,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_7,'-999999999') <> NVL(:NEW.ATTRIBUTE7_7,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_8,'-999999999') <> NVL(:NEW.ATTRIBUTE7_8,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_9,'-999999999') <> NVL(:NEW.ATTRIBUTE7_9,'-999999999') OR
                  	    	    NVL(:OLD.ATTRIBUTE7_10,'-999999999') <> NVL(:NEW.ATTRIBUTE7_10,'-999999999') OR
                  	    	    NVL(:OLD.EXPENDITURE_COMMENT_7,'-999999999') <> NVL(:NEW.EXPENDITURE_COMMENT_7,'-999999999') OR
                        	    (:OLD.QUANTITY_7 IS NULL AND :NEW.QUANTITY_7 IS NOT NULL) OR
                        	    (:OLD.QUANTITY_7 IS NOT NULL AND :NEW.QUANTITY_7 IS NULL) OR
                        	    (:OLD.QUANTITY_7 IS NOT NULL AND :NEW.QUANTITY_7 IS NOT NULL) THEN
			  		x_exp_item_date := :NEW.EXPENDITURE_ITEM_DATE_7;
					x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_7;
					x_quantity := :NEW.QUANTITY_7;
					x_attr_cat := :NEW.ATTRIBUTE_CATEGORY_7;
					x_attr1 := :NEW.ATTRIBUTE7_1;
                           		x_attr2 := :NEW.ATTRIBUTE7_2;
                           		x_attr3 := :NEW.ATTRIBUTE7_3;
                           		x_attr4 := :NEW.ATTRIBUTE7_4;
                           		x_attr5 := :NEW.ATTRIBUTE7_5;
                           		x_attr6 := :NEW.ATTRIBUTE7_6;
                           		x_attr7 := :NEW.ATTRIBUTE7_7;
                           		x_attr8 := :NEW.ATTRIBUTE7_8;
                           		x_attr9 := :NEW.ATTRIBUTE7_9;
                           		x_attr10 := :NEW.ATTRIBUTE7_10;
					x_comment := :NEW.EXPENDITURE_COMMENT_7;
					x_adj_exp_item_id := :NEW.ADJUSTED_EXPENDITURE_ITEM_ID_7;
					IF :OLD.QUANTITY_7 IS NOT NULL AND :NEW.QUANTITY_7 IS NULL THEN
						x_change_code := 'DELETING';
                                		x_proj_id := :OLD.PROJECT_ID;
                                		x_task_id := :OLD.TASK_ID;
                                		IF :OLD.EXPENDITURE_TYPE IS NOT NULL THEN
                                   			x_exp_type := :OLD.EXPENDITURE_TYPE;
							x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_7;
                                		ELSE
                                   			x_exp_type := :NEW.EXPENDITURE_TYPE;
							x_sys_link_func := :NEW.SYSTEM_LINKAGE_FUNCTION_7;
                                		END IF;
     					  	x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_7;
	         				x_quantity := :OLD.QUANTITY_7;
		        			x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_7;
			       		  	x_attr1 := :OLD.ATTRIBUTE7_1;
                                		x_attr2 := :OLD.ATTRIBUTE7_2;
                                		x_attr3 := :OLD.ATTRIBUTE7_3;
                                		x_attr4 := :OLD.ATTRIBUTE7_4;
                                		x_attr5 := :OLD.ATTRIBUTE7_5;
                                		x_attr6 := :OLD.ATTRIBUTE7_6;
                                		x_attr7 := :OLD.ATTRIBUTE7_7;
                                		x_attr8 := :OLD.ATTRIBUTE7_8;
                                		x_attr9 := :OLD.ATTRIBUTE7_9;
                                		x_attr10 := :OLD.ATTRIBUTE7_10;
	         				x_comment := :OLD.EXPENDITURE_COMMENT_7;
     					  	x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_7;
                                		Insert_Audit_Rec;
				 	END IF;
					IF :OLD.QUANTITY_7 IS NULL AND :NEW.QUANTITY_7 IS NOT NULL THEN
                                		x_change_code := 'INSERTING';
                                		Insert_Audit_Rec;
				  	END IF;
                           		IF :OLD.QUANTITY_7 IS NOT NULL AND :NEW.QUANTITY_7 IS NOT NULL THEN
                                		IF :OLD.QUANTITY_7 <> :NEW.QUANTITY_7 THEN
                                     			x_change_code := 'UPDATING';
                                     			Insert_Audit_Rec;
                                		END IF;
                           		END IF;
				END IF;

			ELSIF DELETING THEN
				x_change_code := 'DELETING';
                    		x_denorm_id := :OLD.DENORM_ID;
                    		x_exp_id := :OLD.EXPENDITURE_ID;
                    		x_proj_id := :OLD.PROJECT_ID;
                    		x_task_id := :OLD.TASK_ID;
                    		x_exp_type := :OLD.EXPENDITURE_TYPE;
			        x_created_by := :OLD.CREATED_BY;
			        x_creation_date := :OLD.CREATION_DATE;
			        x_last_updated_by := :OLD.LAST_UPDATED_BY;
			        x_last_update_date := :OLD.LAST_UPDATE_DATE;
			        x_last_update_login := :OLD.LAST_UPDATE_LOGIN;

				IF :OLD.QUANTITY_1 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_1;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_1;
                                        x_quantity := :OLD.QUANTITY_1;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_1;
                                        x_attr1 := :OLD.ATTRIBUTE1_1;
                                        x_attr2 := :OLD.ATTRIBUTE1_2;
                                        x_attr3 := :OLD.ATTRIBUTE1_3;
                                        x_attr4 := :OLD.ATTRIBUTE1_4;
                                        x_attr5 := :OLD.ATTRIBUTE1_5;
                                        x_attr6 := :OLD.ATTRIBUTE1_6;
                                        x_attr7 := :OLD.ATTRIBUTE1_7;
                                        x_attr8 := :OLD.ATTRIBUTE1_8;
                                        x_attr9 := :OLD.ATTRIBUTE1_9;
                                        x_attr10 := :OLD.ATTRIBUTE1_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_1;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_1;
                                        Insert_Audit_Rec;

				END IF;

                                IF :OLD.QUANTITY_2 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_2;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_2;
                                        x_quantity := :OLD.QUANTITY_2;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_2;
                                        x_attr1 := :OLD.ATTRIBUTE2_1;
                                        x_attr2 := :OLD.ATTRIBUTE2_2;
                                        x_attr3 := :OLD.ATTRIBUTE2_3;
                                        x_attr4 := :OLD.ATTRIBUTE2_4;
                                        x_attr5 := :OLD.ATTRIBUTE2_5;
                                        x_attr6 := :OLD.ATTRIBUTE2_6;
                                        x_attr7 := :OLD.ATTRIBUTE2_7;
                                        x_attr8 := :OLD.ATTRIBUTE2_8;
                                        x_attr9 := :OLD.ATTRIBUTE2_9;
                                        x_attr10 := :OLD.ATTRIBUTE2_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_2;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_2;
                                        Insert_Audit_Rec;

                                END IF;

                                IF :OLD.QUANTITY_3 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_3;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_3;
                                        x_quantity := :OLD.QUANTITY_3;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_3;
                                        x_attr1 := :OLD.ATTRIBUTE3_1;
                                        x_attr2 := :OLD.ATTRIBUTE3_2;
                                        x_attr3 := :OLD.ATTRIBUTE3_3;
                                        x_attr4 := :OLD.ATTRIBUTE3_4;
                                        x_attr5 := :OLD.ATTRIBUTE3_5;
                                        x_attr6 := :OLD.ATTRIBUTE3_6;
                                        x_attr7 := :OLD.ATTRIBUTE3_7;
                                        x_attr8 := :OLD.ATTRIBUTE3_8;
                                        x_attr9 := :OLD.ATTRIBUTE3_9;
                                        x_attr10 := :OLD.ATTRIBUTE3_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_3;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_3;
                                        Insert_Audit_Rec;

                                END IF;

                                IF :OLD.QUANTITY_4 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_4;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_4;
                                        x_quantity := :OLD.QUANTITY_4;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_4;
                                        x_attr1 := :OLD.ATTRIBUTE4_1;
                                        x_attr2 := :OLD.ATTRIBUTE4_2;
                                        x_attr3 := :OLD.ATTRIBUTE4_3;
                                        x_attr4 := :OLD.ATTRIBUTE4_4;
                                        x_attr5 := :OLD.ATTRIBUTE4_5;
                                        x_attr6 := :OLD.ATTRIBUTE4_6;
                                        x_attr7 := :OLD.ATTRIBUTE4_7;
                                        x_attr8 := :OLD.ATTRIBUTE4_8;
                                        x_attr9 := :OLD.ATTRIBUTE4_9;
                                        x_attr10 := :OLD.ATTRIBUTE4_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_4;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_4;
                                        Insert_Audit_Rec;

                                END IF;

                                IF :OLD.QUANTITY_5 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_5;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_5;
                                        x_quantity := :OLD.QUANTITY_5;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_5;
                                        x_attr1 := :OLD.ATTRIBUTE5_1;
                                        x_attr2 := :OLD.ATTRIBUTE5_2;
                                        x_attr3 := :OLD.ATTRIBUTE5_3;
                                        x_attr4 := :OLD.ATTRIBUTE5_4;
                                        x_attr5 := :OLD.ATTRIBUTE5_5;
                                        x_attr6 := :OLD.ATTRIBUTE5_6;
                                        x_attr7 := :OLD.ATTRIBUTE5_7;
                                        x_attr8 := :OLD.ATTRIBUTE5_8;
                                        x_attr9 := :OLD.ATTRIBUTE5_9;
                                        x_attr10 := :OLD.ATTRIBUTE5_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_5;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_5;
                                        Insert_Audit_Rec;

                                END IF;

                                IF :OLD.QUANTITY_6 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_6;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_6;
                                        x_quantity := :OLD.QUANTITY_6;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_6;
                                        x_attr1 := :OLD.ATTRIBUTE6_1;
                                        x_attr2 := :OLD.ATTRIBUTE6_2;
                                        x_attr3 := :OLD.ATTRIBUTE6_3;
                                        x_attr4 := :OLD.ATTRIBUTE6_4;
                                        x_attr5 := :OLD.ATTRIBUTE6_5;
                                        x_attr6 := :OLD.ATTRIBUTE6_6;
                                        x_attr7 := :OLD.ATTRIBUTE6_7;
                                        x_attr8 := :OLD.ATTRIBUTE6_8;
                                        x_attr9 := :OLD.ATTRIBUTE6_9;
                                        x_attr10 := :OLD.ATTRIBUTE6_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_6;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_6;
                                        Insert_Audit_Rec;

                                END IF;

                                IF :OLD.QUANTITY_7 IS NOT NULL THEN
                                        x_exp_item_date := :OLD.EXPENDITURE_ITEM_DATE_7;
                                        x_sys_link_func := :OLD.SYSTEM_LINKAGE_FUNCTION_7;
                                        x_quantity := :OLD.QUANTITY_7;
                                        x_attr_cat := :OLD.ATTRIBUTE_CATEGORY_7;
                                        x_attr1 := :OLD.ATTRIBUTE7_1;
                                        x_attr2 := :OLD.ATTRIBUTE7_2;
                                        x_attr3 := :OLD.ATTRIBUTE7_3;
                                        x_attr4 := :OLD.ATTRIBUTE7_4;
                                        x_attr5 := :OLD.ATTRIBUTE7_5;
                                        x_attr6 := :OLD.ATTRIBUTE7_6;
                                        x_attr7 := :OLD.ATTRIBUTE7_7;
                                        x_attr8 := :OLD.ATTRIBUTE7_8;
                                        x_attr9 := :OLD.ATTRIBUTE7_9;
                                        x_attr10 := :OLD.ATTRIBUTE7_10;
                                        x_comment := :OLD.EXPENDITURE_COMMENT_7;
                                        x_adj_exp_item_id := :OLD.ADJUSTED_EXPENDITURE_ITEM_ID_7;
                                        Insert_Audit_Rec;

                                END IF;
			END IF;
		END IF;
	END IF;

EXCEPTION
	WHEN OTHERS THEN
		RAISE;

END;



/
ALTER TRIGGER "APPS"."PA_EI_DENORM_T1" ENABLE;
