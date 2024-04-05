--------------------------------------------------------
--  DDL for Trigger MTL_DEMAND_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_DEMAND_T" 
/* $Header: invdmdt.sql 120.1 2005/06/21 06:36:57 appldev ship $ */
AFTER INSERT OR UPDATE OR DELETE ON "INV"."MTL_DEMAND"
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
   WHEN ((new.reservation_type in (2,3)) or (old.reservation_type in (2,3))) DECLARE
   l_reservation_id 			number;
   l_primary_uom_code 			varchar2(3);
   l_non_prim_completed_quantity 	number;
   l_return_err				varchar2(80);
   l_sql_stmt_num 			number := 0;

BEGIN
   l_sql_stmt_num := 1;

   if ((INSERTING) and (inv_rsv_trigger_global.g_from_trigger = FALSE)) then
   	l_sql_stmt_num := 2;

	/*
	** Get sequence value
        */
	select mtl_reservations_s.nextval
        into l_reservation_id
        from dual;

   	l_sql_stmt_num := 3;

	/*
	** Primary UOM code is not stored in MTL_DEMAND
        ** but it is in MTL_RESERVATIONS. Hence..
	*/
	select primary_uom_code
	into l_primary_uom_code
	from mtl_system_items
	where organization_id   = :new.organization_id
	and   inventory_item_id = :new.inventory_item_id;

   	l_sql_stmt_num := 4;

	/*
	** Convert completed quantity into reservation uom
	*/
	l_non_prim_completed_quantity :=
                inv_convert.inv_um_convert(
                  :new.inventory_item_id
                , 5                     -- Precision
                , :new.completed_quantity
                , l_primary_uom_code    -- From UOM
                , :new.uom_code  	-- To   UOM
                , null                  -- From UOM Name
                , null);                -- To   UOM Name

   	l_sql_stmt_num := 5;

   	inv_rsv_trigger_global.g_from_trigger := TRUE;

	insert into mtl_reservations(
 	 RESERVATION_ID
 	,REQUIREMENT_DATE
 	,ORGANIZATION_ID
 	,INVENTORY_ITEM_ID
 	,DEMAND_SOURCE_TYPE_ID
 	,DEMAND_SOURCE_NAME
 	,DEMAND_SOURCE_HEADER_ID
 	,DEMAND_SOURCE_LINE_ID
 	,DEMAND_SOURCE_DELIVERY
 	,PRIMARY_UOM_CODE
 	,PRIMARY_UOM_ID
 	,RESERVATION_UOM_CODE
 	,RESERVATION_UOM_ID
 	,RESERVATION_QUANTITY
 	,PRIMARY_RESERVATION_QUANTITY
 	,AUTODETAIL_GROUP_ID
 	,EXTERNAL_SOURCE_CODE
 	,EXTERNAL_SOURCE_LINE_ID
 	,SUPPLY_SOURCE_TYPE_ID
 	,SUPPLY_SOURCE_HEADER_ID
 	,SUPPLY_SOURCE_LINE_ID
 	,SUPPLY_SOURCE_LINE_DETAIL
 	,SUPPLY_SOURCE_NAME
 	,REVISION
 	,SUBINVENTORY_CODE
 	,SUBINVENTORY_ID
 	,LOCATOR_ID
 	,LOT_NUMBER
 	,LOT_NUMBER_ID
 	,SERIAL_NUMBER
 	,SERIAL_NUMBER_ID
 	,PARTIAL_QUANTITIES_ALLOWED
 	,AUTO_DETAILED
 	,PICK_SLIP_NUMBER
 	,LPN_ID
 	,LAST_UPDATE_DATE
 	,LAST_UPDATED_BY
 	,CREATION_DATE
 	,CREATED_BY
 	,LAST_UPDATE_LOGIN
 	,REQUEST_ID
 	,PROGRAM_APPLICATION_ID
 	,PROGRAM_ID
 	,PROGRAM_UPDATE_DATE
 	,ATTRIBUTE_CATEGORY
 	,ATTRIBUTE1
 	,ATTRIBUTE2
 	,ATTRIBUTE3
 	,ATTRIBUTE4
 	,ATTRIBUTE5
 	,ATTRIBUTE6
 	,ATTRIBUTE7
 	,ATTRIBUTE8
 	,ATTRIBUTE9
 	,ATTRIBUTE10
 	,ATTRIBUTE11
 	,ATTRIBUTE12
 	,ATTRIBUTE13
 	,ATTRIBUTE14
 	,ATTRIBUTE15
 	,SHIP_READY_FLAG
 	,N_COLUMN1)
        values(
 	 l_reservation_id
 	,:new.REQUIREMENT_DATE
 	,:new.ORGANIZATION_ID
 	,:new.INVENTORY_ITEM_ID
 	,:new.DEMAND_SOURCE_TYPE
 	,:new.DEMAND_SOURCE_NAME
 	,:new.DEMAND_SOURCE_HEADER_ID
 	,:new.DEMAND_SOURCE_LINE
 	,:new.DEMAND_SOURCE_DELIVERY
 	,l_primary_uom_code
 	,NULL 				/* PRIMARY_UOM_ID 		*/
 	,:new.UOM_CODE
 	,NULL				/* RESERVATION_UOM_ID 		*/
 	,:new.LINE_ITEM_QUANTITY - nvl(l_non_prim_completed_quantity,0)
   	,:new.PRIMARY_UOM_QUANTITY - nvl(:new.COMPLETED_QUANTITY,0)
 	,NULL				/* AUTODETAIL_GROUP_ID 		*/
 	,NULL				/* EXTERNAL_SOURCE_CODE 	*/
 	,NULL				/* EXTERNAL_SOURCE_LINE_ID	*/
 	,decode(:new.RESERVATION_TYPE,3,:new.SUPPLY_SOURCE_TYPE,13)
 	,:new.SUPPLY_SOURCE_HEADER_ID
 	,NULL				/* SUPPLY_SOURCE_LINE_ID	*/
 	,NULL				/* SUPPLY_SOURCE_LINE_DETAIL	*/
 	,NULL                           /* SUPPLY_SOURCE_NAME           */
 	,:new.REVISION
 	,:new.SUBINVENTORY
 	,NULL				/* SUBINVENTORY_ID 		*/
 	,:new.LOCATOR_ID
 	,:new.LOT_NUMBER
 	,NULL				/* LOT_NUMBER_ID 		*/
 	,NULL				/* SERIAL_NUMBER		*/
 	,NULL				/* SERIAL_NUMBER_ID 		*/
 	,NULL				/* PARTIAL_QUANTITIES_ALLOWED 	*/
 	,NULL				/* AUTO_DETAILED 		*/
 	,NULL				/* PICK_SLIP_NUMBER 		*/
 	,NULL				/* LPN_ID 			*/
 	,:new.LAST_UPDATE_DATE
 	,:new.LAST_UPDATED_BY
 	,:new.CREATION_DATE
 	,:new.CREATED_BY
 	,:new.LAST_UPDATE_LOGIN
 	,:new.REQUEST_ID
 	,:new.PROGRAM_APPLICATION_ID
 	,:new.PROGRAM_ID
 	,:new.PROGRAM_UPDATE_DATE
 	,:new.ATTRIBUTE_CATEGORY
 	,:new.ATTRIBUTE1
 	,:new.ATTRIBUTE2
 	,:new.ATTRIBUTE3
 	,:new.ATTRIBUTE4
 	,:new.ATTRIBUTE5
 	,:new.ATTRIBUTE6
 	,:new.ATTRIBUTE7
 	,:new.ATTRIBUTE8
 	,:new.ATTRIBUTE9
 	,:new.ATTRIBUTE10
 	,:new.ATTRIBUTE11
 	,:new.ATTRIBUTE12
 	,:new.ATTRIBUTE13
 	,:new.ATTRIBUTE14
 	,:new.ATTRIBUTE15
 	,NULL				/* SHIP_READY_FLAG 		*/
        ,:new.demand_id);

   	l_sql_stmt_num := 6;

   	inv_rsv_trigger_global.g_from_trigger := FALSE;
   end if;

   if ((UPDATING) and (inv_rsv_trigger_global.g_from_trigger = FALSE)) then
   	l_sql_stmt_num := 7;

	/*
	** Primary UOM code is not stored in MTL_DEMAND
        ** but it is in MTL_RESERVATIONS. Hence..
	*/
	select primary_uom_code
	into l_primary_uom_code
	from mtl_system_items
	where organization_id   = :new.organization_id
	and   inventory_item_id = :new.inventory_item_id;

   	l_sql_stmt_num := 8;

	/*
	** Convert completed quantity into reservation uom
	*/
	l_non_prim_completed_quantity :=
                inv_convert.inv_um_convert(
                  :new.inventory_item_id
                , 5                     -- Precision
                , :new.completed_quantity
                , l_primary_uom_code    -- From UOM
                , :new.uom_code  	-- To   UOM
                , null                  -- From UOM Name
                , null);                -- To   UOM Name

   	l_sql_stmt_num := 9;

   	inv_rsv_trigger_global.g_from_trigger := TRUE;

        update mtl_reservations
        set
 	 REQUIREMENT_DATE 	      = :new.requirement_date
 	,ORGANIZATION_ID 	      = :new.organization_id
 	,INVENTORY_ITEM_ID 	      = :new.inventory_item_id
 	,DEMAND_SOURCE_TYPE_ID        = :new.demand_source_type
 	,DEMAND_SOURCE_NAME           = :new.demand_source_name
 	,DEMAND_SOURCE_HEADER_ID      = :new.demand_source_header_id
 	,DEMAND_SOURCE_LINE_ID        = :new.demand_source_line
 	,DEMAND_SOURCE_DELIVERY       = :new.demand_source_delivery
 	,PRIMARY_UOM_CODE	      = l_primary_uom_code
 	,PRIMARY_UOM_ID               = NULL
 	,RESERVATION_UOM_CODE         = :new.uom_code
 	,RESERVATION_UOM_ID           = NULL
 	,RESERVATION_QUANTITY         = :new.LINE_ITEM_QUANTITY -
                                         nvl(l_non_prim_completed_quantity,0)
 	,PRIMARY_RESERVATION_QUANTITY = :new.PRIMARY_UOM_QUANTITY -
                                         nvl(:new.COMPLETED_QUANTITY,0)
 	,AUTODETAIL_GROUP_ID          = NULL
 	,EXTERNAL_SOURCE_CODE         = NULL
 	,EXTERNAL_SOURCE_LINE_ID      = NULL
 	,SUPPLY_SOURCE_TYPE_ID        = decode(:new.RESERVATION_TYPE,3,
                                               :new.SUPPLY_SOURCE_TYPE,13)
 	,SUPPLY_SOURCE_HEADER_ID      = :new.supply_source_header_id
 	,SUPPLY_SOURCE_LINE_ID        = NULL
 	,SUPPLY_SOURCE_LINE_DETAIL    = NULL
        /*
 	,SUPPLY_SOURCE_NAME           = NULL
        */
 	,REVISION                     = :new.revision
 	,SUBINVENTORY_CODE            = :new.subinventory
 	,SUBINVENTORY_ID              = NULL
 	,LOCATOR_ID                   = :new.locator_id
 	,LOT_NUMBER                   = :new.lot_number
 	,LOT_NUMBER_ID                = NULL
 	,SERIAL_NUMBER                = NULL
 	,SERIAL_NUMBER_ID             = NULL
 	,PARTIAL_QUANTITIES_ALLOWED   = NULL
 	,AUTO_DETAILED                = NULL
 	,PICK_SLIP_NUMBER             = NULL
 	,LPN_ID                       = NULL
 	,LAST_UPDATE_DATE             = :new.last_update_date
 	,LAST_UPDATED_BY              = :new.last_updated_by
 	,CREATION_DATE                = :new.creation_date
 	,CREATED_BY                   = :new.created_by
 	,LAST_UPDATE_LOGIN            = :new.last_update_login
 	,REQUEST_ID                   = :new.request_id
 	,PROGRAM_APPLICATION_ID       = :new.program_application_id
 	,PROGRAM_ID                   = :new.program_id
 	,PROGRAM_UPDATE_DATE          = :new.program_update_date
 	,ATTRIBUTE_CATEGORY           = :new.attribute_category
 	,ATTRIBUTE1                   = :new.attribute1
 	,ATTRIBUTE2                   = :new.attribute2
 	,ATTRIBUTE3                   = :new.attribute3
 	,ATTRIBUTE4                   = :new.attribute4
 	,ATTRIBUTE5                   = :new.attribute5
 	,ATTRIBUTE6                   = :new.attribute6
 	,ATTRIBUTE7                   = :new.attribute7
 	,ATTRIBUTE8                   = :new.attribute8
 	,ATTRIBUTE9                   = :new.attribute9
 	,ATTRIBUTE10                  = :new.attribute10
 	,ATTRIBUTE11                  = :new.attribute11
 	,ATTRIBUTE12                  = :new.attribute12
 	,ATTRIBUTE13                  = :new.attribute13
 	,ATTRIBUTE14                  = :new.attribute14
 	,ATTRIBUTE15                  = :new.attribute15
 	,SHIP_READY_FLAG              = NULL
        where n_column1 = :old.demand_id;

        /*
        ** In INVRSV3B.pls, the package where reservation relief happens,
        ** delete of mtl_reservations happens. This is not
        ** necessary here.
        delete mtl_reservations
        where n_column1 = :old.demand_id
        and  (reservation_quantity         = 0
        or    primary_reservation_quantity = 0);
        */

   	l_sql_stmt_num := 10;

   	inv_rsv_trigger_global.g_from_trigger := FALSE;
   end if;

   if ((DELETING) and (inv_rsv_trigger_global.g_from_trigger = FALSE)) then
   	l_sql_stmt_num := 11;

   	inv_rsv_trigger_global.g_from_trigger := TRUE;

        delete mtl_reservations
        where n_column1 = :old.demand_id;

   	inv_rsv_trigger_global.g_from_trigger := FALSE;
   end if;

   EXCEPTION
        when others then

   	      inv_rsv_trigger_global.g_from_trigger := FALSE;

              l_return_err := 'MTL_DEMAND_T:' || 'S' ||
                              l_sql_stmt_num  || ':' ||
                              substrb(sqlerrm,1,55);

              raise_application_error(-20000,l_return_err);
end;


/
ALTER TRIGGER "APPS"."MTL_DEMAND_T" ENABLE;
