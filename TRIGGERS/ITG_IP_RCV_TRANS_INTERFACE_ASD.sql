--------------------------------------------------------
--  DDL for Trigger ITG_IP_RCV_TRANS_INTERFACE_ASD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_RCV_TRANS_INTERFACE_ASD" 
  AFTER DELETE
  ON "PO"."RCV_TRANSACTIONS_INTERFACE"
DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
  requestId NUMBER := nvl(FND_GLOBAL.conc_request_id, -1);

  CURSOR getRowCount IS
    SELECT COUNT(*) rowCount
    FROM   rcv_transactions_interface i
    WHERE  i.processing_status_code  = 'RUNNING'
    AND    i.processing_request_id    = requestId;
  rowCount number := 1;

  CURSOR getHeaders IS
    SELECT DISTINCT
	   t.shipment_header_id,
	   t.po_header_id,
	   t.transaction_id,
	   t.destination_type_code,
	   t.transaction_type,
	   h.receipt_num,
	   l.line_num
    FROM   rcv_transactions     t,
	   rcv_shipment_headers h,
	   rcv_shipment_lines   l
    WHERE  t.request_id = requestId
    AND    (   (    t.transaction_type = 'DELIVER'
                AND t.destination_type_code IN ('INVENTORY', 'EXPENSE')
               )
           OR  (    t.destination_type_code = 'RECEIVING'
                AND t.transaction_type IN ('CORRECT', 'RETURN TO VENDOR')
               )
           )
    AND    t.shipment_header_id = h.shipment_header_id
    AND    t.shipment_line_id   = l.shipment_line_id;

  CURSOR getOrgId (p_poHeaderId NUMBER) IS
    SELECT org_id
    FROM   po_headers_all
    WHERE  po_header_id = p_poHeaderId;

  l_orgid  po_headers_all.org_id%TYPE;
  l_clntyp VARCHAR2(30);
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_rcv_trans_interface_ASD');
  ITG_Debug.msg('RTI', 'requestId', requestId);

  IF requestId > 0 THEN
    -- Is this request id completed?
    OPEN  getRowCount;
    FETCH getRowCount INTO rowCount;
    CLOSE getRowCount;
    ITG_Debug.msg('RTI', 'rowCount', rowCount);

    -- Only submit if there are no more interface rows for this request
    IF rowCount = 0 THEN
      -- Submit an XML outbound BSR for each header
      FOR h IN getHeaders LOOP

        -- need to get the org id from the po_headers_all table
        OPEN  getOrgId(h.po_header_id);
       	FETCH getOrgId INTO l_orgid;
        CLOSE getOrgId;

    IF h.transaction_type = 'DELIVER' THEN
	  l_clntyp := 'ITG_UPD_REC';
    ELSIF h.transaction_type = 'CORRECT' THEN
      l_clntyp := 'ITG_UPD_ADJ';
	ELSE
	  l_clntyp := 'ITG_UPD_RET';
	END IF;

        itg_outbound_utils.raise_wf_event(
          p_bsr    => 'UPDATE_DELIVERY',
          p_id     => h.shipment_header_id,
          p_org    => l_orgid,
	  p_doctyp => 'ITG_UPD',
	  p_clntyp => l_clntyp,
	  p_doc    => h.receipt_num||':'||to_char(h.line_num),
          p_param1 => to_char(requestId),
	  p_param2 => to_char(h.transaction_id));
      END LOOP;
    END IF;
  END IF;

  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_RCV_TRANS_INTERFACE_ASD" DISABLE;
