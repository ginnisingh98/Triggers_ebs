--------------------------------------------------------
--  DDL for Trigger ITG_IP_LINE_LOCATIONS_ALL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_LINE_LOCATIONS_ALL_ARU" 
  AFTER UPDATE OF cancel_flag
  ON "PO"."PO_LINE_LOCATIONS_ALL"
  FOR EACH ROW
     WHEN (UPPER(new.cancel_flag) = 'Y') DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
  CURSOR get_doc_info(
    p_po_header_id  NUMBER,
    p_po_line_id    NUMBER
  ) IS
    SELECT h.segment1||':'||to_char(l.line_num) docnum,
           l.cancel_flag
    FROM   po_headers_all h,
           po_lines_all   l
    WHERE  h.po_header_id = p_po_header_id
    AND    h.po_header_id = l.po_header_id
    AND    l.po_line_id   = p_po_line_id;

  CURSOR get_rel_info(
    p_po_release_id NUMBER
  ) IS
    SELECT cancel_flag,
           to_char(release_num) relnum
    FROM   po_releases_all
    WHERE  po_release_id = p_po_release_id;

  l_doc_info   get_doc_info%ROWTYPE;
  l_rel_info   get_rel_info%ROWTYPE;
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_line_locations_all_ARU');
  ITG_Debug.msg('LLA', 'new.cancel_flag',   :new.cancel_flag);
  ITG_Debug.msg('LLA', 'new.po_header_id',  :new.po_header_id);
  ITG_Debug.msg('LLA', 'new.po_line_id',    :new.po_line_id);
  ITG_Debug.msg('LLA', 'new.po_release_id', :new.po_release_id);

  /*  Modified all CANCEL PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id (formerly, the case code of 1-6)
        p_param2 will now be po_line_id
        p_param3 will now be po_line_location_id
      also added '_RELEASE' to the p_bsr for RELEASE cases
   */

  IF UPPER(NVL(:new.cancel_flag, 'N')) = 'Y' THEN

    OPEN  get_doc_info(:new.po_header_id, :new.po_line_id);
    FETCH get_doc_info INTO l_doc_info;
    CLOSE get_doc_info;

    /* IF there is no release ID, THEN its for a 'regular' PO...  */
    IF :new.po_release_id IS NULL THEN
      /* If we are not part of a cascaded cancel */
      IF UPPER(NVL(l_doc_info.cancel_flag, 'N')) = 'N' THEN
	/* Cancel a PO SHIPMENT */
	itg_outbound_utils.raise_wf_event(
	  p_bsr    => 'CANCEL_PO',
	  p_id     => :new.po_header_id,
	  p_org    => :new.org_id,
	  p_doctyp => 'ITG_CANCEL_PO',
	  p_clntyp => 'ITG_CANCEL_PO',
	  p_doc    => l_doc_info.docnum,
	  p_param2 => :new.po_line_id,
	  p_param3 => :new.line_location_id);
       END IF;

    ELSE
      /* There is a release ID, so its for a PO Release... */

      OPEN  get_rel_info(:new.po_release_id);
      FETCH get_rel_info INTO l_rel_info;
      CLOSE get_rel_info;

      /* If we are not part of a cascaded release cancel */
      IF UPPER(NVL(l_rel_info.cancel_flag, 'N')) = 'N' THEN
	/* Cancel a RELEASE SHIPMENT */
	itg_outbound_utils.raise_wf_event(
	  p_bsr    => 'CANCEL_PO_RELEASE',
	  p_id     => :new.line_location_id, -- NOTE: this does not fit!!
	  p_org    => :new.org_id,
	  p_doctyp => 'ITG_CANCEL_PO',
	  p_clntyp => 'ITG_CANCEL_PO',
	  p_doc    => l_doc_info.docnum,
	  p_rel    => l_rel_info.relnum,
	  p_param1 => :new.po_release_id,
	  p_param2 => :new.po_line_id,
	  p_param3 => :new.line_location_id);
      END IF;
    END IF;
  END IF;

  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_LINE_LOCATIONS_ALL_ARU" DISABLE;
