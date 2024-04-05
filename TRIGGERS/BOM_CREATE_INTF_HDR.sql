--------------------------------------------------------
--  DDL for Trigger BOM_CREATE_INTF_HDR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_CREATE_INTF_HDR" 
AFTER INSERT
ON    "BOM"."BOM_INVENTORY_COMPS_INTERFACE"
FOR   EACH ROW
/* $Header: BOMTBICI.sql 120.4 2006/05/16 04:40:45 dikrishn noship $ */
DECLARE
    l_reccount number;
    l_assembly_item_id 	number := :new.assembly_item_id;
    l_organization_id 	number := :new.organization_id;
    l_bill_sequence_id	number := :new.bill_sequence_id;
    l_alternate		varchar2(10) := :new.alternate_bom_designator;
    l_process_flag	number := :new.process_flag;
    l_assembly_item	varchar2(240) := :new.assembly_item_number;
    l_organization_code	varchar2(3) := :new.organization_code;
    l_batch_id NUMBER := :new.batch_id;
 BEGIN
   Insert into
   bom_bill_of_mtls_interface
   (
	  ASSEMBLY_ITEM_ID
         ,ORGANIZATION_ID
         ,ORGANIZATION_CODE
         ,ITEM_NUMBER
         ,BILL_SEQUENCE_ID
         ,ALTERNATE_BOM_DESIGNATOR
         ,PROCESS_FLAG
         ,TRANSACTION_TYPE
         ,BATCH_ID
    )
   select  l_ASSEMBLY_ITEM_ID
    	  ,l_ORGANIZATION_ID
    	  ,l_ORGANIZATION_CODE
    	  ,l_ASSEMBLY_ITEM
    	  ,l_BILL_SEQUENCE_ID
    	  ,l_ALTERNATE
    	  ,l_PROCESS_FLAG
    	  ,'NO_OP'
          ,l_BATCH_ID
      from dual
     where ( ( :new.bill_sequence_id is not null and
	       not exists ( select bill_sequence_id
		  	       from bom_bill_of_mtls_interface
			      where bill_sequence_id = :new.bill_sequence_id
				and ( process_flag = 1 or
				      process_flag = 7 or
                                      process_flag = 5 or
				      process_flag = l_PROCESS_FLAG
				     )
                               and (batch_id = :new.batch_id or batch_id is null)
			    )
	      )
	      OR
	      (:new.assembly_item_id is not null and
               :new.organization_id is not null and
               not exists ( select bill_sequence_id
	                     from bom_bill_of_mtls_interface
			    where assembly_item_id = :new.assembly_item_id
			      and organization_id = :new.organization_id
			      and nvl(alternate_bom_designator,'xxxx')  =
			          nvl(:new.alternate_bom_designator,'xxxx')
			      and (process_flag = 1 or
				   process_flag = 7 or
                                   process_flag = 5 or
				   process_flag = l_PROCESS_FLAG
				  )
                              and (batch_id = :new.batch_id or batch_id is null)
			  )
		)
		OR
		(
		   :new.assembly_item_number is not null and
		   :new.organization_code is not null and
		    not exists ( select bill_sequence_id
	                     from bom_bill_of_mtls_interface
			    where item_number = :new.assembly_item_number
			      and organization_code = :new.organization_code
			      and nvl(alternate_bom_designator,'xxxx')  =
			          nvl(:new.alternate_bom_designator,'xxxx')
			      and (process_flag = 1 or
				   process_flag = 7 or
                                   process_flag = 5 or
				   process_flag = l_PROCESS_FLAG
				  )
                              and (batch_id = :new.batch_id or batch_id is null)
				)
		  )
	       );
    END ;


/
ALTER TRIGGER "APPS"."BOM_CREATE_INTF_HDR" ENABLE;
