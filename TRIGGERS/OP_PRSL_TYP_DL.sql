--------------------------------------------------------
--  DDL for Trigger OP_PRSL_TYP_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."OP_PRSL_TYP_DL" 
/* $Header: GMLPR3TG.sql 120.1 2005/08/15 11:21:02 rakulkar noship $ */
instead of delete on OP_PRSL_TYP_VL
referencing old as OP_PRSL_TYP
for each row
begin
  GML_OP_PRSL_TYP_PKG.DELETE_ROW(
    X_PRESALES_ORD_TYPE => :OP_PRSL_TYP.PRESALES_ORD_TYPE);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."OP_PRSL_TYP_DL" ENABLE;
