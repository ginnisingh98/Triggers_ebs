--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T4_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T4_BOM" 

/* $Header: BOMPFIT4.sql 115.1 99/07/16 05:15:19 porting shi $ */

AFTER UPDATE
OF BOM_ITEM_TYPE, PRODUCT_FAMILY_ITEM_ID
ON "INV"."MTL_SYSTEM_ITEMS_B"


DECLARE
   l_return_sts		NUMBER		:=  0	 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
BEGIN
   FND_MESSAGE.CLEAR;

   ------------------------------------------------------
   -- Check if any category creations have been recorded.
   ------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Cat_Create_Num > 0 ) THEN

      BOM_PFI_PVT.Create_PF_Category
		(  p_return_sts		=>	l_return_sts			,
		   p_return_err		=>	l_return_err			,
		   p_Cat_Create_Num	=>	BOM_PFI_PVT.G_Cat_Create_Num	,
		   p_Create_Cat_Tbl	=>	BOM_PFI_PVT.G_Create_Cat_Tbl
		);
   END IF;

   --------------------------------------------------------------------------
   -- Check if any item assignments have been recorded (there might have been
   -- removals only from product family which update PRODUCT_FAMILY_ITEM_ID
   -- column too).
   --------------------------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Assign_Num > 0 ) THEN

      ------------------------------------------------------------------
      -- Perform each item assignment that has been recorded by the call
      -- to Store_Cat_Assign in the row-level trigger.
      ------------------------------------------------------------------

      BOM_PFI_PVT.Assign_To_Category
		(  p_return_sts		=>	l_return_sts			,
		   p_return_err		=>	l_return_err			,
		   p_Assign_Num		=>	BOM_PFI_PVT.G_Assign_Num	,
		   p_Cat_Assign_Tbl	=>	BOM_PFI_PVT.G_Cat_Assign_Tbl
		);
   END IF;

   ------------------------------------------------------
   -- Check if any category deletions have been recorded.
   ------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Cat_Num > 0 ) THEN

      --------------------------------------------------------------------
      -- Perform each category deletion that has been recorded by the call
      -- to Store_Category in the row-level trigger.
      ---------------------------------------------------------------------

      BOM_PFI_PVT.Delete_PF_Category
		(  p_return_sts		=>	l_return_sts			,
		   p_return_err		=>	l_return_err			,
		   p_Cat_Num		=>	BOM_PFI_PVT.G_Cat_Num		,
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
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T4_BOM" ENABLE;
