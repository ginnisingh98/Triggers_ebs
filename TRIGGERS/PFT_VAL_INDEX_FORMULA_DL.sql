--------------------------------------------------------
--  DDL for Trigger PFT_VAL_INDEX_FORMULA_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PFT_VAL_INDEX_FORMULA_DL" 
/* $Header: PFTVALINDEX.sql 120.0 2005/10/19 19:17:58 appldev noship $
*=======================================================================+
|            Copyright (c) 1996-2005  Oracle Corporation                |
|                       Redwood Shores, CA, USA                         |
|                         All rights reserved.                          |
+=======================================================================+
| TRIGGERNAME                                                           |
|     PFT_VAL_INDEX_FORMULA_DL                                          |
|                                                                       |
+======================================================================*/
INSTEAD OF delete ON PFT_VAL_INDEX_FORMULA_VL
referencing old as PFT_VAL_IND
FOR EACH ROW
BEGIN
  PFT_VAL_INDEX_FORMULA_PKG.DELETE_ROW(
    X_VALUE_INDEX_FORMULA_ID => :PFT_VAL_IND.VALUE_INDEX_FORMULA_ID);
END PFT_VAL_INDEX_FORMULA_DL;


/
ALTER TRIGGER "APPS"."PFT_VAL_INDEX_FORMULA_DL" ENABLE;
