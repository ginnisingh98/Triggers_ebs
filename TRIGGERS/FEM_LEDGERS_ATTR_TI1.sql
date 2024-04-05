--------------------------------------------------------
--  DDL for Trigger FEM_LEDGERS_ATTR_TI1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI1" 
after insert on "FEM"."FEM_LEDGERS_ATTR"
referencing new as FEM_LEDGERS_ATTR
for each row
declare

v_global_vs_attr_id fem_dim_attributes_b.attribute_id%type;

v_global_vs_combo_id fem_ledger_dim_vs_maps.GLOBAL_VS_COMBO_ID%type;

v_channel_vs_id fem_ledger_dim_vs_maps.CHANNEL_VS_ID%type;
v_cctr_org_vs_id fem_ledger_dim_vs_maps.COMPANY_COST_CENTER_ORG_VS_ID%type;
v_company_vs_id fem_ledger_dim_vs_maps.COMPANY_VS_ID%type;
v_cost_ctr_vs_id fem_ledger_dim_vs_maps.COST_CENTER_VS_ID%type;
v_customer_vs_id fem_ledger_dim_vs_maps.CUSTOMER_VS_ID%type;
v_entity_vs_id fem_ledger_dim_vs_maps.ENTITY_VS_ID%type;
v_fin_elem_vs_id fem_ledger_dim_vs_maps.FINANCIAL_ELEM_VS_ID%type;
v_geography_vs_id fem_ledger_dim_vs_maps.GEOGRAPHY_VS_ID%type;
v_line_item_vs_id fem_ledger_dim_vs_maps.LINE_ITEM_VS_ID%type;
v_natural_account_vs_id fem_ledger_dim_vs_maps.NATURAL_ACCOUNT_VS_ID%type;
v_product_vs_id fem_ledger_dim_vs_maps.PRODUCT_VS_ID%type;
v_project_vs_id fem_ledger_dim_vs_maps.PROJECT_VS_ID%type;
v_task_vs_id fem_ledger_dim_vs_maps.TASK_VS_ID%type;
v_user_dim1_vs_id fem_ledger_dim_vs_maps.USER_DIM1_VS_ID%type;
v_user_dim2_vs_id fem_ledger_dim_vs_maps.USER_DIM2_VS_ID%type;
v_user_dim3_vs_id fem_ledger_dim_vs_maps.USER_DIM3_VS_ID%type;
v_user_dim4_vs_id fem_ledger_dim_vs_maps.USER_DIM4_VS_ID%type;
v_user_dim5_vs_id fem_ledger_dim_vs_maps.USER_DIM5_VS_ID%type;
v_user_dim6_vs_id fem_ledger_dim_vs_maps.USER_DIM6_VS_ID%type;
v_user_dim7_vs_id fem_ledger_dim_vs_maps.USER_DIM7_VS_ID%type;
v_user_dim8_vs_id fem_ledger_dim_vs_maps.USER_DIM8_VS_ID%type;
v_user_dim9_vs_id fem_ledger_dim_vs_maps.USER_DIM9_VS_ID%type;
v_user_dim10_vs_id fem_ledger_dim_vs_maps.USER_DIM10_VS_ID%type;

cursor c1 (p_global_vs_combo_id IN NUMBER) is
   SELECT D.dimension_varchar_label, G.value_set_id
   FROM fem_dimensions_b D, fem_global_vs_combo_defs G
   WHERE G.dimension_id = D.dimension_id
   AND G.global_vs_combo_id = p_global_vs_combo_id;


 ---
begin

-- Get the attribute_ids
SELECT A.attribute_id
INTO v_global_vs_attr_id
FROM fem_dim_attributes_b A, fem_dimensions_b D
WHERE D.dimension_varchar_label='LEDGER'
AND D.dimension_id = A.dimension_id
AND A.attribute_varchar_label='GLOBAL_VS_COMBO';



-- process the Global combo attribute
IF :FEM_LEDGERS_ATTR.attribute_id = v_global_vs_attr_id THEN

   v_global_vs_combo_id := :FEM_LEDGERS_ATTR.dim_attribute_numeric_member;

   FOR dim IN c1 (v_global_vs_combo_id) LOOP
      CASE dim.dimension_varchar_label
         WHEN 'CHANNEL' THEN v_channel_vs_id := dim.value_set_id;
         WHEN 'COMPANY_COST_CENTER_ORG' THEN v_cctr_org_vs_id := dim.value_set_id;
         WHEN 'COMPANY' THEN v_company_vs_id := dim.value_set_id;
         WHEN 'COST_CENTER' THEN v_cost_ctr_vs_id := dim.value_set_id;
         WHEN 'CUSTOMER' THEN v_customer_vs_id := dim.value_set_id;
         WHEN 'ENTITY' THEN v_entity_vs_id := dim.value_set_id;
         WHEN 'FINANCIAL_ELEMENT' THEN v_fin_elem_vs_id := dim.value_set_id;
         WHEN 'GEOGRAPHY' THEN v_geography_vs_id := dim.value_set_id;
         WHEN 'LINE_ITEM' THEN v_line_item_vs_id := dim.value_set_id;
         WHEN 'NATURAL_ACCOUNT' THEN v_natural_account_vs_id := dim.value_set_id;
         WHEN 'PRODUCT' THEN v_product_vs_id := dim.value_set_id;
         WHEN 'PROJECT' THEN v_project_vs_id := dim.value_set_id;
         WHEN 'TASK' THEN v_task_vs_id := dim.value_set_id;
         WHEN 'USER_DIM1' THEN v_user_dim1_vs_id := dim.value_set_id;
         WHEN 'USER_DIM10' THEN v_user_dim10_vs_id := dim.value_set_id;
         WHEN 'USER_DIM2' THEN v_user_dim2_vs_id := dim.value_set_id;
         WHEN 'USER_DIM3' THEN v_user_dim3_vs_id := dim.value_set_id;
         WHEN 'USER_DIM4' THEN v_user_dim4_vs_id := dim.value_set_id;
         WHEN 'USER_DIM5' THEN v_user_dim5_vs_id := dim.value_set_id;
         WHEN 'USER_DIM6' THEN v_user_dim6_vs_id := dim.value_set_id;
         WHEN 'USER_DIM7' THEN v_user_dim7_vs_id := dim.value_set_id;
         WHEN 'USER_DIM8' THEN v_user_dim8_vs_id := dim.value_set_id;
         WHEN 'USER_DIM9' THEN v_user_dim9_vs_id := dim.value_set_id;
      END CASE;

   END LOOP;


      MERGE INTO fem_ledger_dim_vs_maps L
      USING (SELECT
        :FEM_LEDGERS_ATTR.ledger_id as ledger_id
	             ,v_global_vs_combo_id as global_vs_combo
	             ,v_channel_vs_id as channel
	             ,v_cctr_org_vs_id as cctr
	             ,v_company_vs_id as company
	             ,v_cost_ctr_vs_id as cost_ctr
	             ,v_customer_vs_id as customer
	             ,v_entity_vs_id as entity
	             ,v_fin_elem_vs_id as fin_elem
	             ,v_geography_vs_id as geography
	             ,v_line_item_vs_id as line_item
	             ,v_natural_account_vs_id as natural_acct
	             ,v_product_vs_id as product
	             ,v_project_vs_id as project
	             ,v_task_vs_id as task
	             ,v_user_dim1_vs_id as user_dim1
	             ,v_user_dim2_vs_id as user_dim2
	             ,v_user_dim3_vs_id as user_dim3
	             ,v_user_dim4_vs_id as user_dim4
	             ,v_user_dim5_vs_id as user_dim5
	             ,v_user_dim6_vs_id as user_dim6
	             ,v_user_dim7_vs_id as user_dim7
	             ,v_user_dim8_vs_id as user_dim8
	             ,v_user_dim9_vs_id as user_dim9
	             ,v_user_dim10_vs_id as user_dim10
        FROM dual) A
       ON (A.ledger_id = L.ledger_id)
       WHEN MATCHED THEN UPDATE SET
               L.GLOBAL_VS_COMBO_ID = v_global_vs_combo_id,
               L.CHANNEL_VS_ID = v_channel_vs_id,
               L.COMPANY_COST_CENTER_ORG_VS_ID = v_cctr_org_vs_id,
	           L.COMPANY_VS_ID = v_company_vs_id,
	           L.COST_CENTER_VS_ID = v_cost_ctr_vs_id,
	           L.CUSTOMER_VS_ID = v_customer_vs_id,
	           L.ENTITY_VS_ID = v_entity_vs_id,
	           L.FINANCIAL_ELEM_VS_ID = v_fin_elem_vs_id,
	           L.GEOGRAPHY_VS_ID = v_geography_vs_id,
	           L.LINE_ITEM_VS_ID = v_line_item_vs_id,
	           L.NATURAL_ACCOUNT_VS_ID = v_natural_account_vs_id,
	           L.PRODUCT_VS_ID  = v_product_vs_id,
	           L.PROJECT_VS_ID  = v_project_vs_id,
	           L.TASK_VS_ID  = v_task_vs_id,
	           L.USER_DIM1_VS_ID = v_user_dim1_vs_id,
	           L.USER_DIM2_VS_ID = v_user_dim2_vs_id,
	           L.USER_DIM3_VS_ID = v_user_dim3_vs_id,
	           L.USER_DIM4_VS_ID = v_user_dim4_vs_id,
	           L.USER_DIM5_VS_ID = v_user_dim5_vs_id,
	           L.USER_DIM6_VS_ID = v_user_dim6_vs_id,
	           L.USER_DIM7_VS_ID = v_user_dim7_vs_id,
	           L.USER_DIM8_VS_ID = v_user_dim8_vs_id,
	           L.USER_DIM9_VS_ID = v_user_dim9_vs_id,
	           L.USER_DIM10_VS_ID= v_user_dim10_vs_id
      WHEN NOT MATCHED THEN INSERT (
      L.LEDGER_ID,
      L.GLOBAL_VS_COMBO_ID,
      L.CHANNEL_VS_ID,
      L.COMPANY_COST_CENTER_ORG_VS_ID,
      L.COMPANY_VS_ID,
      L.COST_CENTER_VS_ID,
      L.CUSTOMER_VS_ID,
      L.ENTITY_VS_ID,
      L.FINANCIAL_ELEM_VS_ID,
      L.GEOGRAPHY_VS_ID,
      L.LINE_ITEM_VS_ID,
      L.NATURAL_ACCOUNT_VS_ID,
      L.PRODUCT_VS_ID,
      L.PROJECT_VS_ID,
      L.TASK_VS_ID,
      L.USER_DIM1_VS_ID,
      L.USER_DIM2_VS_ID,
      L.USER_DIM3_VS_ID,
      L.USER_DIM4_VS_ID,
      L.USER_DIM5_VS_ID,
      L.USER_DIM6_VS_ID,
      L.USER_DIM7_VS_ID,
      L.USER_DIM8_VS_ID,
      L.USER_DIM9_VS_ID,
      L.USER_DIM10_VS_ID
      )
      VALUES    (:FEM_LEDGERS_ATTR.ledger_id
                 ,v_global_vs_combo_id
                 ,v_channel_vs_id
                 ,v_cctr_org_vs_id
                 ,v_company_vs_id
                 ,v_cost_ctr_vs_id
                 ,v_customer_vs_id
                 ,v_entity_vs_id
                 ,v_fin_elem_vs_id
                 ,v_geography_vs_id
                 ,v_line_item_vs_id
                 ,v_natural_account_vs_id
                 ,v_product_vs_id
                 ,v_project_vs_id
                 ,v_task_vs_id
                 ,v_user_dim1_vs_id
                 ,v_user_dim2_vs_id
                 ,v_user_dim3_vs_id
                 ,v_user_dim4_vs_id
                 ,v_user_dim5_vs_id
                 ,v_user_dim6_vs_id
                 ,v_user_dim7_vs_id
                 ,v_user_dim8_vs_id
                 ,v_user_dim9_vs_id
                 ,v_user_dim10_vs_id
 );




END IF;


end;

/
ALTER TRIGGER "APPS"."FEM_LEDGERS_ATTR_TI1" ENABLE;
