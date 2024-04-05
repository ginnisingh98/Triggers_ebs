--------------------------------------------------------
--  DDL for Trigger FEM_COL_POPULATION_TMPLT_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COL_POPULATION_TMPLT_UL" 
/* $Header: fem_col_pop_tmp.sql 120.0 2005/06/06 20:23:54 appldev noship $
*=======================================================================+
|            Copyright (c) 1996-2005  Oracle Corporation                |
|                       Redwood Shores, CA, USA                         |
|                         All rights reserved.                          |
+=======================================================================+
| TRIGGERNAME                                                           |
|     FEM_COL_POPULATION_TMPLT_UL                                       |
|                                                                       |
+======================================================================*/
instead of update on FEM_COL_POPULATION_TMPLT_VL
referencing new as NA
for each row
begin
  FEM_COL_POPULATION_TMPLT_PKG.UPDATE_ROW(
    X_COL_POP_TEMPLT_OBJ_DEF_ID => :NA.COL_POP_TEMPLT_OBJ_DEF_ID,
    X_SOURCE_TABLE_NAME => :NA.SOURCE_TABLE_NAME,
    X_TARGET_COLUMN_NAME => :NA.TARGET_COLUMN_NAME,
    X_TARGET_TABLE_NAME => :NA.TARGET_TABLE_NAME,
    X_DATA_POPULATION_METHOD_CODE => :NA.DATA_POPULATION_METHOD_CODE,
    X_SOURCE_COLUMN_NAME => :NA.SOURCE_COLUMN_NAME,
    X_DIMENSION_ID => :NA.DIMENSION_ID,
    X_ATTRIBUTE_ID => :NA.ATTRIBUTE_ID,
    X_ATTRIBUTE_VERSION_ID => :NA.ATTRIBUTE_VERSION_ID,
    X_AGGREGATION_METHOD => :NA.AGGREGATION_METHOD,
    X_CONSTANT_NUMERIC_VALUE => :NA.CONSTANT_NUMERIC_VALUE,
    X_CONSTANT_ALPHANUMERIC_VALUE => :NA.CONSTANT_ALPHANUMERIC_VALUE,
    X_CONSTANT_DATE_VALUE => :NA.CONSTANT_DATE_VALUE,
    X_OBJECT_VERSION_NUMBER => :NA.OBJECT_VERSION_NUMBER,
    X_SYSTEM_RESERVED_FLAG => :NA.SYSTEM_RESERVED_FLAG,
    X_ENG_PROC_PARAM => :NA.ENG_PROC_PARAM,
    X_PARAMETER_FLAG => :NA.PARAMETER_FLAG,
    X_DESCRIPTION => :NA.DESCRIPTION,
    X_LAST_UPDATE_DATE => :NA.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :NA.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :NA.LAST_UPDATE_LOGIN);
END FEM_COL_POPULATION_TMPLT_UL;


/
ALTER TRIGGER "APPS"."FEM_COL_POPULATION_TMPLT_UL" ENABLE;
