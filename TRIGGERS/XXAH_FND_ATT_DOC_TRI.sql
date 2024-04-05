--------------------------------------------------------
--  DDL for Trigger XXAH_FND_ATT_DOC_TRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_FND_ATT_DOC_TRI" 
BEFORE INSERT OR UPDATE ON APPLSYS.FND_ATTACHED_DOCUMENTS
FOR EACH ROW
DECLARE

  CURSOR c_pbav(b_po_line_id NUMBER) IS
    SELECT
        pla.attribute1             po_line_currency_code  -- v06
      , pla.item_description       po_line_description    -- v06
      , pbav.*
    FROM
      po_lines_all pla
    , pon_bid_attribute_values pbav
    WHERE 1=1
    AND   pbav.auction_header_id   = pla.auction_header_id
    AND   pbav.bid_number          = pla.bid_number
    AND   pbav.auction_line_number = pla.auction_line_number
    AND   pla.po_line_id           = b_po_line_id
    AND   pbav.applied_inco_terms  = 'N'
  ;

  CURSOR c_doc(b_document_id NUMBER) IS
    SELECT
      fdlt.media_id
    , fdlt.long_text
    FROM
      fnd_documents_tl        fdt
    , fnd_documents           fd
    , fnd_document_categories fdc
    , fnd_documents_long_text fdlt
    WHERE 1=1
    -- AND   fad.document_id = fd.document_id
    AND   fdt.document_id = fd.document_id
    AND   fd.category_id  = fdc.category_id
    AND   fd.media_id     = fdlt.media_id
    AND   fdc.NAME        = 'Vendor'
    AND   fdt.DESCRIPTION = 'Sourcing RFQ Line Attribute Quote Values'
    AND   fd.document_id     = b_document_id
  ;

  -- added 2007/Jun/18, rlascae, for attr_group
  CURSOR c_paa(b_auction_header_id NUMBER, b_line_number NUMBER) IS
    SELECT paa.*
    FROM pon_auction_attributes paa
    ,    fnd_lookup_values      flv
    WHERE 1=1
    AND   paa.auction_header_id = b_auction_header_id -- 102031
    AND   paa.line_number       = b_line_number -- 1
    AND   paa.attr_group        = flv.lookup_code
    AND   flv.lookup_type       = 'PON_LINE_ATTRIBUTE_GROUPS'
    AND   flv.attribute1        = 'Y'
    AND   paa.attr_group       != 'INCO'
    AND   paa.mandatory_flag    = 'N'
  ;

  l_long_text         LONG;
  l_long_clob         CLOB;
  l_long_clob_tmp     CLOB;
  l_media_id          fnd_documents.media_id%TYPE;
  l_doc               c_doc%ROWTYPE;
  l_pbav              c_pbav%ROWTYPE;
  l_po_line_id        NUMBER;
  l_tmp_str           VARCHAR2(4000);
  l_document_id       NUMBER;
  l_auction_header_id NUMBER;
  l_pon_line_number   NUMBER;
  l_po_line_currency_code  po_lines_all.attribute1%TYPE;        -- v06
  l_po_line_description    po_lines_all.item_description%TYPE;  -- v06
  l_pbav_found             BOOLEAN; -- v07
  l_doc_found              BOOLEAN; -- v07

  l_pos_1          NUMBER;
  l_pos_2          NUMBER;

BEGIN
  IF :new.entity_name = 'PO_LINES' THEN -- v07
    l_document_id:= :new.document_id;
    l_po_line_id:=  :new.pk1_value;

    -- Get the bid attribute values belonging to the current purchase line
    OPEN c_pbav(l_po_line_id);
    FETCH c_pbav INTO l_pbav;
    l_pbav_found := c_pbav%FOUND; -- v07
    CLOSE c_pbav;

    -- Only perform next actions if purchase line is based on auction
    IF l_pbav_found THEN -- v07
      l_auction_header_id      := l_pbav.auction_header_id;
      l_pon_line_number        := l_pbav.auction_line_number;
      l_po_line_currency_code  := l_pbav.po_line_currency_code; -- v06
      l_po_line_description    := l_pbav.po_line_description;   -- v06

      -- Get the attached long text from the Vendors
      -- Sourcing RFQ Line Attribute Quote Values
      OPEN c_doc(l_document_id);
      FETCH c_doc INTO l_doc;
      l_doc_found := c_doc%FOUND; -- v07
      CLOSE c_doc;

      -- Only perform next actions if attachment is of correct type
      IF l_doc_found THEN -- v07
        l_media_id := l_doc.media_id;
        l_long_text:= l_doc.long_text;
        l_long_clob:= l_long_text;
        l_long_clob_tmp:= l_long_text;

        -- xxah_log_proc('trigger tr2, l_media_id: ' || to_char(l_media_id));
        -- xxah_log_proc('trigger tr2, l_document_id: ' || to_char(l_document_id));
        -- xxah_log_proc('trigger tr2, l_po_line_id: ' || to_char(l_po_line_id));

        -- Replace the item description with the line currency
        l_long_clob_tmp:= REPLACE(l_long_clob_tmp, l_po_line_description, 'Currency: ' || l_po_line_currency_code); -- v06

        -- Delete IncoTerms attributes that are not selected
        FOR lr_pbav IN c_pbav(l_po_line_id) LOOP
          l_tmp_str:= lr_pbav.attribute_name;
          l_pos_1:= INSTR(l_long_clob_tmp, l_tmp_str, 1, 1);
          l_pos_2:= INSTR(l_long_clob_tmp, Chr(10), l_pos_1, 1);

          IF l_pos_2 = 0 THEN
            l_pos_2:= length(l_long_clob_tmp);
          END IF;

          l_tmp_str:= SUBSTR(l_long_clob_tmp, l_pos_1, l_pos_2 - l_pos_1);
          l_long_clob_tmp:= REPLACE(l_long_clob_tmp, l_tmp_str, '');
        END LOOP;

        -- l_long_text_tmp:= xxah_fnd_doc_long_text_pkg.parse(p_media_id=>l_media_id, p_long_text=> l_long_text);

        -- Add non-IncoTerms attributes that are NOT mandatory with an attribute group that MUST be added
        FOR lr_paa IN c_paa(l_auction_header_id, l_pon_line_number) LOOP
          l_tmp_str:= lr_paa.attribute_name || ' = ' || lr_paa.value || Chr(10);
          l_long_clob_tmp:= l_long_clob_tmp || l_tmp_str;
        END LOOP;

        -- When changed, update the attachment in the database
        IF l_long_clob != l_long_clob_tmp THEN
          -- xxah_log_proc('trigger tr2 before updating');
          l_long_text:= l_long_clob_tmp;
          UPDATE fnd_documents_long_text set
            long_text= l_long_text
          WHERE media_id = l_media_id;
        END IF;
      END IF; -- v07
    END IF; -- v07
  END IF; -- v07
EXCEPTION WHEN OTHERS THEN
  IF c_pbav%ISOPEN THEN CLOSE c_pbav; END IF; -- v07
  xxah_log_proc('trigger xxah_fnd_att_doc_TRI: ' || SQLERRM);
  RAISE_APPLICATION_ERROR(-20000, 'XXAH: xxah_fnd_att_doc_TRI');

END;


/
ALTER TRIGGER "APPS"."XXAH_FND_ATT_DOC_TRI" ENABLE;
