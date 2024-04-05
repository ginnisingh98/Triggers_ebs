--------------------------------------------------------
--  DDL for Trigger SY_REAS_CDS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SY_REAS_CDS_DL" 
instead of delete on SY_REAS_CDS_VL
referencing old as SY_REAS_CDS
for each row
begin
  SY_REAS_CDS_PKG.DELETE_ROW(
    X_REASON_CODE => :SY_REAS_CDS.REASON_CODE);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."SY_REAS_CDS_DL" ENABLE;
