--------------------------------------------------------
--  DDL for Trigger GML_OP_ORDR_STS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GML_OP_ORDR_STS_T3" 
/* $Header: GMLOS3TG.sql 115.3 1999/11/10 12:48:23 pkm ship   $ */
instead of delete on OP_ORDR_STS_VL
referencing old as OP_ORDR_STS
for each row

begin
  GML_OP_ORDR_STS_PKG.DELETE_ROW(
    X_ORDER_STATUS => :OP_ORDR_STS.ORDER_STATUS);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GML_OP_ORDR_STS_T3" ENABLE;
