--------------------------------------------------------
--  DDL for Trigger MTL_SUPPLY_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SUPPLY_T" 

/* $Header: invtsupl.sql 120.1.12000000.2 2007/03/15 13:34:41 mokhan ship $ */

BEFORE INSERT OR UPDATE OR DELETE ON "INV"."MTL_SUPPLY"
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW

DECLARE

 MFG_DATE DATE;
 OLD_QTY  NUMBER;
 NEW_QTY  NUMBER;
 PROJECT_ID NUMBER;
 TASK_ID  NUMBER;
 L_COST_GROUP_ID NUMBER;

 CURSOR DIST_CURSOR IS
    select nvl(:new.to_org_primary_quantity, 0) * pd.req_line_quantity /
                pl.quantity,
           nvl(:old.to_org_primary_quantity, 0) * pd.req_line_quantity /
                pl.quantity, pd.project_id, pd.task_id

    from po_req_distributions_all pd,
         po_requisition_lines_all pl
    where
         :new.req_line_id = pl.requisition_line_id and
         pl.requisition_line_id = pd.requisition_line_id and
         pl.quantity > 0 and
         ((:new.supply_type_code = 'RECEIVING'and
           :new.po_distribution_id is null) or
          :new.supply_type_code = 'REQ'or
          :new.supply_type_code = 'SHIPMENT'
         ) and
         pl.requisition_line_id IS NOT NULL


    UNION ALL

    select nvl(:new.to_org_primary_quantity, 0),
           nvl(:old.to_org_primary_quantity, 0),
           pd.project_id, pd.task_id
    from po_distributions_all pd
    where
         :new.po_distribution_id = pd.po_distribution_id and
         ((:new.supply_type_code = 'RECEIVING' and
           :new.po_distribution_id is not null) or
          :new.supply_type_code = 'PO' or
          /* To fix bug 609103. Supply_type_code changed
             from 'ASN' to 'SHIPMENT' */
          :new.supply_type_code = 'SHIPMENT')

    UNION ALL

    select :new.to_org_primary_quantity,
           :old.to_org_primary_quantity,
           to_number(null), to_number(null)

    from dual
    where
         :new.req_line_id IS NULL and
         :new.po_distribution_id is NULL and
         :new.supply_type_code IN ('SHIPMENT', 'RECEIVING');

 CURSOR OLD_DIST_CURSOR IS
    select 0,
           nvl(:old.to_org_primary_quantity, 0) * pd.req_line_quantity /
                pl.quantity, pd.project_id, pd.task_id

    from po_req_distributions_all pd,
         po_requisition_lines_all pl
    where
         :old.req_line_id = pl.requisition_line_id and
         pl.requisition_line_id = pd.requisition_line_id and
         pl.quantity > 0 and
         ((:old.supply_type_code = 'RECEIVING'and
           :old.po_distribution_id is null) or
          :old.supply_type_code = 'REQ'or
          :old.supply_type_code = 'SHIPMENT'
         ) and
         pl.requisition_line_id IS NOT NULL


    UNION ALL

    select 0,
           nvl(:old.to_org_primary_quantity, 0),
           pd.project_id, pd.task_id
    from po_distributions_all pd
    where
         :old.po_distribution_id = pd.po_distribution_id and
         ((:old.supply_type_code = 'RECEIVING' and
           :old.po_distribution_id is not null) or
          :old.supply_type_code = 'PO' or
          :old.supply_type_code = 'SHIPMENT')

    UNION ALL

    select 0,
           :old.to_org_primary_quantity,
           to_number(null), to_number(null)

    from dual
    where
         :old.req_line_id IS NULL and
         :old.po_distribution_id is NULL and
         :old.supply_type_code IN ('SHIPMENT', 'RECEIVING');

 CURSOR COST_GROUP_CURSOR IS
    SELECT ppp.costing_group_id
    FROM   po_req_distributions_all prd
    ,      pjm_project_parameters ppp
    WHERE  prd.requisition_line_id = :new.req_line_id
    AND    ppp.organization_id = :new.intransit_owning_org_id
    AND    ppp.project_id = prd.project_id;

BEGIN
/*--------------------------------------------------------------------------+
 |  Calculate the expected delivery date (on insert or update)              |
 +--------------------------------------------------------------------------*/
    IF (:NEW.RECEIPT_DATE IS NOT NULL AND
        :NEW.ITEM_ID IS NOT NULL AND
        :NEW.TO_ORGANIZATION_ID IS NOT NULL AND
        :NEW.DESTINATION_TYPE_CODE IN ('INVENTORY', 'SHOP FLOOR'))
    THEN
      begin
        /* Bug# 3336484 - Added NVL to msi.postprocessing_lead_time */
	/*
	   BUG# 5756466 - Added TRUNC to new.receipt_date as calendar has
	   no timestamps but RECEIPT DATE can and hence comparision fails.
	*/
        select bc2.calendar_date into MFG_DATE
        from   bom_calendar_dates bc2,
               bom_calendar_dates bc1,
               mtl_system_items_B msi,
               mtl_parameters mp
        where  mp.organization_id = :new.to_organization_id
          and  msi.organization_id = mp.organization_id
          and  msi.inventory_item_id = :new.item_id
          and  mp.calendar_code = bc1.calendar_code
          and  mp.calendar_code = bc2.calendar_code
          and  mp.calendar_exception_set_id = bc1.exception_set_id
          and  mp.calendar_exception_set_id = bc2.exception_set_id
          and  bc1.calendar_date = trunc(:new.receipt_date)
          and  bc2.seq_num =
                nvl(bc1.seq_num, bc1.next_seq_num)+nvl(msi.postprocessing_lead_time,0);

      exception when NO_DATA_FOUND or TOO_MANY_ROWS then
        MFG_DATE := null;
      end;
      :new.expected_delivery_date := NVL(MFG_DATE,:new.expected_delivery_date);
    END IF;
/*--------------------------------------------------------------------------+
 |  If inserting a new row which is visible to MRP as supply or updating    |
 |  an existing row by changing it's supply_type_code or                    |
 |  destination_type_code then insert a row into mrp_relief_interface with  |
 |  the old quantity as 0 and old date null                                 |
 +--------------------------------------------------------------------------*/
    IF  ((INSERTING
            AND :NEW.DESTINATION_TYPE_CODE = 'INVENTORY'
            AND NVL(:NEW.CHANGE_TYPE, 'ABC') <> 'DELIVER')
        OR
        (UPDATING
            AND (:OLD.DESTINATION_TYPE_CODE
                <> :NEW.DESTINATION_TYPE_CODE
            AND :NEW.DESTINATION_TYPE_CODE = 'INVENTORY'
            AND NVL(:NEW.CHANGE_TYPE, 'ABC')  <> 'DELIVER')))
    THEN
    /*  Insert only if these required columns have values */
        IF (:NEW.EXPECTED_DELIVERY_DATE IS NOT NULL AND
            :NEW.ITEM_ID IS NOT NULL AND
            :NEW.TO_ORGANIZATION_ID IS NOT NULL AND
            :NEW.TO_ORG_PRIMARY_QUANTITY IS NOT NULL)
        THEN
            /* change: add a select for new quantity break into project and task by dist */
            OPEN dist_cursor;
            LOOP

                FETCH dist_cursor INTO new_qty, old_qty, project_id, task_id;
                exit when dist_cursor%notfound;

                INSERT  INTO    MRP_RELIEF_INTERFACE
                            (TRANSACTION_ID,
                            INVENTORY_ITEM_ID,
                            ORGANIZATION_ID,
                            LAST_UPDATE_DATE,
                            LAST_UPDATED_BY,
                            CREATION_DATE,
                            CREATED_BY,
                            LAST_UPDATE_LOGIN,
                            NEW_ORDER_QUANTITY,
                            OLD_ORDER_QUANTITY,
                            PROJECT_ID,                /* change */
                            TASK_ID,                   /* change */
                            NEW_ORDER_DATE,
                            OLD_ORDER_DATE,
                            DISPOSITION_ID,
                            PLANNED_ORDER_ID,
                            RELIEF_TYPE,
                            DISPOSITION_TYPE,
                            DEMAND_CLASS,
                            OLD_DEMAND_CLASS,
                            LINE_NUM,
                            REQUEST_ID,
                            PROGRAM_APPLICATION_ID,
                            PROGRAM_ID,
                            PROGRAM_UPDATE_DATE,
                            PROCESS_STATUS,
                            SOURCE_CODE,
                            SOURCE_LINE_ID,
                            ERROR_MESSAGE)
                VALUES(
                            MRP_RELIEF_INTERFACE_S.NEXTVAL,
                            :NEW.ITEM_ID,
                            :NEW.TO_ORGANIZATION_ID,
                            SYSDATE,
                            :NEW.LAST_UPDATED_BY,
                            SYSDATE,
                            :NEW.LAST_UPDATED_BY,
                            -1,
                            NEW_QTY,                       /* change */
                            0,
                            PROJECT_ID,                /* change */
                            TASK_ID,                   /* change */
                            :NEW.EXPECTED_DELIVERY_DATE,
                            NULL,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                        'REQ', :NEW.REQ_HEADER_ID,
                                        'SHIPMENT', :NEW.SHIPMENT_HEADER_ID,
                                        'PO', :NEW.PO_HEADER_ID,
                                            DECODE(:NEW.PO_HEADER_ID, NULL,
                                                    :NEW.SHIPMENT_HEADER_ID,
                                                    :NEW.PO_HEADER_ID)),
                            NULL,
                            2,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                        'REQ', 5,
                                        'PO', 2,
                                        'SHIPMENT', 7,
                                        DECODE(:NEW.PO_HEADER_ID, NULL,
                                        8, 6)),
                            NULL,
                            NULL,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                        'REQ', :NEW.REQ_LINE_ID,
                                        'SHIPMENT', :NEW.SHIPMENT_LINE_ID,
                                        'PO', :NEW.PO_LINE_ID,
                                        DECODE(:NEW.PO_LINE_ID, NULL,
                                                :NEW.SHIPMENT_LINE_ID,
                                                :NEW.PO_LINE_ID)),
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            2,
                            'INV',
                            NULL,
                            NULL);
            END LOOP;
            CLOSE dist_cursor;
        END IF;
    /*-----------------------------------------------------------------------+
     |  If updating the quantity and date of an existing row then insert a   |
     |  row into mrp_relief_interface with the old date and new date and old |
     |  quantity and new quantity                                            |
     +-----------------------------------------------------------------------*/

    /* Fix for bug 2562260.
       Removed the following AND condition from the following ELSIF stmt.
       "AND NVL(:OLD.CHANGE_TYPE, 'ABC') <> 'DELIVER'"
    */
   /* Bug 4328062 fixed. while doing partial delivery, made old_qty and
      new_qty same as per recommendations from MRP
  */

    ELSIF  (UPDATING AND    (:NEW.EXPECTED_DELIVERY_DATE IS NOT NULL
                     AND    :NEW.ITEM_ID IS NOT NULL
                     AND    :NEW.TO_ORGANIZATION_ID IS NOT NULL
                     AND    :NEW.SUPPLY_TYPE_CODE = :OLD.SUPPLY_TYPE_CODE
                     AND    :NEW.DESTINATION_TYPE_CODE =
                                :OLD.DESTINATION_TYPE_CODE
                     AND    :NEW.DESTINATION_TYPE_CODE = 'INVENTORY'
                     AND    (:NEW.TO_ORG_PRIMARY_QUANTITY <>
                                NVL(:OLD.TO_ORG_PRIMARY_QUANTITY, 0)
                            OR :NEW.EXPECTED_DELIVERY_DATE <>
                                NVL(:OLD.EXPECTED_DELIVERY_DATE,
                                        TO_DATE(1, 'J')))
                     AND     NVL(:NEW.CHANGE_TYPE, 'ABC') <> 'DELIVER'))
    THEN

        OPEN dist_cursor;
        LOOP

            FETCH dist_cursor INTO new_qty, old_qty, project_id, task_id;
            exit when dist_cursor%notfound;

            INSERT  INTO    MRP_RELIEF_INTERFACE
                            (TRANSACTION_ID,
                            INVENTORY_ITEM_ID,
                            ORGANIZATION_ID,
                            LAST_UPDATE_DATE,
                            LAST_UPDATED_BY,
                            CREATION_DATE,
                            CREATED_BY,
                            LAST_UPDATE_LOGIN,
                            NEW_ORDER_QUANTITY,
                            OLD_ORDER_QUANTITY,
                            PROJECT_ID,                /* change */
                            TASK_ID,                   /* change */
                            NEW_ORDER_DATE,
                            OLD_ORDER_DATE,
                            DISPOSITION_ID,
                            PLANNED_ORDER_ID,
                            RELIEF_TYPE,
                            DISPOSITION_TYPE,
                            DEMAND_CLASS,
                            OLD_DEMAND_CLASS,
                            LINE_NUM,
                            REQUEST_ID,
                            PROGRAM_APPLICATION_ID,
                            PROGRAM_ID,
                            PROGRAM_UPDATE_DATE,
                            PROCESS_STATUS,
                            SOURCE_CODE,
                            SOURCE_LINE_ID,
                            ERROR_MESSAGE)
            VALUES(
                            MRP_RELIEF_INTERFACE_S.NEXTVAL,
                            :NEW.ITEM_ID,
                            :NEW.TO_ORGANIZATION_ID,
                            SYSDATE,
                            :NEW.LAST_UPDATED_BY,
                            SYSDATE,
                            :NEW.LAST_UPDATED_BY,
                            -1,
							decode(:OLD.CHANGE_TYPE,'DELIVER',OLD_QTY,NEW_QTY),
                            OLD_QTY,                       /* change */
                            PROJECT_ID,                /* change */
                            TASK_ID,                   /* change */
                            :NEW.EXPECTED_DELIVERY_DATE,
                            :OLD.EXPECTED_DELIVERY_DATE,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                        'REQ', :NEW.REQ_HEADER_ID,
                                        'SHIPMENT', :NEW.SHIPMENT_HEADER_ID,
                                        'PO', :NEW.PO_HEADER_ID,
                                        DECODE(:NEW.PO_HEADER_ID, NULL,
                                                :NEW.SHIPMENT_HEADER_ID,
                                                :NEW.PO_HEADER_ID)),
                            NULL,
                            2,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                        'REQ', 5,
                                        'PO', 2,
                                        'SHIPMENT', 7,
                                        DECODE(:NEW.PO_HEADER_ID, NULL, 8,
                                        6)),
                            NULL,
                            NULL,
                            DECODE(:NEW.SUPPLY_TYPE_CODE,
                                    'REQ', :NEW.REQ_LINE_ID,
                                    'SHIPMENT', :NEW.SHIPMENT_LINE_ID,
                                    'PO', :NEW.PO_LINE_ID,
                                    DECODE(:NEW.PO_LINE_ID, NULL,
                                            :NEW.SHIPMENT_LINE_ID,
                                            :NEW.PO_LINE_ID)),
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            2,
                            'INV',
                            NULL,
                            NULL);
        END LOOP;
        CLOSE dist_cursor;
    END IF;
/*-------------------------------------------------------------------------+
 |  If a row is being deleted with the supply_type_code of PO or REQ or if |
 |  an existing row is being updated and the row was originally visible to |
 |  MRP and it's SUPPLY_TYPE_CODE is being changed or DESTINATION_TYPE_CODE|
 |  is being changed then insert a row for unrelief of the existing row    |
 +-------------------------------------------------------------------------*/
    /* If a row is being is deleted or it is being made not-visible to mrp
       then insert a row with a new_order_quantity as 0 to unconsume */

    /* Fix for bug 2562260.
       Removed the following AND condition from the following IF stmt.
       "AND NVL(:OLD.CHANGE_TYPE, 'ABC') <> 'DELIVER'"
    */
   /* Bug 4328062 fixed. while doing partial delivery, made old_qty and
      new_qty same as per recommendations from MRP
  */

    IF (DELETING    AND :OLD.DESTINATION_TYPE_CODE = 'INVENTORY'
                    AND :OLD.EXPECTED_DELIVERY_DATE IS NOT NULL
                    AND :OLD.ITEM_ID IS NOT NULL
                    AND :OLD.TO_ORGANIZATION_ID IS NOT NULL)
        THEN

            OPEN old_dist_cursor;
            LOOP

                FETCH old_dist_cursor INTO new_qty, old_qty, project_id, task_id;
                exit when old_dist_cursor%notfound;
                INSERT  INTO    MRP_RELIEF_INTERFACE
                                (TRANSACTION_ID,
                                INVENTORY_ITEM_ID,
                                ORGANIZATION_ID,
                                LAST_UPDATE_DATE,
                                LAST_UPDATED_BY,
                                CREATION_DATE,
                                CREATED_BY,
                                LAST_UPDATE_LOGIN,
                                NEW_ORDER_QUANTITY,
                                OLD_ORDER_QUANTITY,
                                OLD_PROJECT_ID,                /* change */
                                OLD_TASK_ID,                   /* change */
                                NEW_ORDER_DATE,
                                OLD_ORDER_DATE,
                                DISPOSITION_ID,
                                PLANNED_ORDER_ID,
                                RELIEF_TYPE,
                                DISPOSITION_TYPE,
                                DEMAND_CLASS,
                                OLD_DEMAND_CLASS,
                                LINE_NUM,
                                REQUEST_ID,
                                PROGRAM_APPLICATION_ID,
                                PROGRAM_ID,
                                PROGRAM_UPDATE_DATE,
                                PROCESS_STATUS,
                                SOURCE_CODE,
                                SOURCE_LINE_ID,
                                ERROR_MESSAGE)
                VALUES
                                (MRP_RELIEF_INTERFACE_S.NEXTVAL,
                                :OLD.item_id,
                                :OLD.TO_ORGANIZATION_ID,
                                sysdate,
                                :OLD.LAST_UPDATED_BY,
                                sysdate,
                                :OLD.LAST_UPDATED_BY,
                                -1,
                                decode(:OLD.CHANGE_TYPE,'DELIVER',OLD_QTY,0),
                                OLD_QTY,                   /* change */
                                PROJECT_ID,                /* change */
                                TASK_ID,                   /* change */
                                :OLD.EXPECTED_DELIVERY_DATE,
                                :OLD.EXPECTED_DELIVERY_DATE,
                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                    'REQ', :OLD.REQ_HEADER_ID,
                                    'PO', :OLD.PO_HEADER_ID,
                                    'SHIPMENT', :OLD.SHIPMENT_HEADER_ID,
                                    DECODE(:OLD.PO_HEADER_ID, NULL,
                                            :OLD.SHIPMENT_HEADER_ID,
                                            :OLD.PO_HEADER_ID)),
                                NULL,
                                2,
                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                                'REQ', 5,
                                                'PO', 2,
                                                'SHIPMENT', 7,
                                                DECODE(:OLD.PO_HEADER_ID, NULL,
                                                8, 6)),
                                NULL,
                                NULL, /* Check information on po in receiving */

                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                        'REQ', :OLD.REQ_LINE_ID,
                                        'PO', :OLD.PO_LINE_ID,
                                        'SHIPMENT', :OLD.SHIPMENT_LINE_ID,
                                        DECODE(:OLD.PO_LINE_ID, NULL,
                                                :OLD.SHIPMENT_LINE_ID,
                                                :OLD.PO_LINE_ID)),
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                2,
                                'INV',
                                NULL,
                                NULL);
        END LOOP;
        CLOSE old_dist_cursor;

    ELSIF
        (UPDATING   AND :OLD.DESTINATION_TYPE_CODE = 'INVENTORY'
                    AND (:NEW.SUPPLY_TYPE_CODE <> :OLD.SUPPLY_TYPE_CODE
                        OR
                        :NEW.DESTINATION_TYPE_CODE <>
                            :OLD.DESTINATION_TYPE_CODE)
                    AND :OLD.EXPECTED_DELIVERY_DATE IS NOT NULL
                    AND :OLD.ITEM_ID IS NOT NULL
                    AND :OLD.TO_ORGANIZATION_ID IS NOT NULL
                    AND NVL(:OLD.CHANGE_TYPE, 'ABC') <> 'DELIVER')
        THEN

            OPEN dist_cursor;
            LOOP

                FETCH dist_cursor INTO new_qty, old_qty, project_id, task_id;
                exit when dist_cursor%notfound;
                INSERT  INTO    MRP_RELIEF_INTERFACE
                                (TRANSACTION_ID,
                                INVENTORY_ITEM_ID,
                                ORGANIZATION_ID,
                                LAST_UPDATE_DATE,
                                LAST_UPDATED_BY,
                                CREATION_DATE,
                                CREATED_BY,
                                LAST_UPDATE_LOGIN,
                                NEW_ORDER_QUANTITY,
                                OLD_ORDER_QUANTITY,
                                PROJECT_ID,                /* change */
                                TASK_ID,                   /* change */
                                NEW_ORDER_DATE,
                                OLD_ORDER_DATE,
                                DISPOSITION_ID,
                                PLANNED_ORDER_ID,
                                RELIEF_TYPE,
                                DISPOSITION_TYPE,
                                DEMAND_CLASS,
                                OLD_DEMAND_CLASS,
                                LINE_NUM,
                                REQUEST_ID,
                                PROGRAM_APPLICATION_ID,
                                PROGRAM_ID,
                                PROGRAM_UPDATE_DATE,
                                PROCESS_STATUS,
                                SOURCE_CODE,
                                SOURCE_LINE_ID,
                                ERROR_MESSAGE)
                VALUES
                                (MRP_RELIEF_INTERFACE_S.NEXTVAL,
                                :OLD.item_id,
                                :OLD.TO_ORGANIZATION_ID,
                                sysdate,
                                :OLD.LAST_UPDATED_BY,
                                sysdate,
                                :OLD.LAST_UPDATED_BY,
                                -1,
                                0,
                                OLD_QTY,                   /* change */
                                PROJECT_ID,                /* change */
                                TASK_ID,                   /* change */
                                :OLD.EXPECTED_DELIVERY_DATE,
                                :OLD.EXPECTED_DELIVERY_DATE,
                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                    'REQ', :OLD.REQ_HEADER_ID,
                                    'PO', :OLD.PO_HEADER_ID,
                                    'SHIPMENT', :OLD.SHIPMENT_HEADER_ID,
                                    DECODE(:OLD.PO_HEADER_ID, NULL,
                                            :OLD.SHIPMENT_HEADER_ID,
                                            :OLD.PO_HEADER_ID)),
                                NULL,
                                2,
                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                                'REQ', 5,
                                                'PO', 2,
                                                'SHIPMENT', 7,
                                                DECODE(:OLD.PO_HEADER_ID, NULL,
                                                8, 6)),
                                NULL,
                                NULL, /* Check information on po in receiving */

                                DECODE(:OLD.SUPPLY_TYPE_CODE,
                                        'REQ', :OLD.REQ_LINE_ID,
                                        'PO', :OLD.PO_LINE_ID,
                                        'SHIPMENT', :OLD.SHIPMENT_LINE_ID,
                                        DECODE(:OLD.PO_LINE_ID, NULL,
                                                :OLD.SHIPMENT_LINE_ID,
                                                :OLD.PO_LINE_ID)),
                                NULL,
                                NULL,
                                NULL,
                                NULL,
                                2,
                                'INV',
                                NULL,
                                NULL);
        END LOOP;
        CLOSE dist_cursor;
    END IF;

    IF (INSERTING AND :NEW.SUPPLY_TYPE_CODE = 'SHIPMENT') THEN
      OPEN COST_GROUP_CURSOR;
      FETCH COST_GROUP_CURSOR INTO L_COST_GROUP_ID;
      CLOSE COST_GROUP_CURSOR;

      IF (L_COST_GROUP_ID IS NOT NULL) THEN
        :NEW.COST_GROUP_ID := L_COST_GROUP_ID;
      END IF;
    END IF;

 END;


/
ALTER TRIGGER "APPS"."MTL_SUPPLY_T" ENABLE;
