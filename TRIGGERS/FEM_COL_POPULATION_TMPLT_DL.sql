--------------------------------------------------------
--  DDL for Trigger FEM_COL_POPULATION_TMPLT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COL_POPULATION_TMPLT_DL" 
/* $Header: fem_col_pop_tmp.sql 120.0 2005/06/06 20:23:54 appldev noship $
*=======================================================================+
|            Copyright (c) 1996-2005  Oracle Corporation                |
|                       Redwood Shores, CA, USA                         |
|                         All rights reserved.                          |
+=======================================================================+
| TRIGGERNAME                                                           |
|     FEM_COL_POPULATION_TMPLT_DL                                       |
|                                                                       |
+======================================================================*/
instead of delete on FEM_COL_POPULATION_TMPLT_VL
referencing old as NA
for each row
begin
  FEM_COL_POPULATION_TMPLT_PKG.DELETE_ROW(
    X_COL_POP_TEMPLT_OBJ_DEF_ID => :NA.COL_POP_TEMPLT_OBJ_DEF_ID,
    X_SOURCE_TABLE_NAME => :NA.SOURCE_TABLE_NAME,
    X_TARGET_COLUMN_NAME => :NA.TARGET_COLUMN_NAME,
    X_TARGET_TABLE_NAME => :NA.TARGET_TABLE_NAME);
END FEM_COL_POPULATION_TMPLT_DL;


/
ALTER TRIGGER "APPS"."FEM_COL_POPULATION_TMPLT_DL" ENABLE;
