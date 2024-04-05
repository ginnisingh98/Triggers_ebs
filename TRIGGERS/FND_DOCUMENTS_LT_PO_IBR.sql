--------------------------------------------------------
--  DDL for Trigger FND_DOCUMENTS_LT_PO_IBR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_IBR" 
BEFORE INSERT ON          "APPLSYS"."FND_DOCUMENTS_LONG_TEXT"
FOR EACH ROW
/* $Header: poatt04t.sql 115.2 99/07/17 02:20:19 porting shi $ */

BEGIN

/* at some point, we need to check whether this document is for PO or not.
   if yes, we mark the record. otherwise, do nothing. AOL may implement a
   wrap package and call approriate product's procedure accordingly.
*/
  IF :new.app_source_version IS NULL THEN
    po_att.mark_record (:new.media_id, 'L', 'DOCUMENT', 'INSERT', 'PO_10SC');

  ELSIF :new.app_source_version = 'PO_R10' THEN
    :new.app_source_version := '';

  END IF;

END;


/
ALTER TRIGGER "APPS"."FND_DOCUMENTS_LT_PO_IBR" DISABLE;
