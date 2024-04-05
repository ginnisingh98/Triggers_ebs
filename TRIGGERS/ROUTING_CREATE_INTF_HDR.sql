--------------------------------------------------------
--  DDL for Trigger ROUTING_CREATE_INTF_HDR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ROUTING_CREATE_INTF_HDR" 
AFTER INSERT
ON    "BOM"."BOM_OP_SEQUENCES_INTERFACE"
FOR   EACH ROW

DECLARE
    l_reccount number;
    l_assembly_item_id	   number        := :new.assembly_item_id;
    l_organization_id      number        := :new.organization_id;
    l_routing_sequence_id  number        := :new.routing_sequence_id;
    l_alternate            varchar2(10)  := :new.alternate_routing_designator;
    l_process_flag         number        := :new.process_flag;
    l_assembly_item        varchar2(240) := :new.assembly_item_number;
    l_organization_code    varchar2(3)   := :new.organization_code;
	-- added for bug fix 7187162(Patch 7597120)
    l_batch_id NUMBER := :new.batch_id;
 BEGIN
   Insert into
   bom_op_routings_interface
   (
          ASSEMBLY_ITEM_ID
         ,ORGANIZATION_ID
         ,ORGANIZATION_CODE
         ,ASSEMBLY_ITEM_NUMBER
         ,ROUTING_SEQUENCE_ID
         ,ALTERNATE_ROUTING_DESIGNATOR
         ,PROCESS_FLAG
         ,TRANSACTION_TYPE
		 ,BATCH_ID
    )
   select  l_ASSEMBLY_ITEM_ID
          ,l_ORGANIZATION_ID
          ,l_ORGANIZATION_CODE
          ,l_ASSEMBLY_ITEM
          ,l_ROUTING_SEQUENCE_ID
          ,l_ALTERNATE
          ,l_PROCESS_FLAG
          ,'NO_OP'
		  ,l_BATCH_ID
   from dual
   where ( ( :new.routing_sequence_id is not null and
               not exists ( select routing_sequence_id
                            from bom_op_routings_interface
                            where routing_sequence_id = :new.routing_sequence_id
                            and ( process_flag = 1 or
				  process_flag = 7 or
				  process_flag = l_PROCESS_FLAG
				)
			-- added for bug fix 7187162(Patch 7597120)
			and (batch_id = :new.batch_id or batch_id is null)
			    )
              )
              OR
              (:new.assembly_item_id is not null and
               :new.organization_id is not null and
               not exists ( select routing_sequence_id
                             from bom_op_routings_interface
                             where assembly_item_id = :new.assembly_item_id
                             and organization_id = :new.organization_id
                             and nvl(alternate_routing_designator,'xxxx')  =
                                              nvl(:new.alternate_routing_designator,'xxxx')
                             and ( process_flag = 1 or
				   process_flag = 7 or
				   process_flag = l_PROCESS_FLAG
				 )
				  -- added for bug fix 7187162(Patch 7597120)
				  and (batch_id = :new.batch_id or batch_id is null)

			)
                )
                OR
                (
                   :new.assembly_item_number is not null and
                   :new.organization_code is not null and
                    not exists ( select routing_sequence_id
                                 from  bom_op_routings_interface
                                 where assembly_item_number  = :new.assembly_item_number
                                 and   organization_code     = :new.organization_code
                                 and nvl(alternate_routing_designator,'xxxx')  =
                                               nvl(:new.alternate_routing_designator,'xxxx')
                                 and ( process_flag = 1 or
				       process_flag = 7 or
				       process_flag = l_PROCESS_FLAG
                                     )
					-- added for bug fix 7187162(Patch 7597120)
					and (batch_id = :new.batch_id or batch_id is null)
				)
                )
	 );
    END ;

/
ALTER TRIGGER "APPS"."ROUTING_CREATE_INTF_HDR" ENABLE;
