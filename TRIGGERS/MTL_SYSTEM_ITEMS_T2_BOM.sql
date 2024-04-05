--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T2_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T2_BOM" 

/* $Header: BOMPFIT2.sql 115.1 99/07/16 05:15:12 porting shi $ */

BEFORE DELETE
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW

    WHEN ( old.BOM_ITEM_TYPE = 5 ) DECLARE
   l_return_sts		NUMBER			 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
BEGIN
   FND_MESSAGE.CLEAR;

   BOM_PFI_PVT.Check_PF_Segs;

   IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_Undefined )
   THEN
      FND_MESSAGE.set_name('INV', 'INV_BOM_PFI_SEGS_UNDEFINED');
      APP_EXCEPTION.RAISE_EXCEPTION;
   END IF;

   -------------------------------------------------------------------
   -- Remove product family item from its own category in a given org.
   -------------------------------------------------------------------

   BOM_PFI_PVT.Remove_From_Category
	(  p_return_sts		=>	l_return_sts		,
	   p_return_err		=>	l_return_err		,
	   p_item_id		=>	:old.INVENTORY_ITEM_ID	,
   	   p_org_id		=>	:old.ORGANIZATION_ID
	);

   --------------------------------------------------------------
   -- Store category for deletion if master item is being deleted
   --------------------------------------------------------------

   IF  BOM_PFI_PVT.Org_Is_Master( p_org_id  => :old.ORGANIZATION_ID )
   THEN
      BOM_PFI_PVT.Store_Category
	( 	p_return_sts		=>	l_return_sts		,
		p_return_err		=>	l_return_err		,
		p_item_id		=>	:old.INVENTORY_ITEM_ID	,
		p_org_id		=>	:old.ORGANIZATION_ID	,
		p_Cat_Num		=>	BOM_PFI_PVT.G_Cat_Num	,
		p_Delete_Cat_Tbl	=>	BOM_PFI_PVT.G_Delete_Cat_Tbl
	);
   END IF;


EXCEPTION
   WHEN OTHERS THEN
      IF ( SQLCODE = -20001 ) THEN
         APP_EXCEPTION.RAISE_EXCEPTION;
      ELSE
         RAISE;
      END IF;

END;



/
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T2_BOM" ENABLE;
