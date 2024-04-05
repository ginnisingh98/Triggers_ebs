--------------------------------------------------------
--  DDL for Trigger XXAH_OBH_BIR_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_OBH_BIR_T1" 
   BEFORE INSERT OR UPDATE ON ONT.OE_BLANKET_HEADERS_ALL
REFERENCING OLD AS OLD
             NEW AS NEW
   FOR EACH ROW
DECLARE
   CURSOR c_ttt(b_type_id oe_transaction_types_tl.transaction_type_id%TYPE) IS
   SELECT upper(name) name
   FROM   oe_transaction_types_tl ttt
   WHERE  ttt.transaction_type_id = b_type_id
   AND    ttt.language = 'US'
   ;
   CURSOR c_ble(b_header_id oe_blanket_lines_all.header_id%TYPE) IS
   SELECT ble.order_number
   FROM   oe_blanket_lines_all bla
   ,      oe_blanket_lines_ext ble
   WHERE  bla.source_document_line_id = ble.line_id
   AND    bla.header_id = b_header_id
   ;
   v_type oe_transaction_types_tl.name%TYPE;
   v_order_number oe_blanket_lines_ext.order_number%TYPE;
BEGIN
   OPEN c_ttt(:new.order_type_id);
   FETCH c_ttt INTO v_type;
   CLOSE c_ttt;
   IF v_type LIKE '%PROFORMA%' THEN
     IF :old.order_type_id <> :new.order_type_id AND :new.source_document_id IS NOT NULL THEN
       OPEN c_ble(:new.header_id);
       FETCH c_ble INTO v_order_number;
       CLOSE c_ble;
       :new.attribute12 := v_order_number;
     END IF;
   ELSE
     IF nvl(:new.attribute12,'-1') != :new.order_number THEN
       :new.attribute12 := :new.order_number;
     END IF;
   END IF;
END XXAH_OBH_BIR_T1;

/
ALTER TRIGGER "APPS"."XXAH_OBH_BIR_T1" ENABLE;
