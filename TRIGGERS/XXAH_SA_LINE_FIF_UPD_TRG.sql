--------------------------------------------------------
--  DDL for Trigger XXAH_SA_LINE_FIF_UPD_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_SA_LINE_FIF_UPD_TRG" 
AFTER UPDATE OF FLOW_STATUS_CODE
ON "ONT"."OE_ORDER_HEADERS_ALL"
REFERENCING OLD AS OLD
            NEW AS NEW
FOR EACH ROW
  WHEN (
OLD.FLOW_STATUS_CODE <> 'BOOKED'
AND NEW.FLOW_STATUS_CODE = 'BOOKED'
      ) DECLARE

    CURSOR c_oe_order_header(p_oe_header_id IN NUMBER)
    IS
    SELECT distinct ooha.blanket_number,ooha.header_id,oola.blanket_line_number,oola.Attribute12
    from
    oe_order_headers_all ooha,
    oe_order_lines_all    oola
    where ooha.header_id = oola.header_id
    AND ooha.header_id = p_oe_header_id
    AND oola.order_source_id = 0 ;

    CURSOR c_blanket_order_lines(p_blanket_number IN NUMBER,p_line_number in number)
    IS
    SELECT obla.line_id,obha.header_id
    from
    oe_blanket_headers_all obha,
    oe_blanket_lines_all obla
    where obha.header_id = obla.header_id
    AND NVL(obla.attribute10, 'X') <> 'Y'
    AND obha.order_number = p_blanket_number
    and obla.line_number=p_line_number;


PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
/**************************************************************************
* VERSION      : $Id$
* DESCRIPTION  : Update Sales Agreement Line's Attribute10 when sales order gets booked--Only for core from.
*
* Date        Authors           Change reference/Description
* ----------- ----------------- ----------------------------------
* 01-Mar-2017 Vema Reddy
*************************************************************************/

     FOR r_oe_order_header IN c_oe_order_header(:NEW.header_id)
            LOOP
                FOR r_blanket_order_lines in c_blanket_order_lines(r_oe_order_header.blanket_number,r_oe_order_header.blanket_line_number)
                        LOOP
                            BEGIN

                            UPDATE oe_blanket_lines_all
                            SET    attribute10 =r_oe_order_header.attribute12-- 'Y'
                            WHERE  header_id=r_blanket_order_lines.header_id
                            AND    line_id = r_blanket_order_lines.line_id;

                            EXCEPTION
                            WHEN OTHERS THEN
                            FND_FILE.PUT_LINE(FND_FILE.LOG,'+---------------------------------------------------------------------------+');
                            FND_FILE.PUT_LINE(FND_FILE.LOG,'Error update attribute10 '||SQLCODE||' -ERROR- '||SQLERRM);
                            FND_FILE.PUT_LINE(FND_FILE.LOG,'+---------------------------------------------------------------------------+');
                            end;

                        END LOOP;
            END LOOP;


COMMIT;

END XXAH_SA_LINE_FIF_UPD_TRG;

/
ALTER TRIGGER "APPS"."XXAH_SA_LINE_FIF_UPD_TRG" ENABLE;
