--------------------------------------------------------
--  DDL for Trigger ITG_IP_RCV_TRANSACTIONS_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_RCV_TRANSACTIONS_ARI" 
  AFTER INSERT
  ON "PO"."RCV_TRANSACTIONS"
  FOR EACH ROW
     WHEN (new.request_id = 0 AND
         ((new.transaction_type      =  'DELIVER' AND
	   new.destination_type_code IN ('INVENTORY', 'EXPENSE')
	  )
	  OR
	  (new.destination_type_code =  'RECEIVING' AND
	   new.transaction_type      IN ('CORRECT', 'RETURN TO VENDOR')
	  ))
       ) DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
  -- TBD: there something very strange about this, see WHEN clause above.
  requestId number := :new.request_id;

  CURSOR getOrgId (p_poHeaderId NUMBER) IS
    SELECT org_id
    FROM   po_headers_all
    WHERE  po_header_id = p_poHeaderId;

  CURSOR getDocNum IS
    SELECT h.receipt_num||':'||to_char(l.line_num) "doc_num"
    FROM   rcv_shipment_headers h,
	   rcv_shipment_lines   l
    WHERE  :new.shipment_header_id = h.shipment_header_id
    AND    :new.shipment_line_id   = l.shipment_line_id;

  l_orgid  po_headers_all.org_id%TYPE;
  l_params wf_parameter_list_t;
  l_clntyp VARCHAR2(30);
  l_docnum VARCHAR2(100);

BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_rcv_transactions_ARI');
  ITG_Debug.msg('RT', 'new.po_header_id',     :new.po_header_id);
  ITG_Debug.msg('RT', 'new.transaction_type', :new.transaction_type);

  -- get the org id
  OPEN  getOrgId(:new.po_header_id);
  FETCH getOrgId INTO l_orgid;
  CLOSE getOrgId;

  -- if the transaction is CORRECT or RETURN TO VENDOR
  -- For each line fire a XML, regardless of what is running
  -- so  for each line there will be a XML
  IF :new.transaction_type = 'DELIVER' THEN
    l_clntyp := 'ITG_UPD_REC';
  ELSIF :new.transaction_type = 'CORRECT' THEN
    l_clntyp := 'ITG_UPD_ADJ';
  ELSE
    l_clntyp := 'ITG_UPD_RET';
  END IF;

  OPEN  getDocNum;
  FETCH getDocNum INTO l_docnum;
  CLOSE getDocNum;

  itg_outbound_utils.raise_wf_event(
    p_bsr    => 'UPDATE_DELIVERY',
    p_id     => :new.shipment_header_id,
    p_org    => l_orgid,
    p_doctyp => 'ITG_UPD',
    p_clntyp => l_clntyp,
    p_doc    => l_docnum,
    p_param1 => to_char(requestId),
    p_param2 => to_char(:new.transaction_id));

  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_RCV_TRANSACTIONS_ARI" DISABLE;
