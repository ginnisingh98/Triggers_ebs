--------------------------------------------------------
--  DDL for Trigger PFT_VAL_INDEX_FORMULA_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PFT_VAL_INDEX_FORMULA_IL" 
/* $Header: PFTVALINDEX.sql 120.0 2005/10/19 19:17:58 appldev noship $
*=======================================================================+
|            Copyright (c) 1996-2005  Oracle Corporation                |
|                       Redwood Shores, CA, USA                         |
|                         All rights reserved.                          |
+=======================================================================+
| TRIGGERNAME                                                           |
|     PFT_VAL_INDEX_FORMULA_IL                                          |
|                                                                       |
+======================================================================*/
INSTEAD OF insert ON PFT_VAL_INDEX_FORMULA_VL
REFERENCING NEW AS PFT_VAL_IND
FOR EACH ROW
DECLARE
  row_id rowid;
BEGIN
  PFT_VAL_INDEX_FORMULA_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_VALUE_INDEX_FORMULA_ID => :PFT_VAL_IND.VALUE_INDEX_FORMULA_ID,
    X_OBJECT_VERSION_NUMBER => :PFT_VAL_IND.OBJECT_VERSION_NUMBER,
    X_DISPLAY_NAME => :PFT_VAL_IND.DISPLAY_NAME,
    X_DESCRIPTION => :PFT_VAL_IND.DESCRIPTION,
    X_CREATION_DATE => :PFT_VAL_IND.CREATION_DATE,
    X_CREATED_BY => :PFT_VAL_IND.CREATED_BY,
    X_LAST_UPDATE_DATE => :PFT_VAL_IND.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :PFT_VAL_IND.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :PFT_VAL_IND.LAST_UPDATE_LOGIN);
END PFT_VAL_INDEX_FORMULA_IL;


/
ALTER TRIGGER "APPS"."PFT_VAL_INDEX_FORMULA_IL" ENABLE;
