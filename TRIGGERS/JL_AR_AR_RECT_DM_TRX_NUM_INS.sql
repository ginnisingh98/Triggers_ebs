--------------------------------------------------------
--  DDL for Trigger JL_AR_AR_RECT_DM_TRX_NUM_INS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_AR_AR_RECT_DM_TRX_NUM_INS" 
BEFORE INSERT
ON "AR"."RA_CUSTOMER_TRX_ALL"
FOR EACH ROW
  WHEN (new.created_from = 'ARXRWRCT' and new.batch_source_id = 11
AND   ((sys_context('JG','JGZZ_COUNTRY_CODE') in ('AR'))
OR (to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')))) DECLARE

  l_document_letter	    VARCHAR2(1);
  l_branch_number	    VARCHAR2(4);
  l_last_trx_date           DATE;
  l_trx_num_cursor          INTEGER;
  l_imported_source_id      ra_batch_sources.batch_source_id%TYPE;
  l_auto_trx_numbering_flag ra_batch_sources.auto_trx_numbering_flag%TYPE;
  l_trx_number              ra_customer_trx.trx_number%TYPE;
  l_count                   NUMBER;
  l_country_code            VARCHAR2(100);


BEGIN
       IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

        l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

        JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

        JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));


       END IF;

       IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'AR') THEN

       l_imported_source_id :=
        jl_ar_doc_numbering_pkg.get_imported_batch_source(:new.batch_source_id);

       SELECT substr(a.global_attribute2,1,4),
              substr(a.global_attribute3,1,1),
              a.auto_trx_numbering_flag,
              fnd_date.canonical_to_date(a.global_attribute4)
       INTO   l_branch_number,
              l_document_letter,
              l_auto_trx_numbering_flag,
              l_last_trx_date
       FROM   ra_batch_sources a
       WHERE  a.batch_source_id =  l_imported_source_id;

       IF l_auto_trx_numbering_flag = 'Y' AND
            substr(:new.trx_number,1,6) <> l_document_letter || '-' ||
            l_branch_number THEN

             l_trx_num_cursor := dbms_sql.open_cursor;

             dbms_sql.parse(l_trx_num_cursor,
                            'select ra_trx_number_' ||
                            to_char(l_imported_source_id) ||
                            '_' ||
                            to_char(:new.org_id)||
                            '_s.nextval trx_number ' ||
                            'from dual ',
                            dbms_sql.NATIVE);

             dbms_sql.define_column(l_trx_num_cursor, 1, l_trx_number, 20);

             l_count := dbms_sql.execute_and_fetch(l_trx_num_cursor,TRUE);

             dbms_sql.column_value(l_trx_num_cursor, 1, l_trx_number);

             dbms_sql.close_cursor(l_trx_num_cursor);

             :new.trx_number := l_document_letter || '-' ||
                                l_branch_number ||  '-' ||
                                lpad(l_trx_number,8,'0');

           IF :new.trx_date < l_last_trx_date THEN
              :new.trx_date := l_last_trx_date;
           ELSE
              UPDATE ra_batch_sources
              SET    global_attribute4 = to_char(:new.trx_date)
              WHERE  batch_source_id = l_imported_source_id;
           END IF;
       END IF;
     END IF;
END;

/
ALTER TRIGGER "APPS"."JL_AR_AR_RECT_DM_TRX_NUM_INS" ENABLE;
