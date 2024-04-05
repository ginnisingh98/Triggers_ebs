--------------------------------------------------------
--  DDL for Trigger JL_BR_AR_BEF_DEL_CUST_INT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AR_BEF_DEL_CUST_INT" 
BEFORE DELETE ON "AR"."RA_CUSTOMERS_INTERFACE_ALL"
FOR EACH ROW
   WHEN (((sys_context('JG','JGZZ_COUNTRY_CODE') in ('BR')) OR
(to_char(new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')))
AND old.orig_system_address_ref is not null) DECLARE
 l_inscription_type 	varchar2(1);
 l_inscription_number 	varchar2(9);
 l_inscription_branch	varchar2(4);
 l_inscription_digit 	varchar2(2);
 l_errbuf		varchar2(30);
 l_error_flag1          varchar2(1) := 'N';
 l_error_flag2          varchar2(1) := 'N';
 l_error_flag3          varchar2(1) := 'N';
 l_error_flag4          varchar2(1) := 'N';
 l_retcode		number;
 l_contributor_type 	varchar2(25);
 l_error_code 		varchar2(30);
 l_customer_name 	varchar2(40);
 l_address1 		varchar2(40);
 c_cust_name            varchar2(40);
 l_num_check            number;
 l_customer_id          number;
 l_country_code         VARCHAR2(100);
 PROCEDURE get_cust_add is
 BEGIN
       BEGIN
         SELECT substr(cst.account_name,1,40), cust_account_id
         INTO   l_customer_name, l_customer_id
         FROM   hz_cust_accounts cst
         WHERE  cst.orig_system_reference = :old.orig_system_customer_ref;
         EXCEPTION WHEN OTHERS THEN
                        l_customer_name := null;
       End;
       IF l_customer_name is not null THEN
          BEGIN
            SELECT substr(loc.address1,1,40)
            INTO   l_address1
            FROM   hz_cust_acct_sites_all acct_site,
                   hz_party_sites party_site,
                   hz_locations loc
            WHERE  acct_site.orig_system_reference = :old.orig_system_address_ref
            AND    acct_site.cust_account_id = l_customer_id
            AND acct_site.party_site_id = party_site.party_site_id
            AND party_site.location_id = loc.location_id;
            EXCEPTION WHEN OTHERS THEN
                           l_address1 := null;
          END;
       END IF;
    END;
BEGIN

/* Check inscription Number */
  IF (to_char(:new.org_id) <> nvl(sys_context('JG','JGZZ_ORG_ID'),'XX')) THEN

     l_country_code := JG_ZZ_SHARED_PKG.GET_COUNTRY(:new.org_id,NULL,NULL);

     JG_CONTEXT.name_value('JGZZ_COUNTRY_CODE',l_country_code);

     JG_CONTEXT.name_value('JGZZ_ORG_ID',to_char(:new.org_id));


  END IF;

 IF (sys_context('JG','JGZZ_COUNTRY_CODE') = 'BR') THEN

IF :old.global_attribute1 is not null
THEN
   /* Get the inscription type code */
   l_inscription_type 	:= substr(:old.global_attribute1,1,1);
   l_inscription_number := substr(:old.global_attribute2,1,9);
   l_inscription_branch := substr(:old.global_attribute3,1,4);
   l_inscription_digit 	:= substr(:old.global_attribute4,1,2);
   l_error_flag1 := 'N';
   l_error_flag2 := 'N';
   l_error_flag3 := 'N';
   l_error_flag4 := 'N';
   BEGIN
     select to_number(l_inscription_type)
     into   l_num_check
     from   dual;
     EXCEPTION WHEN INVALID_NUMBER OR VALUE_ERROR THEN
            l_error_flag1 := 'Y';
   END;
   BEGIN
     select to_number(l_inscription_number)
     into   l_num_check
     from   dual;
     EXCEPTION WHEN INVALID_NUMBER OR VALUE_ERROR  THEN
            l_error_flag2 := 'Y';
   END;
   BEGIN
     select to_number(l_inscription_branch)
     into   l_num_check
     from   dual;
     EXCEPTION WHEN INVALID_NUMBER OR VALUE_ERROR THEN
            l_error_flag3 := 'Y';
   END;
   BEGIN
     select to_number(l_inscription_digit)
     into   l_num_check
     from   dual;
     EXCEPTION WHEN INVALID_NUMBER OR VALUE_ERROR THEN
            l_error_flag4 := 'Y';
   END;
   IF (l_error_flag1 = 'N' and
       l_error_flag2 = 'N' and
       l_error_flag3 = 'N' and
       l_error_flag4 = 'N' )   THEN
       jl_br_inscription_number.validate_inscription_number(
                l_inscription_type,
                l_inscription_number,
                l_inscription_branch,
                l_inscription_digit,
                l_errbuf,
                l_retcode);
       IF l_retcode <> 0
       THEN /* Validation of inscription number failed */
          get_cust_add;
          IF l_errbuf = 'CGC_INSCRIPTION_NUMBER_ERR' OR
             l_errbuf = 'CPF_INSCRIPTION_NUMBER_ERR'
          THEN
             l_error_code := 'CUST_INSCRIPTION_DIGIT_ERROR';
             INSERT INTO jl_br_ar_cust_int_err
                    (error_code,
                    description)
             VALUES (l_error_code,
                    l_customer_name||'-'||l_address1);
          ELSIF l_errbuf = 'CPF_INSCRIPTION_BRANCH_ERR'
          THEN
                l_error_code := 'CUST_INSCRIPTION_SUBS_ERROR';
                INSERT INTO jl_br_ar_cust_int_err
                        (error_code,
                        description)
                VALUES  (l_error_code,
                        l_customer_name||'-'||l_address1);
          ELSIF l_errbuf = 'INSCRIPTION_TYPE_ERR'
          THEN
                l_error_code := 'CUST_INSCRIPTION_TYPE_ERROR';
                INSERT INTO jl_br_ar_cust_int_err
                       (error_code,
                        description)
                VALUES (l_error_code,
                       l_customer_name||'-'||l_address1);
          END IF;
    ELSE
      BEGIN
          get_cust_add;
          IF l_error_flag1 = 'Y' THEN
             l_error_code := 'CUST_INSCRIPTION_TYPE_ERROR';
             INSERT INTO jl_br_ar_cust_int_err
                    (error_code,
                     description)
             VALUES (l_error_code,
                     l_customer_name||'-'||l_address1);
          END IF;
          IF l_error_flag2 = 'Y' THEN
             l_error_code := 'CUST_INSCRIPTION_NUMBER_ERROR';
             INSERT INTO jl_br_ar_cust_int_err
                    (error_code,
                     description)
             VALUES (l_error_code,
                     l_customer_name||'-'||l_address1);
          END IF;
          IF l_error_flag3 = 'Y' THEN
             l_error_code := 'CUST_INSCRIPTION_BRANCH_ERROR';
             INSERT INTO jl_br_ar_cust_int_err
                    (error_code,
                     description)
             VALUES (l_error_code,
                     l_customer_name||'-'||l_address1);
          END IF;
          IF l_error_flag4 = 'Y' THEN
             l_error_code := 'CUST_INSCRIPTION_DIGIT_ERROR';
             INSERT INTO jl_br_ar_cust_int_err
                    (error_code,
                     description)
             VALUES (l_error_code,
                     l_customer_name||'-'||l_address1);
          END IF;
      END;
    END IF;
  END IF;
ELSE /* There is no inscription type */
   get_cust_add;
   l_error_code := 'CUST_INSCRIPTION_TYPE_ERROR';
   INSERT INTO jl_br_ar_cust_int_err
           (error_code,
            description)
    VALUES (l_error_code,
            l_customer_name||'-'||l_address1);
END IF;

/* Check contributor type */
IF :old.global_attribute7 is not null
THEN
   BEGIN
        /* Code modified for implementing MLS issue, by Sierra.
           Modified on : 03/05/99                           */
        /* Lookup Type Value modified by Sierra on 06/11/99 */

   	SELECT lookup_code
     	INTO l_contributor_type
     	FROM fnd_lookups
    	WHERE lookup_code = :old.global_attribute7
      	AND lookup_type = 'CONTRIBUTOR_CLASS'
    	AND   nvl(end_date_active, sysdate+1) > SYSDATE;

        /* End of modification. */

   EXCEPTION
  	WHEN no_data_found
	THEN
            get_cust_add;
	    l_error_code := 'CUST_CONTRIBUTOR_TYPE_ERROR';
   	    INSERT INTO jl_br_ar_cust_int_err
           	    	(error_code,
            	    	description)
    	    VALUES (l_error_code,
	    	    	l_customer_name||'-'||l_address1);
   END;
ELSE /* There is no COntributor Type */

    get_cust_add;
    l_error_code := 'CUST_CONTRIBUTOR_TYPE_ERROR';
    INSERT INTO jl_br_ar_cust_int_err
	   (error_code,
	    description)
    VALUES (l_error_code,
	    l_customer_name||'-'||l_address1);
END IF;

UPDATE hz_cust_acct_sites_all
SET global_attribute1 = null,
    global_attribute2 = :old.global_attribute1,
    global_attribute3 = :old.global_attribute2,
    global_attribute4 = :old.global_attribute3,
    global_attribute5 = :old.global_attribute4,
    global_attribute6 = :old.global_attribute5,
    global_attribute7 = :old.global_attribute6,
    global_attribute8 = :old.global_attribute7,
    global_attribute9 = null,
    global_attribute10 = null,
    global_attribute11 = null,
    global_attribute12 = null,
    global_attribute13 = null,
    global_attribute14 = null,
    global_attribute15 = null,
    global_attribute16 = null,
    global_attribute17 = null,
    global_attribute18 = null,
    global_attribute19 = null,
    global_attribute20 = null,
    global_attribute_category = :old.global_attribute_category
WHERE orig_system_reference = :old.orig_system_address_ref;

UPDATE hz_cust_accounts
SET global_attribute1  = null,
    global_attribute2  = null,
    global_attribute3  = null,
    global_attribute4  = null,
    global_attribute5  = null,
    global_attribute6  = null,
    global_attribute7  = null,
    global_attribute8  = null,
    global_attribute9  = null,
    global_attribute10 = null,
    global_attribute11 = null,
    global_attribute12 = null,
    global_attribute13 = null,
    global_attribute14 = null,
    global_attribute15 = null,
    global_attribute16 = null,
    global_attribute17 = null,
    global_attribute18 = null,
    global_attribute19 = null,
    global_attribute20 = null,
    global_attribute_category = null
WHERE orig_system_reference = :old.orig_system_customer_ref;

/*
UPDATE ra_site_uses
SET global_attribute1  = null,
    global_attribute2  = null,
    global_attribute3  = null,
    global_attribute4  = null,
    global_attribute5  = null,
    global_attribute6  = null,
    global_attribute7  = null,
    global_attribute8  = null,
    global_attribute9  = null,
    global_attribute10 = null,
    global_attribute11 = null,
    global_attribute12 = null,
    global_attribute13 = null,
    global_attribute14 = null,
    global_attribute15 = null,
    global_attribute16 = null,
    global_attribute17 = null,
    global_attribute18 = null,
    global_attribute19 = null,
    global_attribute20 = null,
    global_attribute_category = null
WHERE address_id = (select cust_acct_id
                    from   hz_cust_accounts
                   where  orig_system_reference = :old.orig_system_address_ref);
*/
END IF;

exception when others then
          get_cust_add;
          l_error_code := 'CUST_INSCRIPTION_DIGIT_ERROR';
          INSERT INTO jl_br_ar_cust_int_err
                 (error_code,
                  description)
          VALUES (l_error_code,
                  l_customer_name||'-'||l_address1);

END;	/* End of Block */




/
ALTER TRIGGER "APPS"."JL_BR_AR_BEF_DEL_CUST_INT" ENABLE;
