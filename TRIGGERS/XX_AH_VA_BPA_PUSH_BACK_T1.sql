--------------------------------------------------------
--  DDL for Trigger XX_AH_VA_BPA_PUSH_BACK_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XX_AH_VA_BPA_PUSH_BACK_T1" 
  AFTER INSERT OR UPDATE ON ONT.OE_BLANKET_HEADERS_ALL
REFERENCING OLD AS OLD
            NEW AS NEW
  FOR EACH ROW
DECLARE
  l_po_header_new   po_headers_all.po_header_id%TYPE;
  l_po_header_old  po_headers_all.po_header_id%TYPE;
BEGIN
  l_po_header_new := :NEW.ATTRIBUTE4;
  l_po_header_old :=  :OLD.ATTRIBUTE4;

  IF l_po_header_new IS NOT NULL
  THEN
     UPDATE PO.PO_HEADERS_ALL BPA
     SET BPA.ATTRIBUTE2 = (SELECT LISTAGG(VA.ORDER_NUMBER, ',')
                          WITHIN GROUP (ORDER BY VA.ORDER_NUMBER)
                          FROM OE_BLANKET_HEADERS_V VA
                          WHERE VA.ATTRIBUTE4 = l_po_header_new)
     WHERE BPA.PO_HEADER_ID = l_po_header_new;
  END IF;

  IF l_po_header_old IS NOT NULL
  THEN
     UPDATE PO.PO_HEADERS_ALL BPA
     SET BPA.ATTRIBUTE2 = (SELECT LISTAGG(VA.ORDER_NUMBER, ',')
                          WITHIN GROUP (ORDER BY VA.ORDER_NUMBER)
                          FROM OE_BLANKET_HEADERS_V VA
                          WHERE VA.ATTRIBUTE4 = l_po_header_old)
     WHERE BPA.PO_HEADER_ID = l_po_header_old;
  END IF;

end xx_ah_va_bpa_push_back_t1;

/
ALTER TRIGGER "APPS"."XX_AH_VA_BPA_PUSH_BACK_T1" ENABLE;
