--------------------------------------------------------
--  DDL for Trigger GML_OP_ORDR_TYP_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GML_OP_ORDR_TYP_T3" 
instead of delete on OP_ORDR_TYP_VL
referencing old as OP_ORDR_TYP
for each row

begin
  GML_OP_ORDR_TYP_PKG.DELETE_ROW(
    X_ORDER_TYPE => :OP_ORDR_TYP.ORDER_TYPE);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GML_OP_ORDR_TYP_T3" ENABLE;
