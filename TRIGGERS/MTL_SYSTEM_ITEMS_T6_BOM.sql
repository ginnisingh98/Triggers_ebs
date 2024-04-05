--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T6_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T6_BOM" 

/* $Header: BOMPFIT6.sql 115.1 99/07/16 05:15:25 porting shi $ */

AFTER INSERT
ON "INV"."MTL_SYSTEM_ITEMS_B"


DECLARE
   l_return_sts		NUMBER		:=  0	 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
BEGIN

   -----------------------------------------------------------------------
   -- Check if any category creations have been recorded (there might have
   -- been only creations of items that are not product family items).
   -----------------------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Cat_Create_Num > 0 ) THEN
      FND_MESSAGE.CLEAR;

      ---------------------------------------------------------------------
      -- Perform each category creation that has been recorded by the call
      -- to Store_Cat_Create procedure in the row-level trigger.
      ---------------------------------------------------------------------

      BOM_PFI_PVT.Create_PF_Category
		(  p_return_sts		=>	l_return_sts			,
		   p_return_err		=>	l_return_err			,
		   p_Cat_Create_Num	=>	BOM_PFI_PVT.G_Cat_Create_Num	,
		   p_Create_Cat_Tbl	=>	BOM_PFI_PVT.G_Create_Cat_Tbl
		);
   END IF;

   ---------------------------------------------------------------------
   -- Check if any item assignments of product family items to their own
   -- categories have been recorded.
   ---------------------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Assign_Num > 0 ) THEN
      FND_MESSAGE.CLEAR;

      BOM_PFI_PVT.Assign_To_Category
		(  p_return_sts		=>	l_return_sts			,
		   p_return_err		=>	l_return_err			,
		   p_Assign_Num		=>	BOM_PFI_PVT.G_Assign_Num	,
		   p_Cat_Assign_Tbl	=>	BOM_PFI_PVT.G_Cat_Assign_Tbl
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
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T6_BOM" ENABLE;
