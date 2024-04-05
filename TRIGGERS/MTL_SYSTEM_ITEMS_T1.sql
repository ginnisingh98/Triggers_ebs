--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T1" 
BEFORE UPDATE OF COSTING_ENABLED_FLAG
       ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW
DECLARE
   l_cost_type_id number;
   l_cost_org_id number;
   l_shrinkage_rate number;
   l_def_matl_cost_code_id number;
   l_return_code number;
   l_return_err  varchar2(80);
   l_sql_stmt_num number;
   l_avg_costing_option  varchar2(10);
BEGIN
   l_sql_stmt_num := 10;

   SELECT primary_cost_method
         ,cost_organization_id
         ,default_material_cost_id
   INTO   l_cost_type_id
         ,l_cost_org_id
         ,l_def_matl_cost_code_id
   FROM   mtl_parameters
   WHERE  organization_id = :new.organization_id;

   SELECT DECODE(DECODE(:new.planning_make_buy_code,
                        1,:new.planning_make_buy_code,
                        2,:new.planning_make_buy_code,
                        2),1,nvl(:new.shrinkage_rate,0),0)
   INTO l_shrinkage_rate
   FROM dual;

   IF (:new.organization_id = l_cost_org_id) THEN
      IF (:new.costing_enabled_flag = 'Y'  AND  :old.costing_enabled_flag = 'N') THEN
         l_sql_stmt_num := 20;
		   INSERT INTO cst_item_costs
		      (inventory_item_id,
		       organization_id,
                       cost_type_id,
                       last_update_date,
                       last_updated_by,
                       creation_date,
                       created_by,
                       defaulted_flag,
                       shrinkage_rate,
                       lot_size,
                       based_on_rollup_flag,
                       inventory_asset_flag,
		       item_cost)
		   VALUES
                          (:new.inventory_item_id,
			   :new.organization_id,
			   l_cost_type_id,
			   sysdate,
			   :new.last_updated_by,
			   sysdate,
			   :new.created_by,
			   2,
         	           l_shrinkage_rate,
			   NVL(:new.std_lot_size,1),
			   DECODE(:new.planning_make_buy_code,
                                  1,:new.planning_make_buy_code,
                                  2,:new.planning_make_buy_code,
                                  2),
			   DECODE(:new.inventory_asset_flag,
				  'Y', 1,
				   2),
			   0);
      END IF;

      IF (:new.costing_enabled_flag = 'N' AND :old.costing_enabled_flag = 'Y') THEN
	      :new.inventory_asset_flag := 'N';
         l_sql_stmt_num := 40;

         IF l_cost_type_id = 2 THEN
            FND_PROFILE.GET('CST_AVG_COSTING_OPTION', l_avg_costing_option);
            IF l_avg_costing_option = '2' THEN
               DELETE cst_layer_cost_details
               WHERE layer_id IN
                          (SELECT layer_id
                           FROM cst_quantity_layers
                           WHERE inventory_item_id = :new.inventory_item_id
                           AND   organization_id   = :new.organization_id);

               l_sql_stmt_num := 50;

               DELETE cst_quantity_layers
               WHERE inventory_item_id = :new.inventory_item_id
               AND   organization_id = :new.organization_id;

            END IF;

         END IF;

         DELETE cst_item_cost_details
         WHERE inventory_item_id = :new.inventory_item_id
         AND   organization_id = :new.organization_id
	      AND cost_type_id IN (SELECT cost_type_id FROM cst_cost_types);

         l_sql_stmt_num := 60;

         DELETE cst_item_costs
	      WHERE inventory_item_id = :new.inventory_item_id
	      AND   organization_id = :new.organization_id;

      END IF;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      l_return_err := 'MTL_SYSTEM_ITEMS_T1:' || 'S'|| l_sql_stmt_num || ':' ||substrb(sqlerrm,1,55);
      raise_application_error(-20000,l_return_err);
END;


/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T1" ENABLE;
