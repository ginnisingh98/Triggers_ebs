--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T1_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T1_BOM" 

/* $Header: BOMPFIT1.sql 115.1 99/07/16 05:15:09 porting shi $ */

BEFORE INSERT
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW

    WHEN ( new.BOM_ITEM_TYPE = 5 ) DECLARE
   l_return_sts		NUMBER		:=  0	 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
BEGIN
   FND_MESSAGE.CLEAR;

   BOM_PFI_PVT.Check_PF_Segs;

   IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_OK )
   THEN

   -----------------------------------------------------
   -- Store item id for category creation if master item
   -- is being defined.
   -----------------------------------------------------

   IF  BOM_PFI_PVT.Org_Is_Master( p_org_id  => :new.ORGANIZATION_ID )
   THEN
      BOM_PFI_PVT.Store_Cat_Create
	( 	p_return_sts		=>	l_return_sts		,
		p_return_err		=>	l_return_err		,
		p_item_id		=>	:new.INVENTORY_ITEM_ID	,
		p_org_id		=>	:new.ORGANIZATION_ID	,
		p_Cat_Create_Num	=>	BOM_PFI_PVT.G_Cat_Create_Num ,
		p_Create_Cat_Tbl	=>	BOM_PFI_PVT.G_Create_Cat_Tbl
	);
   END IF; -- Org_Is_Master

   ----------------------------------------------------------------------
   -- Assign each product family item to its own category in a given org.
   ----------------------------------------------------------------------

   BOM_PFI_PVT.Store_Cat_Assign
	(  p_return_sts		=>  l_return_sts		,
	   p_return_err		=>  l_return_err		,
	   p_item_id		=>  :new.INVENTORY_ITEM_ID	,
   	   p_org_id		=>  :new.ORGANIZATION_ID	,
   	   p_pf_item_id		=>  :new.INVENTORY_ITEM_ID ,
	   p_Assign_Num		=>  BOM_PFI_PVT.G_Assign_Num	,
	   p_Cat_Assign_Tbl	=>  BOM_PFI_PVT.G_Cat_Assign_Tbl
	);

   END IF; -- PF_Segs_Status


EXCEPTION
   WHEN OTHERS THEN
      IF ( SQLCODE = -20001 ) THEN
         APP_EXCEPTION.RAISE_EXCEPTION;
      ELSE
         RAISE;
      END IF;

END;



/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T1_BOM" ENABLE;
