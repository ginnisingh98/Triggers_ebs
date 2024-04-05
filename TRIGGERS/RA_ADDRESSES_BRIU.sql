--------------------------------------------------------
--  DDL for Trigger RA_ADDRESSES_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."RA_ADDRESSES_BRIU" 
/* $Header: arpltadr.sql 115.5 99/07/17 01:03:07 porting s $  */
before insert or update on ar.ra_addresses_all
referencing new as new
            old as old
for each row
begin
/* Check if OSM has disabled address validation on a disconnected Application */
-- IF  as_disco_addr_validation.ra_addresses_all(:new.address_id,
--                                              :new.org_id,
--                                              :new.last_updated_by) THEN
  IF arp_adds.triggers_enabled THEN
    arp_standard.debug('T> RA_ADDRESSES_BRIU: ' || :new.address_id);
    IF ( :new.status <> 'I' ) THEN
      /* IF IT'S Inactive address, then no location id */
      IF ( :new.customer_id <> -1 ) THEN
      /* IF IT'S A REMIT TO ADDRESS, THEN NO SALES TAX */
        IF ( :new.country = arp_standard.sysparm.default_country ) THEN
          /* IF NULL THEN WE HAVE NO SALES TAX */
          IF ( ( :new.location_id is null )
            OR ( nvl( :new.country, 'NULL' ) <>
              nvl( :old.country, 'NULL' ) )
            OR ( nvl( :new.city, 'NULL' ) <>
              nvl( :old.city, 'NULL' ) )
            OR ( nvl( :new.state, 'NULL' ) <>
              nvl( :old.state, 'NULL' ) )
            OR ( nvl( :new.county, 'NULL' ) <>
              nvl( :old.county, 'NULL' ) )
            OR ( nvl( :new.province, 'NULL' ) <>
              nvl( :old.province, 'NULL' ) )
            OR ( nvl( :new.postal_code, 'NULL' ) <>
              nvl( :old.postal_code, 'NULL' ) )
	        OR ( nvl( :new.status, 'NULL' ) <>
              nvl( :old.status, 'NULL' ) )
            OR ( nvl( :new.attribute1, 'NULL' ) <>
              nvl( :old.attribute1, 'NULL' ) )
            OR ( nvl( :new.attribute2, 'NULL' ) <>
              nvl( :old.attribute2, 'NULL' ) )
            OR ( nvl( :new.attribute3, 'NULL' ) <>
              nvl( :old.attribute3, 'NULL' ) )
            OR ( nvl( :new.attribute4, 'NULL' ) <>
              nvl( :old.attribute4, 'NULL' ) )
            OR ( nvl( :new.attribute5, 'NULL' ) <>
              nvl( :old.attribute5, 'NULL' ) )
            OR ( nvl( :new.attribute6, 'NULL' ) <>
              nvl( :old.attribute6, 'NULL' ) )
            OR ( nvl( :new.attribute7, 'NULL' ) <>
              nvl( :old.attribute7, 'NULL' ) )
            OR ( nvl( :new.attribute8, 'NULL' ) <>
              nvl( :old.attribute8, 'NULL' ) )
            OR ( nvl( :new.attribute9, 'NULL' ) <>
              nvl( :old.attribute9, 'NULL' ) )
            OR ( nvl( :new.attribute10, 'NULL' ) <>
              nvl( :old.attribute10, 'NULL' ) ) )
          THEN
    /*-----------------------------------------------------------------------+
     | Build a Code Combination for this address, inserting any rows into    |
     | the value sets table: AR_LOCATION_VALUES as needed.                   |
     | The Creation of a new Code Combination ID (Dynamic Insert of CCID)    |
     | will force the generation of new sales tax rates for each of the      |
     | possible taxing authorities.                                          |
     +-----------------------------------------------------------------------*/
   /*------------------------------------------------------------------------+
    | BUGFIX INCIDENT: 27597 ensure segment values that have trailing spaces |
    | have these spaces removed, this may convert a non null column to null  |
    +------------------------------------------------------------------------*/
            :new.country := rtrim(:new.country);
   	    :new.city := rtrim(:new.city);
   	    :new.state := rtrim(:new.state);
   	    :new.county := rtrim(:new.county);
   	    :new.province := rtrim(:new.province);
   	    :new.postal_code := rtrim(:new.postal_code);
   	    :new.attribute1 := rtrim(:new.attribute1);
   	    :new.attribute2 := rtrim(:new.attribute2);
   	    :new.attribute3 := rtrim(:new.attribute3);
   	    :new.attribute4 := rtrim(:new.attribute4);
   	    :new.attribute5 := rtrim(:new.attribute5);
   	    :new.attribute6 := rtrim(:new.attribute6);
   	    :new.attribute7 := rtrim(:new.attribute7);
   	    :new.attribute8 := rtrim(:new.attribute8);
   	    :new.attribute9 := rtrim(:new.attribute9);
   	    :new.attribute10 := rtrim(:new.attribute10);
            arp_adds.Set_Location_CCID(:new.country,
                                       :new.city,
                                       :new.state,
                                       :new.county,
                                       :new.province,
                                       :new.postal_code,
                                       :new.attribute1,
                                       :new.attribute2,
                                       :new.attribute3,
                                       :new.attribute4,
                                       :new.attribute5,
                                       :new.attribute6,
                                       :new.attribute7,
                                       :new.attribute8,
                                       :new.attribute9,
                                       :new.attribute10,
                                       :new.location_id,
                                       :new.address_id );
          END IF;    /* Address columns changed */
        ELSE         /* Only addresses in Home Country get location id */
          IF ( :new.location_id is not null ) THEN
            :new.location_id := null;
          END IF;
        END IF;     /* Address within the Home Country */
      END IF;       /* only non remit-to address are processed */
    ELSE            /* only active address get location id */
      IF ( :new.location_id is not null ) THEN
            :new.location_id := null;
      END IF;
    END IF;
    arp_standard.debug( 'T< RA_ADDRESSES_BRIU: ' ||
                        :new.address_id || ' ' || :new.location_id );
  END IF; /* Triggers enabled */
-- END IF;   /* OSM has disabled address validation */
END;


/
ALTER TRIGGER "APPS"."RA_ADDRESSES_BRIU" ENABLE;
