--------------------------------------------------------
--  DDL for Trigger GMD_GRADES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_GRADES_DL" 
/* $Header: GMDGRDTG.sql 115.0 2002/03/12 13:06:21 pkm ship        $ */
instead of delete on GMD_GRADES_VL
referencing old as QC_GRAD_MST
for each row

begin
  GMD_GRADES_PKG.DELETE_ROW(
    X_QC_GRADE => :QC_GRAD_MST.QC_GRADE);
end DELETE_ROW;



/
ALTER TRIGGER "APPS"."GMD_GRADES_DL" ENABLE;
