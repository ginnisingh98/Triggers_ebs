--------------------------------------------------------
--  DDL for Trigger MTL_MMTT_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_MMTT_T" 
  /* $Header: invmmttt.sql 120.6.12010000.3 2010/02/16 18:53:41 sfulzele ship $ */
  AFTER INSERT OR UPDATE
  ON "INV"."MTL_MATERIAL_TRANSACTIONS_TEMP"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
    WHEN (NEW.locator_id > 0) DECLARE
  l_return_err            VARCHAR2(80);
  l_sql_stmt_num          NUMBER         := 0;
  l_organization_id       NUMBER;
  l_inventory_item_id     NUMBER;
  l_locator_id            NUMBER;
  l_transfer_organization NUMBER;
  l_transfer_to_location  NUMBER;
  l_transaction_action_id NUMBER;
  l_primary_quantity      NUMBER;
  l_issue_flag            VARCHAR2(10);
  l_return_status         VARCHAR2(10);
  l_msg_data              VARCHAR2(1000);
  l_msg_count             NUMBER;
  l_transaction_quantity  NUMBER;
  l_transfer_lpn_id       NUMBER;
  l_content_lpn_id        NUMBER;
  l_lpn_id                NUMBER;
  l_condition             BOOLEAN;
  l_cartonization_id      NUMBER;
  l_container_item_id     NUMBER;
  l_debug                 NUMBER := NVL(FND_PROFILE.VALUE('INV_DEBUG_TRACE'),0);
  l_update                BOOLEAN := TRUE;
  l_is_outermost_lpn      NUMBER;
  l_item_id               NUMBER;
  l_transaction_source_type_id NUMBER;  --Added for bug# 4046825.
  l_wms_task_type         NUMBER;
  l_source                VARCHAR2(10) := NULL;  -- 8721026
  BEGIN
  l_sql_stmt_num  := 1;
  -- MMTT Record Background: Please read..
  -- Suggestions  - transaction_status = 2, posting_flag = 'Y'
  -- Transactions - transaction_status not(2), posting_flag = 'Y'

  -- If the inserted record is of type pending transaction(not suggestion)
  -- process as below.
  -- If the record is of type suggestion, Rules Engine would do the locator
  -- capacity update and its not needed here.

  -- Bug# 1524413
  -- if ((INSERTING) and (:new.posting_flag = 'Y') and
IF ((INSERTING) AND ((:NEW.transaction_status <> 2) OR (:NEW.transaction_status IS NULL))) THEN

    inv_trx_util_pub.TRACE('INSERTING', 'TRIGGER:', 9);
    l_sql_stmt_num           := 2;
    l_organization_id        := :NEW.organization_id;
    l_inventory_item_id      := :NEW.inventory_item_id;
    l_locator_id             := :NEW.locator_id;
    l_transfer_organization  := :NEW.transfer_organization;
    l_transfer_to_location   := :NEW.transfer_to_location;
    l_transaction_action_id  := :NEW.transaction_action_id;
    l_primary_quantity       := :NEW.primary_quantity;
    l_transaction_quantity   := :NEW.transaction_quantity;
    l_transaction_quantity   := :NEW.transaction_quantity;
    l_transfer_lpn_id        := :NEW.transfer_lpn_id;
    l_content_lpn_id         := :NEW.content_lpn_id;
    l_lpn_id                 := :NEW.lpn_id;
    l_sql_stmt_num           := 3;

    IF (l_debug=1) THEN
        inv_trx_util_pub.TRACE(
             'IN DB trigger- The values are  l_transaction_action is '
          || TO_CHAR(l_transaction_action_id)
          || ' - '
          || 'transfer organization_id '
          || TO_CHAR(l_organization_id)
          || ' - '
          || 'inventory_item_id '
          || TO_CHAR(l_inventory_item_id)
          || 'transfer locator_id '
          || TO_CHAR(l_locator_id)
          || 'l_transfer_lpn_id '
          || TO_CHAR(l_transfer_lpn_id)
          || 'l_content_lpn_id is '
          || TO_CHAR(l_content_lpn_id)
          || 'qty '
          || TO_CHAR(l_primary_quantity)
          || ' organization id '
          || to_char(l_organization_id)
          || ' locator id '
          || to_char(l_locator_id)
        , 'UPDATE_LPN_LOC_CURR_CAPACITY'
        , 4
        );
    END IF;
    IF l_transfer_lpn_id IS NOT NULL OR l_content_lpn_id IS NOT NULL OR l_lpn_id IS NOT NULL THEN
      IF l_content_lpn_id IS NOT NULL THEN
         --Inv Txns (Misc Issue/Xfr). Capacity Updation should happen only once, so we will call
         --update capacity only for the record with inventory_item_id = -1. This is the initial
         --record inserted into MMTT when Misc Issue/Xfer is performed.
          IF ((:NEW.transaction_source_type_id = 13 AND l_transaction_action_id IN (1,2,3))
	 	        /*added the the following as conditions for 4046825 Inbound Putaway, Inv Putaway, WIP Putaway*/
--Bug# 4144325      OR :NEW.WMS_TASK_TYPE = 2
/*end of 4046825*/  ) THEN
            IF :NEW.inventory_item_id <> -1 AND NVL(:NEW.wms_task_type,-1) <> 7 THEN
               l_update := FALSE;
            END IF;
         ELSIF (:NEW.transaction_source_type_id = 2 AND l_transaction_action_id =1) THEN
            --For SO Issue, there is no initial record for the entire LPN, but still we need to update
            --capacity only once. The logic used here is ignore all records which are not directly in
            --the outermost LPN. If the content LPN is the outermost LPN then fetch its contents.
            --Call update capacity proc only for the first content record. This would ensure that
            --updation happens only once.
            BEGIN
                SELECT 1
                  INTO l_is_outermost_lpn
                  FROM dual
                 WHERE EXISTS ( SELECT 1
                                  FROM wms_license_plate_numbers
                                 WHERE lpn_id = l_content_lpn_id
                                   AND outermost_lpn_id = l_content_lpn_id
                              );
            EXCEPTION
               WHEN no_data_found THEN
                  l_is_outermost_lpn := 0;
            END;

            IF l_is_outermost_lpn = 1 THEN
               BEGIN
                    SELECT inventory_item_id
                      INTO l_item_id
                      FROM wms_lpn_contents
                     WHERE parent_lpn_id = l_content_lpn_id
                       AND ROWNUM < 2;
               EXCEPTION
                  WHEN no_data_found THEN
                     l_update := FALSE;
               END;
               IF l_item_id <> :NEW.inventory_item_id THEN
                  l_update := FALSE;
               END IF;
            ELSE
               l_update := FALSE;
            END IF;
         END IF;
      END IF;
      IF l_update THEN
         IF l_transaction_action_id IN(2, 3, 28) THEN
           IF l_transfer_organization IS NULL THEN
             l_transfer_organization  := l_organization_id;
           END IF;
           -- bug#2876849. Added the two new parameters from org id and from loc id.
           -- previously they were being obtained from the LPN. but in case of
           -- staging Xfr, the LPN will not have any sub/loc stamped to it.
           inv_loc_wms_utils.update_lpn_loc_curr_capacity(
             x_return_status              => l_return_status
           , x_msg_count                  => l_msg_count
           , x_msg_data                   => l_msg_data
           , p_organization_id            => l_transfer_organization
           , p_inventory_location_id      => l_transfer_to_location
           , p_inventory_item_id          => l_inventory_item_id
           , p_primary_uom_flag           => 'Y'
           , p_transaction_uom_code       => NULL
           , p_transaction_action_id      => l_transaction_action_id
           , p_lpn_id                     => l_lpn_id
           , p_transfer_lpn_id            => l_transfer_lpn_id
           , p_content_lpn_id             => l_content_lpn_id
           , p_quantity                   => l_primary_quantity
           , p_from_org_id                => l_organization_id
           , p_from_loc_id                => l_locator_id
							  );

	      -- 8721026
           inv_trx_util_pub.TRACE( 'In DB TRIGGER -
                            l_source'||l_source||
                           'l_locator_id'||l_locator_id||
                           'l_content_lpn_id'||l_content_lpn_id||
                           'l_organization_id'||l_organization_id||
                           'l_inventory_item_id'||l_inventory_item_id||
                           'l_transaction_action_id'||l_transaction_action_id||
                           'l_locator_id'||l_locator_id||
                           'l_primary_quantity'||l_primary_quantity,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);


           inv_loc_wms_utils.get_source_type(
                x_source                     => l_source
              , p_locator_id                 => l_locator_id
              , p_organization_id            => l_organization_id
              , p_inventory_item_id          => l_inventory_item_id
              , p_content_lpn_id             => l_content_lpn_id
              , p_transaction_action_id      => l_transaction_action_id
              , p_primary_quantity           => l_primary_quantity
              );


           inv_trx_util_pub.TRACE( 'In DB TRIGGER -
                            l_source'||l_source,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);

           -- 8721026


           inv_loc_wms_utils.loc_empty_mixed_flag_auto(
             x_return_status              => l_return_status
           , x_msg_count                  => l_msg_count
           , x_msg_data                   => l_msg_data
           , p_organization_id            => l_organization_id
           , p_inventory_location_id      => l_locator_id
           , p_inventory_item_id          => l_inventory_item_id
           , p_transaction_action_id      => l_transaction_action_id
           , p_transfer_organization      => l_transfer_organization
           , p_transfer_location_id       => l_transfer_to_location
           , p_source                     => l_source   -- 8721026
           );
           IF (l_debug =1) THEN
              inv_trx_util_pub.TRACE('In DB trigger -status is ' || l_return_status, 'UPDATE_LPN_LOC_CURR_CAPACITY', 4);
           END IF;
         ELSE
           inv_loc_wms_utils.update_lpn_loc_curr_capacity(
             x_return_status              => l_return_status
           , x_msg_count                  => l_msg_count
           , x_msg_data                   => l_msg_data
           , p_organization_id            => l_organization_id
           , p_inventory_location_id      => l_locator_id
           , p_inventory_item_id          => l_inventory_item_id
           , p_primary_uom_flag           => 'Y'
           , p_transaction_uom_code       => NULL
           , p_transaction_action_id      => l_transaction_action_id
           , p_lpn_id                     => l_lpn_id
           , p_transfer_lpn_id            => l_transfer_lpn_id
           , p_content_lpn_id             => l_content_lpn_id
           , p_quantity                   => l_primary_quantity
							  );

 -- 8721026
              l_source := NULL;
              IF  l_transaction_action_id = 1  THEN
              inv_loc_wms_utils.get_source_type(
                x_source                     => l_source
              , p_locator_id                 => l_locator_id
              , p_organization_id            => l_organization_id
              , p_inventory_item_id          => l_inventory_item_id
              , p_content_lpn_id             => l_content_lpn_id
              , p_transaction_action_id      => l_transaction_action_id
              , p_primary_quantity           => l_primary_quantity
              );
              END IF;

              inv_trx_util_pub.TRACE('Calling  loc_empty_mixed_flag_auto with l_source' || l_source, 'UPDATE_LPN_LOC_CURR_CAPACITY', 4);


           inv_loc_wms_utils.loc_empty_mixed_flag_auto(
             x_return_status              => l_return_status
           , x_msg_count                  => l_msg_count
           , x_msg_data                   => l_msg_data
           , p_organization_id            => l_organization_id
           , p_inventory_location_id      => l_locator_id
           , p_inventory_item_id          => l_inventory_item_id
           , p_transaction_action_id      => l_transaction_action_id
           , p_transfer_organization      => l_transfer_organization
           , p_transfer_location_id       => l_transfer_to_location
           , p_source                     =>  l_source --8721026
           );
           IF (l_debug =1) THEN
              inv_trx_util_pub.TRACE('In DB trigger -status is ' || l_return_status, 'UPDATE_LPN_LOC_CURR_CAPACITY', 4);
           END IF;
         END IF;
      END IF;
    ELSE
      IF (l_debug =1) THEN
         inv_trx_util_pub.TRACE('IN DB trigger-for loose item', 'update_current_capacity', 4);
      END IF;
      /*
     ** The following transaction actions need to be flagged as issues
     ** Subinventory Xfers         2  inv_globals.G_Action_Subxfr
     ** Direct Org Xfers           3  inv_globals.G_Action_Orgxfr
     ** Intransit Shipment         21 inv_globals.G_Action_IntransitShipment
     ** Staging Xfers              28 inv_globals.G_Action_Stgxfr
     ** Delivery Adjustments       29 inv_globals.G_Action_DeliveryAdj
     ** Assembly Return            32 inv_globals.G_Action_AssyReturn
     ** Negative Component Return  34 inv_globals.G_Action_NegCompReturn
     */
      IF (l_transaction_action_id IN( 1,2,3,21,28,29,32,34)) THEN
        l_issue_flag  := 'Y';
      ELSE
        l_issue_flag  := 'N';
      END IF;

      --Bug4733477.For Lot Split/Merge/Translate,if qty<0,we should treat it as issue txn.
      IF (l_transaction_action_id IN(40,41,42) and l_primary_quantity < 0 ) THEN
        l_issue_flag  := 'Y';
      END IF;

      l_sql_stmt_num      := 4;
      -- No need to this. UPDATE_LOC_CURRENT_CAPACITY would do it anyway.
      -- But then, this eliminates any doubt.
      l_primary_quantity  := ABS(:NEW.primary_quantity);
      l_sql_stmt_num      := 5;
      -- Update locator capacity in source locator
      -- Receipts, Issues, Xfers
      inv_loc_wms_utils.update_loc_current_capacity(
        x_return_status              => l_return_status
      , x_msg_count                  => l_msg_count
      , x_msg_data                   => l_msg_data
      , p_organization_id            => l_organization_id
      , p_inventory_location_id      => l_locator_id
      , p_inventory_item_id          => l_inventory_item_id
      , p_primary_uom_flag           => 'Y'
      , p_transaction_uom_code       => NULL
      , p_quantity                   => l_primary_quantity
      , p_issue_flag                 => l_issue_flag
      );
      /*
     ** We don't want to err out. Hence no check and processing wrt return
     ** status
     */
      l_sql_stmt_num      := 6;

      -- Subinventory Xfers, Direct Org Xfers, Staging Xfers, update destination
      -- locator
      IF (l_transaction_action_id IN(inv_globals.g_action_subxfr, inv_globals.g_action_orgxfr, inv_globals.g_action_stgxfr))
         AND (l_transfer_to_location > 0) THEN
        l_issue_flag        := 'N';
        l_sql_stmt_num      := 7;

        /* Added the if condition below as a part of fix 2127326 */
        IF l_transfer_organization IS NULL THEN
          l_transfer_organization  := l_organization_id;
        END IF;

        /* End of fix for bug as a part of fix 2127326 */

        -- No need to this. UPDATE_LOC_CURRENT_CAPACITY would do it anyway.
        -- But then, this eliminates any doubt.
        l_primary_quantity  := ABS(l_primary_quantity);
        l_sql_stmt_num      := 8;
        -- Update locator capacity in destination locator

        inv_loc_wms_utils.update_loc_current_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_transfer_organization
        , p_inventory_location_id      => l_transfer_to_location
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_issue_flag                 => l_issue_flag
        );
        /*
       ** We don't want to err out.
       ** Hence no check and processing wrt return status
       */
        l_sql_stmt_num      := 9;
      END IF;
 -- 8721026  start
           inv_trx_util_pub.TRACE( 'In DB TRIGGER-
                            l_source 2  -'||l_source||
                           ' l_locator_id'||l_locator_id||
                           ' l_content_lpn_id'||l_content_lpn_id||
                           ' l_organization_id'||l_organization_id||
                           ' l_inventory_item_id'||l_inventory_item_id||
                           ' l_transaction_action_id'||l_transaction_action_id||
                           ' l_locator_id'||l_locator_id||
                           ' l_primary_quantity'||l_primary_quantity,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);


           inv_loc_wms_utils.get_source_type(
                x_source                     => l_source
              , p_locator_id                 => l_locator_id
              , p_organization_id            => l_organization_id
              , p_inventory_item_id          => l_inventory_item_id
              , p_content_lpn_id             => l_content_lpn_id
              , p_transaction_action_id      => l_transaction_action_id
              , p_primary_quantity           => l_primary_quantity
              );


           inv_trx_util_pub.TRACE( 'In DB TRIGGER -
                            l_source 2 -'||l_source,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);


           -- 8721026  end


      l_sql_stmt_num      := 10;
      inv_loc_wms_utils.loc_empty_mixed_flag_auto(
        x_return_status              => l_return_status
      , x_msg_count                  => l_msg_count
      , x_msg_data                   => l_msg_data
      , p_organization_id            => l_organization_id
      , p_inventory_location_id      => l_locator_id
      , p_inventory_item_id          => l_inventory_item_id
      , p_transaction_action_id      => l_transaction_action_id
      , p_transfer_organization      => l_transfer_organization
      , p_transfer_location_id       => l_transfer_to_location
      , p_source                     => l_source -- 8721026
      );
    END IF;  /* End if for transfer_lpn_id is not null or content_lpn_id is not null or lpn_id is not null */
  END IF;

  -- Sensing suggestion is transitioning into pending transaction.

  -- Bug# 1524413
  -- if ((UPDATING) and (:new.posting_flag = 'Y') and (:old.transaction_status = 2 and
  -- debug('old transaction status:'||:old.transation_status);
  -- debug('new transaction status:'||:new.transaction_status);

  -- Even when updation of suggestion happens, check if the transaction is
  -- containerized, if so call the update_lpn_capacity() proc, else call
  -- the original API.
  IF ((UPDATING)
      AND ((:OLD.transaction_status = 2
           AND (:NEW.transaction_status <> 2
                OR :NEW.transaction_status IS NULL
               )
           )
           OR (:NEW.transaction_action_id = 50 AND (:NEW.transfer_lpn_id IS NOT NULL
                                                    AND :old.transfer_lpn_id IS NULL))
           )
      AND NOT (:NEW.transaction_type_id = 2 AND :NEW.transaction_action_id = 2 AND :NEW.transaction_source_type_id = 13 AND :NEW.transaction_quantity = 1)
     ) THEN
    -- Bug 4494281 the last AND condition above is required in order to avoid the updation of locator capacity matching the above condition, for staging trxfr
    -- the or condition is necessary for bulk pack, where the mmtt record initially does
    -- not have the transfer lpn stamped. but it is later update.
    IF (l_debug=1) THEN
       inv_trx_util_pub.TRACE('UPDATING', 'TRIGGER:', 9);
    END IF;
    l_sql_stmt_num           := 11;
    l_organization_id        := :NEW.organization_id;
    l_inventory_item_id      := :NEW.inventory_item_id;
    l_locator_id             := :NEW.locator_id;
    l_transfer_organization  := :NEW.transfer_organization;
    l_transfer_to_location   := :NEW.transfer_to_location;
    l_transaction_action_id  := :NEW.transaction_action_id;
    l_primary_quantity       := :NEW.primary_quantity;
    l_transaction_quantity   := :NEW.transaction_quantity;
    l_transaction_quantity   := :NEW.transaction_quantity;
    l_transfer_lpn_id        := :NEW.transfer_lpn_id;
    l_content_lpn_id         := :NEW.content_lpn_id;
    l_lpn_id                 := :NEW.lpn_id;
    l_container_item_id      := :NEW.container_item_id;
    l_cartonization_id       := :NEW.cartonization_id;
    l_wms_task_type          := :NEW.wms_task_type;
    l_sql_stmt_num           := 12;
    l_transaction_source_type_id := :NEW.transaction_source_type_id;  --Added for Bug# 4046825.
    IF (l_debug=1) THEN
        inv_trx_util_pub.TRACE(
             'IN DB trigger- The value of l_transaction_action is '
          || TO_CHAR(l_transaction_action_id)
          || ' - '
          || 'transfer organization_id '
          || TO_CHAR(l_transfer_organization)
          || ' - '
          || 'inventory_item_id '
          || TO_CHAR(l_inventory_item_id)
          || 'transfer locator_id '
          || TO_CHAR(l_transfer_to_location)
          || 'l_transfer_lpn_id '
          || TO_CHAR(l_transfer_lpn_id)
          || ' l_content_lpn_id is '
          || TO_CHAR(l_content_lpn_id)
          || ' l_lpn_id is '
          || TO_CHAR(l_lpn_id)
          || ' qty '
          || TO_CHAR(l_primary_quantity)
          || ' organization id '
          || to_char(l_organization_id)
          || ' locator id '
          || to_char(l_locator_id)
        , 'UPDATE_LPN_LOC_CURR_CAPACITY'
        , 4
        );
    END IF;

    IF l_transfer_lpn_id IS NOT NULL OR l_content_lpn_id IS NOT NULL OR l_lpn_id IS NOT NULL THEN
      -- Picking Suggestion
      -- inv_globals.g_action_subxfr = 2
      -- inv_globals.g_action_orgxfr = 3
      -- inv_globals.g_action_stgxfr = 28
      IF (l_transaction_action_id IN (2,3,28)) THEN
        IF l_transfer_organization IS NULL THEN
          l_transfer_organization  := l_organization_id;
        END IF;
     /* Bug# 4046825. The following IF condition is added to prevent updating current
        capacity in case the lpn is going to be exploded by TM. */
     IF (NOT ( l_content_lpn_id IS NOT NULL
              AND (l_transaction_action_id <> inv_globals.g_action_containerpack)
              AND (l_transaction_action_id <> inv_globals.g_action_containerunpack)
	      AND (l_transaction_action_id <> inv_globals.g_action_containersplit)
              AND NOT (l_transaction_source_type_id <> inv_globals.g_sourcetype_intorder
                 OR (l_transaction_source_type_id = inv_globals.g_sourcetype_intorder
                    AND l_transaction_action_id = inv_globals.g_action_stgxfr ) )
	      AND NOT ( l_transaction_source_type_id <> inv_globals.g_sourcetype_salesorder
                 OR (l_transaction_source_type_id = inv_globals.g_sourcetype_salesorder
		     AND l_transaction_action_id = inv_globals.g_action_stgxfr ) )
              AND (  l_transaction_action_id <> inv_globals.G_Action_Subxfr AND l_wms_task_type <> 2 )
            ) -- End of first NOT
	    AND NOT ( l_content_lpn_id IS NOT NULL AND l_transaction_action_id = inv_globals.G_Action_Subxfr AND l_wms_task_type in (4,5)) --4655988
	    ) THEN

    IF (l_debug=1) THEN
        inv_trx_util_pub.TRACE(
	'UPDATING '
	|| 'l_txn_action_id :' || l_transaction_action_id
	|| 'l_wms_task_type :' || l_wms_task_type );
    END IF;
	-- Bug 4494281, the condition l_transaction_action_id = inv_globals.G_Action_Subxfr, allows the updation
	-- of locator capacity for dropping to consolidation locator, which is done by TM also. Should be <>
        -- Update locator current capacity.
        -- bug#2876849. Added the two new parameters from org id and from loc id.
        -- previously they were being obtained from the LPN. but in case of
        -- staging Xfr, the LPN will not have any sub/loc stamped to it.
        inv_loc_wms_utils.update_lpn_loc_curr_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_transfer_organization
        , p_inventory_location_id      => l_transfer_to_location
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_transaction_action_id      => l_transaction_action_id
        , p_lpn_id                     => l_lpn_id
        , p_transfer_lpn_id            => l_transfer_lpn_id
        , p_content_lpn_id             => l_content_lpn_id
        , p_quantity                   => l_primary_quantity
        , p_from_loc_id                => l_locator_id
        , p_from_org_id                => l_organization_id
        );
       IF (l_debug=1) THEN
         inv_trx_util_pub.TRACE('IN DB TRIGGER -status is ' || l_return_status, 'UPDATE_LPN_LOC_CURR_CAPACITY', 4);
       END IF;
     END IF;  /*End of  fix for Bug#4046825.*/
        --Revert Suggested Capacity.
        inv_loc_wms_utils.revert_loc_suggested_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_transfer_organization
        , p_inventory_location_id      => l_transfer_to_location
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_content_lpn_id             => l_content_lpn_id); --bug#9159019 FPing fix for #8944467
      --Putaway Transaction (Transaction Action ID = 27)
      --ELSIF (l_transaction_action_id = inv_globals.g_action_receipt) THEN
    ELSE
       /*Bug# 4046825. The following IF condition is added to prevent updating current
                       capacity in case the lpn is going to be exploded by TM.*/
        IF (NOT( l_content_lpn_id IS NOT NULL
              AND (l_transaction_action_id <> inv_globals.g_action_containerpack)
              AND (l_transaction_action_id <> inv_globals.g_action_containerunpack)
	        AND (l_transaction_action_id <> inv_globals.g_action_containersplit)
              AND NOT(l_transaction_source_type_id <> inv_globals.g_sourcetype_intorder
                 OR (l_transaction_source_type_id = inv_globals.g_sourcetype_intorder
                    AND l_transaction_action_id = inv_globals.g_action_stgxfr ) )
	        AND NOT( l_transaction_source_type_id <> inv_globals.g_sourcetype_salesorder
                 OR (l_transaction_source_type_id = inv_globals.g_sourcetype_salesorder
		      AND l_transaction_action_id = inv_globals.g_action_stgxfr ) )
            ) -- End of First NOT
	    AND NOT (l_content_lpn_id IS NOT NULL AND l_transaction_action_id = inv_globals.G_Action_Issue AND l_wms_task_type = 6) -- MO Issue tasks
	    ) THEN

          --Update Locator Capacity.
          -- added the two new parameters because for bulk pack, the transfer lpn
          -- does not have the container capacity stamped. it needs to be calculated
          -- from the container item.
          inv_loc_wms_utils.update_lpn_loc_curr_capacity(
            x_return_status              => l_return_status
          , x_msg_count                  => l_msg_count
          , x_msg_data                   => l_msg_data
          , p_organization_id            => l_organization_id
          , p_inventory_location_id      => l_locator_id
          , p_inventory_item_id          => l_inventory_item_id
          , p_primary_uom_flag           => 'Y'
          , p_transaction_uom_code       => NULL
          , p_transaction_action_id      => l_transaction_action_id
          , p_lpn_id                     => l_lpn_id
          , p_transfer_lpn_id            => l_transfer_lpn_id
          , p_content_lpn_id             => l_content_lpn_id
          , p_quantity                   => l_primary_quantity
          , p_container_item_id          => l_container_item_id
          , p_cartonization_id           => l_cartonization_id
          );
          inv_trx_util_pub.TRACE('In DB TRIGGER -status is ' || l_return_status, 'UPDATE_LPN_LOC_CURR_CAPACITY', 4);
	     END IF; /*End of fix for Bug#4046825.*/
        --Revert Suggested Capacity.
        inv_loc_wms_utils.revert_loc_suggested_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_organization_id
        , p_inventory_location_id      => l_locator_id
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        );
      END IF;
    ELSE
      inv_trx_util_pub.TRACE('IN DB trigger-for loose item', 'update_current_capacity', 4);
      inv_trx_util_pub.TRACE('transaction action id is:' || l_transaction_action_id, 'TRIGGER:', 9);

      -- Picking Suggestion (Txn action 2,3,28)
      IF (l_transaction_action_id IN(2,3,28)) THEN
        l_primary_quantity  := ABS(l_primary_quantity);
        l_sql_stmt_num      := 13;
        -- Update locator current capacity in source locator

        inv_loc_wms_utils.update_loc_current_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_organization_id
        , p_inventory_location_id      => l_locator_id
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_issue_flag                 => 'Y'
        );
        l_sql_stmt_num      := 14;
        -- Update locator capacity in destination locator

        inv_loc_wms_utils.update_loc_current_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_transfer_organization
        , p_inventory_location_id      => l_transfer_to_location
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_issue_flag                 => 'N'
        );
        l_sql_stmt_num      := 15;
        -- Revert locator suggested capacity in destination locator

        inv_loc_wms_utils.revert_loc_suggested_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_transfer_organization
        , p_inventory_location_id      => l_transfer_to_location
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        );
        l_sql_stmt_num      := 16;
      -- No action need be done wrt suggestion in source side
      -- because locator capacity is not updated for issue
      -- suggestions.
      END IF;

      -- Putaway suggestion (Txn action 27)
      IF (l_transaction_action_id = 27) THEN
        l_primary_quantity  := ABS(l_primary_quantity);
        l_sql_stmt_num      := 17;
        -- Update locator current capacity in receipt locator

        inv_loc_wms_utils.update_loc_current_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_organization_id
        , p_inventory_location_id      => l_locator_id
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_issue_flag                 => 'N'
        );
        l_sql_stmt_num      := 18;
        -- Revert locator suggested capacity in receipt locator

        inv_loc_wms_utils.revert_loc_suggested_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_organization_id
        , p_inventory_location_id      => l_locator_id
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        );
        l_sql_stmt_num      := 19;
      END IF;

      -- bug#3319169 handle the loc capacity updates for issue txn for loose items
      IF (l_transaction_action_id = 1) THEN
        l_primary_quantity  := ABS(l_primary_quantity);
        l_sql_stmt_num      := 21;
        -- Update locator current capacity in source locator

        inv_loc_wms_utils.update_loc_current_capacity(
          x_return_status              => l_return_status
        , x_msg_count                  => l_msg_count
        , x_msg_data                   => l_msg_data
        , p_organization_id            => l_organization_id
        , p_inventory_location_id      => l_locator_id
        , p_inventory_item_id          => l_inventory_item_id
        , p_primary_uom_flag           => 'Y'
        , p_transaction_uom_code       => NULL
        , p_quantity                   => l_primary_quantity
        , p_issue_flag                 => 'Y'
        );
        l_sql_stmt_num      := 22;
      END IF;



    END IF;



    -- 8721026
       inv_trx_util_pub.TRACE( 'In DB TRIGGER3 -
                            l_source'||l_source||
                           ' l_locator_id'||l_locator_id||
                           ' l_content_lpn_id'||l_content_lpn_id||
                           ' l_organization_id'||l_organization_id||
                           ' l_inventory_item_id'||l_inventory_item_id||
                           ' l_transaction_action_id'||l_transaction_action_id||
                           ' l_locator_id'||l_locator_id||
                           ' l_primary_quantity'||l_primary_quantity,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);


       inv_loc_wms_utils.get_source_type(
                x_source                     => l_source
              , p_locator_id                 => l_locator_id
              , p_organization_id            => l_organization_id
              , p_inventory_item_id          => l_inventory_item_id
              , p_content_lpn_id             => l_content_lpn_id
              , p_transaction_action_id      => l_transaction_action_id
              , p_primary_quantity           => l_primary_quantity
              );


       inv_trx_util_pub.TRACE( 'In DB TRIGGER 3-
                            l_source'||l_source,
                           'UPDATE_LPN_LOC_CURR_CAPACITY', 4);
       -- 8721026

    --Update Mixed Items Flag.
    inv_loc_wms_utils.loc_empty_mixed_flag_auto(
      x_return_status              => l_return_status
    , x_msg_count                  => l_msg_count
    , x_msg_data                   => l_msg_data
    , p_organization_id            => l_organization_id
    , p_inventory_location_id      => l_locator_id
    , p_inventory_item_id          => l_inventory_item_id
    , p_transaction_action_id      => l_transaction_action_id
    , p_transfer_organization      => l_transfer_organization
    , p_transfer_location_id       => l_transfer_to_location
    , p_source                     =>  l_source  -- 8721026
    );
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    l_return_err  := 'MTL_MMTT_T:' || 'S' || l_sql_stmt_num || ':' || SUBSTRB(SQLERRM, 1, 55);
    raise_application_error(-20000, l_return_err);
END;

/
ALTER TRIGGER "APPS"."MTL_MMTT_T" ENABLE;
