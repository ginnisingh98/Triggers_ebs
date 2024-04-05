--------------------------------------------------------
--  DDL for Trigger MSC_TRG_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MSC_TRG_AUDIT" 
    after insert or delete or
    update of designator, version, quantity, comments, key_date, ship_date,
              receipt_date, new_schedule_date, new_order_placement_date,
              original_promised_date, request_date, last_refresh_number, bucket_type
    on "MSC"."MSC_SUP_DEM_ENTRIES"
    for each row


/* note: we are currently not using planned_wip_start_date,
   planned_wip_end_date, wip_start_date, wip_end_date hence these
   are not included in the list of columns above
*/


begin


   if INSERTING then

        insert into msc_sup_dem_history (
                            history_id,
                            plan_id,
                            transaction_id,
                            publisher_name,
                            publisher_site_name,
                            publisher_order_type,
                            publisher_order_type_desc,
                            item_name,
                            item_description,
                            owner_item_name,
                            owner_item_description,
                            supplier_item_name,
                            supplier_item_description,
                            customer_item_name,
                            customer_item_description,
                            customer_name,
                            customer_site_name,
                            supplier_name,
                            supplier_site_name,
                            order_number,
                            line_number,
                            release_number,
                            end_order_number,
                            end_order_line_number,
                            end_order_rel_number,
                            designator_old,
                            designator_new,
                            version_old,
                            version_new,
                            quantity_old,
                            quantity_new,
                            comments_old,
                            comments_new,
                            key_date_old,
                            key_date_new,
                            ship_date_old,
                            ship_date_new,
                            receipt_date_old,
                            receipt_date_new,
                            new_schedule_date_old,
                            new_schedule_date_new,
                            new_order_placement_date_old,
                            new_order_placement_date_new,
                            original_promised_date_old,
                            original_promised_date_new,
                            request_date_old,
                            request_date_new,
                            planned_wip_start_date_old,
                            planned_wip_start_date_new,
                            planned_wip_end_date_old,
                            planned_wip_end_date_new,
                            wip_start_date_old,
                            wip_start_date_new,
                            wip_end_date_old,
                            wip_end_date_new,
                            last_refresh_number_old,
                            last_refresh_number_new,
                            last_update_date,
                            last_updated_by,
			    use_for_comparison,
			    bucket_type_new,
			    bucket_type_old,
                            dmltype)
                            values ( msc_sup_dem_history_s.nextval,
                                     :new.plan_id,
                                     :new.transaction_id,
                                     :new.publisher_name,
                                     :new.publisher_site_name,
                                     :new.publisher_order_type,
                                     :new.publisher_order_type_desc,
                                     :new.item_name,
                                     :new.item_description,
                                     :new.owner_item_name,
                                     :new.owner_item_description,
                                     :new.supplier_item_name,
                                     :new.supplier_item_description,
                                     :new.customer_item_name,
                                     :new.customer_item_description,
                                     :new.customer_name,
                                     :new.customer_site_name,
                                     :new.supplier_name,
                                     :new.supplier_site_name,
                                     :new.order_number,
                                     :new.line_number,
                                     :new.release_number,
                                     :new.end_order_number,
                                     :new.end_order_line_number,
                                     :new.end_order_rel_number,
                                     null,
                                     :new.designator,
                                     null,
                                     :new.version,
                                     null,
                                     :new.quantity,
                                     null,
                                     :new.comments,
                                     null,
                                     :new.key_date,
                                     null,
                                     :new.ship_date,
                                     null,
                                     :new.receipt_date,
                                     null,
                                     :new.new_schedule_date,
                                     null,
                                     :new.new_order_placement_date,
                                     null,
                                     :new.original_promised_date,
                                     null,
                                     :new.request_date,
                                     null,
                                     :new.planned_wip_start_date,
                                     null,
                                     :new.planned_wip_end_date,
                                     null,
                                     :new.wip_start_date,
                                     null,
                                     :new.wip_end_date,
                                     null,
                                     :new.last_refresh_number,
                                     :new.last_update_date,
                                     :new.last_updated_by,
				     1,
				     :new.bucket_type,
				     null,
                                     'I');


   elsif DELETING then

		    begin
				 /* Bug # 4252144  */
			   if :old.publisher_order_type in ( 1,2,3)  then
				    update msc_sup_dem_history
				    set use_for_comparison = 2
				    where item_name = :old.item_name
				      and plan_id = :old.plan_id
				      and publisher_order_type = :old.publisher_order_type
				      and supplier_name = :old.supplier_name
				      and supplier_site_name = :old.supplier_site_name
				      and customer_name = :old.customer_name
				      and customer_site_name = :old.customer_site_name
				     -- and nvl(designator_new,'-99999') = nvl(:old.designator,'-99999')--check if this is bcoz of the design
				      and nvl(version_new,'-99999') = nvl(:old.version,'-99999')
				      and trunc(key_date_new) = trunc(:old.key_date)
				      and bucket_type_new = :old.bucket_type
				      and exists (select
							1
						from
							msc_supdem_lines_interface mi,msc_sup_dem_history mh
						where
							mi.item_name = mh.item_name
							--and plan_id = :old.plan_id
							and mi.order_type = mh.publisher_order_type
							and mi.SUPPLIER_COMPANY = mh.supplier_name
							and mi.SUPPLIER_SITE = mh.supplier_site_name
							and mi.CUSTOMER_COMPANY = mh.customer_name
							and mi.CUSTOMER_SITE = mh.customer_site_name
							and nvl(mi.DESIGNATOR,'-99999') = nvl(mh.designator_new,'-99999')
							--and nvl(version_new,'-99999') = nvl(:old.version,'-99999')
							and trunc(to_date(mi.key_date,nvl(fnd_profile.value('ICX_DATE_FORMAT_MASK'),'MM-DD-YYYY'))) = trunc(mh.key_date_new)
							and mi.bucket_type = mh.bucket_type_new
							and mi.SYNC_INDICATOR='D'
							and mh.item_name = :old.item_name
							and mh.plan_id = :old.plan_id
							and mh.publisher_order_type = :old.publisher_order_type
							and mh.supplier_name = :old.supplier_name
							and mh.supplier_site_name = :old.supplier_site_name
							and mh.customer_name = :old.customer_name
							and mh.customer_site_name = :old.customer_site_name
							--and nvl(mh.designator_new,'-99999') = nvl(:old.designator,'-99999')
							and nvl(mh.version_new,'-99999') = nvl(:old.version,'-99999')
							and trunc(mh.key_date_new) = trunc(:old.key_date)
							and mh.bucket_type_new = :old.bucket_type);
			  end if ;
		    exception
			when others then
				null;
		     end;

			insert into msc_sup_dem_history (
                            history_id,
                            plan_id,
                            transaction_id,
                            publisher_name,
                            publisher_site_name,
                            publisher_order_type,
                            publisher_order_type_desc,
                            item_name,
                            item_description,
                            owner_item_name,
                            owner_item_description,
                            supplier_item_name,
                            supplier_item_description,
                            customer_item_name,
                            customer_item_description,
                            customer_name,
                            customer_site_name,
                            supplier_name,
                            supplier_site_name,
                            order_number,
                            line_number,
                            release_number,
                            end_order_number,
                            end_order_line_number,
                            end_order_rel_number,
                            designator_old,
                            designator_new,
                            version_old,
                            version_new,
                            quantity_old,
                            quantity_new,
                            comments_old,
                            comments_new,
                            key_date_old,
                            key_date_new,
                            ship_date_old,
                            ship_date_new,
                            receipt_date_old,
                            receipt_date_new,
                            new_schedule_date_old,
                            new_schedule_date_new,
                            new_order_placement_date_old,
                            new_order_placement_date_new,
                            original_promised_date_old,
                            original_promised_date_new,
                            request_date_old,
                            request_date_new,
                            planned_wip_start_date_old,
                            planned_wip_start_date_new,
                            planned_wip_end_date_old,
                            planned_wip_end_date_new,
                            wip_start_date_old,
                            wip_start_date_new,
                            wip_end_date_old,
                            wip_end_date_new,
                            last_refresh_number_old,
                            last_refresh_number_new,
                            last_update_date,
                            last_updated_by,
			    use_for_comparison,
			    bucket_type_new,
			    bucket_type_old,
                            dmltype)
                            values ( msc_sup_dem_history_s.nextval,
                                     :old.plan_id,
                                     :old.transaction_id,
                                     :old.publisher_name,
                                     :old.publisher_site_name,
                                     :old.publisher_order_type,
                                     :old.publisher_order_type_desc,
                                     :old.item_name,
                                     :old.item_description,
                                     :old.owner_item_name,
                                     :old.owner_item_description,
                                     :old.supplier_item_name,
                                     :old.supplier_item_description,
                                     :old.customer_item_name,
                                     :old.customer_item_description,
                                     :old.customer_name,
                                     :old.customer_site_name,
                                     :old.supplier_name,
                                     :old.supplier_site_name,
                                     :old.order_number,
                                     :old.line_number,
                                     :old.release_number,
                                     :old.end_order_number,
                                     :old.end_order_line_number,
                                     :old.end_order_rel_number,
                                     :old.designator,
                                     null,
                                     :old.version,
                                     null,
                                     :old.quantity,
                                     null,
                                     :old.comments,
                                     null,
                                     :old.key_date,
                                     null,
                                     :old.ship_date,
                                     null,
                                     :old.receipt_date,
                                     null,
                                     :old.new_schedule_date,
                                     null,
                                     :old.new_order_placement_date,
                                     null,
                                     :old.original_promised_date,
                                     null,
                                     :old.request_date,
                                     null,
                                     :old.planned_wip_start_date,
                                     null,
                                     :old.planned_wip_end_date,
                                     null,
                                     :old.wip_start_date,
                                     null,
                                     :old.wip_end_date,
                                     null,
                                     :old.last_refresh_number,
                                     null,
                                     :old.last_update_date,
                                     :old.last_updated_by,
				     2,
				     null,
				     :old.bucket_type,
                                     'D');


   elsif UPDATING then



	begin
       /* Bug # 4252144  */
        if :old.publisher_order_type in (1,2,3 )  then
	    update msc_sup_dem_history
	    set use_for_comparison = 2
	    where item_name = :old.item_name
	      and plan_id = :old.plan_id
	      and publisher_order_type = :old.publisher_order_type
	      and supplier_name = :old.supplier_name
	      and supplier_site_name = :old.supplier_site_name
	      and customer_name = :old.customer_name
	      and customer_site_name = :old.customer_site_name
	     -- and nvl(designator_new,'-99999') = nvl(:old.designator,'-99999')
	      and nvl(version_new,'-99999') = nvl(:old.version,'-99999')
	      and nvl(version_new,'-99999') = nvl(:new.version,'-99999')
	      and trunc(key_date_new) = trunc(:old.key_date)
	      and bucket_type_new = :old.bucket_type;
      end if  ;
    exception
	   when others then
	       null;
	end;


        insert into msc_sup_dem_history (
                            history_id,
                            plan_id,
                            transaction_id,
                            publisher_name,
                            publisher_site_name,
                            publisher_order_type,
                            publisher_order_type_desc,
                            item_name,
                            item_description,
                            owner_item_name,
                            owner_item_description,
                            supplier_item_name,
                            supplier_item_description,
                            customer_item_name,
                            customer_item_description,
                            customer_name,
                            customer_site_name,
                            supplier_name,
                            supplier_site_name,
                            order_number,
                            line_number,
                            release_number,
                            end_order_number,
                            end_order_line_number,
                            end_order_rel_number,
                            designator_old,
                            designator_new,
                            version_old,
                            version_new,
                            quantity_old,
                            quantity_new,
                            comments_old,
                            comments_new,
                            key_date_old,
                            key_date_new,
                            ship_date_old,
                            ship_date_new,
                            receipt_date_old,
                            receipt_date_new,
                            new_schedule_date_old,
                            new_schedule_date_new,
                            new_order_placement_date_old,
                            new_order_placement_date_new,
                            original_promised_date_old,
                            original_promised_date_new,
                            request_date_old,
                            request_date_new,
                            planned_wip_start_date_old,
                            planned_wip_start_date_new,
                            planned_wip_end_date_old,
                            planned_wip_end_date_new,
                            wip_start_date_old,
                            wip_start_date_new,
                            wip_end_date_old,
                            wip_end_date_new,
                            last_refresh_number_old,
                            last_refresh_number_new,
                            last_update_date,
                            last_updated_by,
			    use_for_comparison,
			    bucket_type_new,
			    bucket_type_old,
                            dmltype)
                            values ( msc_sup_dem_history_s.nextval,
                                     :new.plan_id,
                                     :new.transaction_id,
                                     :new.publisher_name,
                                     :new.publisher_site_name,
                                     :new.publisher_order_type,
                                     :new.publisher_order_type_desc,
                                     :new.item_name,
                                     :new.item_description,
                                     :new.owner_item_name,
                                     :new.owner_item_description,
                                     :new.supplier_item_name,
                                     :new.supplier_item_description,
                                     :new.customer_item_name,
                                     :new.customer_item_description,
                                     :new.customer_name,
                                     :new.customer_site_name,
                                     :new.supplier_name,
                                     :new.supplier_site_name,
                                     :new.order_number,
                                     :new.line_number,
                                     :new.release_number,
                                     :new.end_order_number,
                                     :new.end_order_line_number,
                                     :new.end_order_rel_number,
                                     :old.designator,
                                     :new.designator,
                                     :old.version,
                                     :new.version,
                                     :old.quantity,
                                     :new.quantity,
                                     :old.comments,
                                     :new.comments,
                                     :old.key_date,
                                     :new.key_date,
                                     :old.ship_date,
                                     :new.ship_date,
                                     :old.receipt_date,
                                     :new.receipt_date,
                                     :old.new_schedule_date,
                                     :new.new_schedule_date,
                                     :old.new_order_placement_date,
                                     :new.new_order_placement_date,
                                     :old.original_promised_date,
                                     :new.original_promised_date,
                                     :old.request_date,
                                     :new.request_date,
                                     :old.planned_wip_start_date,
                                     :new.planned_wip_start_date,
                                     :old.planned_wip_end_date,
                                     :new.planned_wip_end_date,
                                     :old.wip_start_date,
                                     :new.wip_start_date,
                                     :old.wip_end_date,
                                     :new.wip_end_date,
                                     :old.last_refresh_number,
                                     :new.last_refresh_number,
                                     :new.last_update_date,
                                     :new.last_updated_by,
				     1,
				     :new.bucket_type,
				     :old.bucket_type,
                                     'U');


   end if;


end;


/
ALTER TRIGGER "APPS"."MSC_TRG_AUDIT" ENABLE;
