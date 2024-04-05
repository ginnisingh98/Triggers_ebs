--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T3_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T3_BOM" 

/* $Header: BOMPFIT3.sql 115.2 99/07/16 05:15:16 porting sh $ */

BEFORE UPDATE
OF BOM_ITEM_TYPE, PRODUCT_FAMILY_ITEM_ID
ON "INV"."MTL_SYSTEM_ITEMS_B"
FOR EACH ROW


DECLARE
   l_return_sts		NUMBER		:=  0	 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
   l_Org_Is_Master	BOOLEAN ;
BEGIN
   FND_MESSAGE.CLEAR;

   l_Org_Is_Master := BOM_PFI_PVT.Org_Is_Master( p_org_id => :new.ORGANIZATION_ID );

   -----------------------------------------------------------------------
   -- Product family category creation and deletion based on BOM Item Type
   -- attribute change.
   -- Store item id for category creation and deletion only if the item
   -- is master item.  However, assign/remove product family item to/from
   -- its own category for every given organization.
   -----------------------------------------------------------------------

   IF (:new.BOM_ITEM_TYPE = 5) and
      ( (:old.BOM_ITEM_TYPE <> 5) or (:old.BOM_ITEM_TYPE is NULL) )
   THEN

      BOM_PFI_PVT.Check_PF_Segs;

      IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_OK )
      THEN

      IF l_Org_Is_Master THEN

      -------------------------------------------------------------------------
      -- Record each product family item for creation of a corresponding
      -- category.  Actual creation takes place in the statement-level trigger.
      -------------------------------------------------------------------------

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

   ELSIF (:old.BOM_ITEM_TYPE = 5) and
         ( (:new.BOM_ITEM_TYPE <> 5) or (:new.BOM_ITEM_TYPE is NULL) )
   THEN

      BOM_PFI_PVT.Check_PF_Segs;

      IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_OK )
      THEN

      -------------------------------------------------------------------
      -- Remove product family item from its own category in a given org.
      -------------------------------------------------------------------

      BOM_PFI_PVT.Remove_From_Category
		(  p_return_sts		=>	l_return_sts		,
		   p_return_err		=>	l_return_err		,
		   p_item_id		=>	:old.INVENTORY_ITEM_ID	,
	   	   p_org_id		=>	:old.ORGANIZATION_ID
		);

      IF l_Org_Is_Master THEN

      ------------------------------------------------------------------------
      -- Record each product family item corresponding to a category to be
      -- deleted.  Actual deletion takes place in the statement-level trigger.
      ------------------------------------------------------------------------

       BOM_PFI_PVT.Store_Category
	( 	p_return_sts		=>	l_return_sts		,
		p_return_err		=>	l_return_err		,
		p_item_id		=>	:old.INVENTORY_ITEM_ID	,
		p_org_id		=>	:old.ORGANIZATION_ID	,
		p_Cat_Num		=>	BOM_PFI_PVT.G_Cat_Num	,
		p_Delete_Cat_Tbl	=>	BOM_PFI_PVT.G_Delete_Cat_Tbl
	);

      END IF; -- Org_Is_Master

      END IF; -- PF_Segs_Status

   END IF;

   -------------------------------------------------------------------------
   -- Assign or remove an item to/from category/category set based
   -- on PRODUCT_FAMILY_ITEM_ID column value.
   -- Configuration items need not be assigned to product family categories
   -- so make sure base item is null.
   -------------------------------------------------------------------------

   IF (:old.PRODUCT_FAMILY_ITEM_ID is not NULL) and
      ( (:new.PRODUCT_FAMILY_ITEM_ID <> :old.PRODUCT_FAMILY_ITEM_ID) or
        (:new.PRODUCT_FAMILY_ITEM_ID is NULL) )
      and (:old.BASE_ITEM_ID is NULL)
   THEN

      BOM_PFI_PVT.Check_PF_Segs;

      IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_OK )
      THEN

      BOM_PFI_PVT.Remove_From_Category
		(  p_return_sts		=>	l_return_sts		,
		   p_return_err		=>	l_return_err		,
		   p_item_id		=>	:old.INVENTORY_ITEM_ID	,
	   	   p_org_id		=>	:old.ORGANIZATION_ID
		);

      END IF; -- PF_Segs_Status

   END IF;

   IF (:new.PRODUCT_FAMILY_ITEM_ID is not NULL) and
      ( (:new.PRODUCT_FAMILY_ITEM_ID <> :old.PRODUCT_FAMILY_ITEM_ID) or
        (:old.PRODUCT_FAMILY_ITEM_ID is NULL) )
      and (:new.BASE_ITEM_ID is NULL)
   THEN

      BOM_PFI_PVT.Check_PF_Segs;

      IF ( BOM_PFI_PVT.PF_Segs_Status = BOM_PFI_PVT.G_PF_Segs_Status_OK )
      THEN

      ---------------------------------------------------------------------
      -- Record each item assignment to category/category set in the
      -- G_Cat_Assign_Tbl PL/SQL table inside BOM_PFI_PVT package.
      -- Do not read item's corresponding product family item key flexfield
      -- segments from MTL_SYSTEM_ITEMS_B now to avoid mutating table error.
      -- Actual assignment takes place in the statement-level trigger.
      ---------------------------------------------------------------------

      BOM_PFI_PVT.Store_Cat_Assign
		(  p_return_sts		=>  l_return_sts		,
		   p_return_err		=>  l_return_err		,
		   p_item_id		=>  :new.INVENTORY_ITEM_ID	,
	   	   p_org_id		=>  :new.ORGANIZATION_ID	,
	   	   p_pf_item_id		=>  :new.PRODUCT_FAMILY_ITEM_ID ,
		   p_Assign_Num		=>  BOM_PFI_PVT.G_Assign_Num	,
		   p_Cat_Assign_Tbl	=>  BOM_PFI_PVT.G_Cat_Assign_Tbl
		);

      END IF; -- PF_Segs_Status

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
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T3_BOM" ENABLE;
