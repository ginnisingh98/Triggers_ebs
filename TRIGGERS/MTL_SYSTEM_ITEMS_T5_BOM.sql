--------------------------------------------------------
--  DDL for Trigger MTL_SYSTEM_ITEMS_T5_BOM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T5_BOM" 

/* $Header: BOMPFIT5.sql 115.1 99/07/16 05:15:22 porting shi $ */

AFTER DELETE
ON "INV"."MTL_SYSTEM_ITEMS_B"


DECLARE
   l_return_sts		NUMBER		:=  0	 ;
   l_return_err		VARCHAR2(2000)  :=  NULL ;
BEGIN

   -----------------------------------------------------------------------
   -- Check if any category deletions have been recorded (there might have
   -- been only deletions of items that are not product family items).
   -----------------------------------------------------------------------

   IF ( BOM_PFI_PVT.G_Cat_Num > 0 ) THEN
      FND_MESSAGE.CLEAR;

      ---------------------------------------------------------------------
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
ALTER TRIGGER "APPS"."MTL_SYSTEM_ITEMS_T5_BOM" ENABLE;
