--------------------------------------------------------
--  DDL for Trigger JL_BR_PO_IMPORT_REQUISITIONS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_PO_IMPORT_REQUISITIONS" 
BEFORE INSERT ON "PO"."PO_REQUISITION_LINES_ALL"
FOR EACH ROW
  WHEN (new.transaction_reason_code is null) DECLARE

  v_country_code     varchar2(2);
  v_org_id           number;
  v_dest_org_id      number;
  v_inv_org_id       number;
  v_item_id          number;
  v_req_header_id    number;
  l_apps_source_code  varchar2(30) := NULL;   --  var to hold the value of apps_source_code from the po_headers table
  v_tran_reason_code_sys varchar2(30);
  v_tran_reason_code_mtl varchar2(30);
  v_tran_reason_org_name varchar2(50);

BEGIN

  --v_country_code := fnd_profile.value('JGZZ_COUNTRY_CODE');

    v_org_id         := :new.org_id;                                            -- OU org id from table
    v_dest_org_id    := :new.destination_organization_id;                       -- Destination org id from table
    v_req_header_id  := :new.requisition_header_id;                             -- Requisition Header Id from Lines table
    v_item_id        := :new.item_id;
    v_country_code   := jg_zz_shared_pkg.get_country(v_org_id);


    if v_country_code = 'BR' then

      begin

      select APPS_SOURCE_CODE into l_apps_source_code                                 -- bug 8313223
      from PO_REQUISITION_HEADERS_ALL where REQUISITION_HEADER_ID = v_req_header_id;

      exception
      when others then
      l_apps_source_code := NULL;

      end;

     if nvl(l_apps_source_code,-99) <> 'POR' then            -- To restrict the trigger to work in i proc OA page for bug 8313223

  -- Select the transaction_reason_code default from po_system_parameters_all

          begin
             select c.global_attribute1
             into   v_tran_reason_code_sys
             from   po_system_parameters_all c
             WHERE c.org_id = v_org_id;
          exception
             when no_data_found then null;
          end;

  -- For Inventory item Select the transaction_reason_code default from mtl_system_items.

          if v_item_id is not null then

             begin
                select fsp.inventory_organization_id
                into   v_inv_org_id                                              -- selecting Inventory org id using OU org id
                from   FINANCIALS_SYSTEM_PARAMS_ALL fsp,
                       gl_sets_of_books sob
                where  fsp.set_of_books_id = sob.set_of_books_id
                  and  fsp.org_id = v_org_id;
             exception
                when no_data_found then null;
             end;



   --select the Organization Name for the transaction reason GDF3 from po_system_parameters_all

          begin
            SELECT c.global_attribute3
            into v_tran_reason_org_name
            FROM po_system_parameters_all c
            WHERE c.org_id = v_org_id;
          exception
             when no_data_found then null;
          end;



           begin

             IF  (NVL (v_tran_reason_org_name,'MASTER INVENTORY ORGANIZATION') = 'INVENTORY ORGANIZATION')  THEN

                  SELECT b.global_attribute2
                  into v_tran_reason_code_mtl
                  FROM mtl_system_items_b b
                  WHERE b.inventory_item_id = v_item_id
                  AND b.organization_id = v_dest_org_id;      -- destination organization id

             ELSIF  (NVL (v_tran_reason_org_name,'MASTER INVENTORY ORGANIZATION') = 'MASTER INVENTORY ORGANIZATION')  THEN

                 SELECT b.global_attribute2
                 into v_tran_reason_code_mtl
                 FROM mtl_system_items_b b
                 WHERE b.inventory_item_id = v_item_id
                 AND b.organization_id = v_inv_org_id;        -- inventory organization id

             ELSE

                 SELECT c.global_attribute1
                 into v_tran_reason_code_mtl
                 FROM po_system_parameters_all c
                 WHERE c.org_id = v_org_id;                   -- OU organization id used to get default tran reason code

             END IF;

          exception
                  when no_data_found then null;
          end;


         end if;

         if v_tran_reason_code_mtl is not null then
            :new.transaction_reason_code := v_tran_reason_code_mtl;
         else
            :new.transaction_reason_code := v_tran_reason_code_sys;
         end if;

     end if;

    end if;

END;



/
ALTER TRIGGER "APPS"."JL_BR_PO_IMPORT_REQUISITIONS" ENABLE;
