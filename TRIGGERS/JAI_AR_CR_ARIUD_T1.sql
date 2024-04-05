--------------------------------------------------------
--  DDL for Trigger JAI_AR_CR_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_CR_ARIUD_T1" after insert or update or delete on "AR"."AR_CASH_RECEIPTS_ALL" for each row
/* $Header: jai_ar_cr_t.sql 120.1.12000000.1 2007/07/24 06:55:25 rallamse noship $ */
DECLARE

	CURSOR c_loc_receipt_class
	IS
	SELECT 	a.attribute_value receipt_class
	FROM 		JAI_RGM_REGISTRATIONS a,
			JAI_RGM_DEFINITIONS b
	WHERE		a.attribute_code = 'AR_RECEIPT_CLASS'
	AND 		a.registration_type = 'OTHERS'
	AND 		a.attribute_type_code = 'OTHERS'
	AND 		a.regime_id = b.regime_id
	AND		b.regime_code = 'TCS';


	CURSOR c_receipt_class(cp_receipt_method_id	NUMBER,
												 cp_receipt_class			VARCHAR2)
	IS
	select	'1' flag
	FROM 	ar_receipt_classes a,
		ar_receipt_methods b
	WHERE 	a.receipt_class_id = b.receipt_class_id
	AND 	a.name = cp_receipt_class
	AND 	b.receipt_method_id = cp_receipt_method_id;


	lv_flag		VARCHAR2(1);
	lv_old_flag	VARCHAR2(1);

	r_loc_receipt_class	c_loc_receipt_class%ROWTYPE;

	r_new		ar_cash_receipts_all%ROWTYPE;
	r_old		ar_cash_receipts_all%ROWTYPE;

	lv_return_message VARCHAR2(2000);
	lv_return_code    VARCHAR2(100) ;
	le_error          EXCEPTION     ;
	lv_action             VARCHAR2(20)  ;


	PROCEDURE init_new
	IS
	BEGIN
		r_new.cash_receipt_id                   :=				:NEW.cash_receipt_id;
		r_new.last_updated_by                		:=				:NEW.last_updated_by;
		r_new.last_update_date               		:=				:NEW.last_update_date;
		r_new.last_update_login              		:=				:NEW.last_update_login;
		r_new.created_by                     		:=				:NEW.created_by;
		r_new.creation_date                  		:=				:NEW.creation_date;
		r_new.amount                         		:=				:NEW.amount;
		r_new.set_of_books_id                		:=				:NEW.set_of_books_id;
		r_new.currency_code                  		:=				:NEW.currency_code;
		r_new.receivables_trx_id             		:=				:NEW.receivables_trx_id;
		r_new.pay_from_customer              		:=				:NEW.pay_from_customer;
		r_new.status                         		:=				:NEW.status;
		r_new.type                           		:=				:NEW.type;
		r_new.receipt_number                 		:=				:NEW.receipt_number;
		r_new.receipt_date                   		:=				:NEW.receipt_date;
		r_new.misc_payment_source            		:=				:NEW.misc_payment_source;
		r_new.comments                       		:=				:NEW.comments;
		r_new.distribution_set_id            		:=				:NEW.distribution_set_id;
		r_new.reversal_date                  		:=				:NEW.reversal_date;
		r_new.reversal_category              		:=				:NEW.reversal_category;
		r_new.reversal_reason_code           		:=				:NEW.reversal_reason_code;
		r_new.reversal_comments              		:=				:NEW.reversal_comments;
		r_new.exchange_rate_type             		:=				:NEW.exchange_rate_type;
		r_new.exchange_rate                  		:=				:NEW.exchange_rate;
		r_new.exchange_date                  		:=				:NEW.exchange_date;
		r_new.attribute_category             		:=				:NEW.attribute_category;
		r_new.attribute1                     		:=				:NEW.attribute1;
		r_new.attribute2                     		:=				:NEW.attribute2;
		r_new.attribute3                     		:=				:NEW.attribute3;
		r_new.attribute4                     		:=				:NEW.attribute4;
		r_new.attribute5                     		:=				:NEW.attribute5;
		r_new.attribute6                     		:=				:NEW.attribute6;
		r_new.attribute7                     		:=				:NEW.attribute7;
		r_new.attribute8                     		:=				:NEW.attribute8;
		r_new.attribute9                     		:=				:NEW.attribute9;
		r_new.attribute10                    		:=				:NEW.attribute10;
		r_new.remittance_bank_account_id     		:=				:NEW.remittance_bank_account_id;
		r_new.attribute11                    		:=				:NEW.attribute11;
		r_new.attribute12                    		:=				:NEW.attribute12;
		r_new.attribute13                    		:=				:NEW.attribute13;
		r_new.attribute14                    		:=				:NEW.attribute14;
		r_new.attribute15                    		:=				:NEW.attribute15;
		r_new.confirmed_flag                 		:=				:NEW.confirmed_flag;
		r_new.customer_bank_account_id       		:=				:NEW.customer_bank_account_id;
		r_new.customer_site_use_id           		:=				:NEW.customer_site_use_id;
		r_new.deposit_date                   		:=				:NEW.deposit_date;
		r_new.program_application_id         		:=				:NEW.program_application_id;
		r_new.program_id                     		:=				:NEW.program_id;
		r_new.program_update_date            		:=				:NEW.program_update_date;
		r_new.receipt_method_id              		:=				:NEW.receipt_method_id;
		r_new.request_id                     		:=				:NEW.request_id;
		r_new.selected_for_factoring_flag    		:=				:NEW.selected_for_factoring_flag;
		r_new.selected_remittance_batch_id   		:=				:NEW.selected_remittance_batch_id;
		r_new.factor_discount_amount         		:=				:NEW.factor_discount_amount;
		r_new.ussgl_transaction_code         		:=				:NEW.ussgl_transaction_code;
		r_new.ussgl_transaction_code_context  	:=  					:NEW.ussgl_transaction_code_context;
		r_new.doc_sequence_value             		:=  				:NEW.doc_sequence_value;
		r_new.doc_sequence_id                		:=				:NEW.doc_sequence_id;
		r_new.vat_tax_id                     		:=				:NEW.vat_tax_id;
		r_new.reference_type                 		:=				:NEW.reference_type;
		r_new.reference_id                   		:=				:NEW.reference_id;
		r_new.customer_receipt_reference     		:=				:NEW.customer_receipt_reference;
		r_new.override_remit_account_flag    		:=				:NEW.override_remit_account_flag;
		r_new.org_id                         		:=				:NEW.org_id;
		r_new.anticipated_clearing_date      		:=				:NEW.anticipated_clearing_date;
		r_new.global_attribute1              		:=				:NEW.global_attribute1;
		r_new.global_attribute2              		:=				:NEW.global_attribute2;
		r_new.global_attribute3              		:=				:NEW.global_attribute3;
		r_new.global_attribute4              		:=				:NEW.global_attribute4;
		r_new.global_attribute5              		:=				:NEW.global_attribute5;
		r_new.global_attribute6              		:=				:NEW.global_attribute6;
		r_new.global_attribute7              		:=				:NEW.global_attribute7;
		r_new.global_attribute8              		:=				:NEW.global_attribute8;
		r_new.global_attribute9              		:=				:NEW.global_attribute9;
		r_new.global_attribute10             		:=				:NEW.global_attribute10;
		r_new.global_attribute11             		:=				:NEW.global_attribute11;
		r_new.global_attribute12             		:=				:NEW.global_attribute12;
		r_new.global_attribute13             		:=				:NEW.global_attribute13;
		r_new.global_attribute14             		:=				:NEW.global_attribute14;
		r_new.global_attribute15             		:=				:NEW.global_attribute15;
		r_new.global_attribute16             		:=				:NEW.global_attribute16;
		r_new.global_attribute17             		:=				:NEW.global_attribute17;
		r_new.global_attribute18             		:=				:NEW.global_attribute18;
		r_new.global_attribute19             		:=				:NEW.global_attribute19;
		r_new.global_attribute20             		:=				:NEW.global_attribute20;
		r_new.global_attribute_category      		:=				:NEW.global_attribute_category;
		r_new.customer_bank_branch_id        		:=				:NEW.customer_bank_branch_id;
		r_new.issuer_name                    		:=				:NEW.issuer_name;
		r_new.issue_date                     		:=				:NEW.issue_date;
		r_new.issuer_bank_branch_id          		:=				:NEW.issuer_bank_branch_id;
		r_new.mrc_exchange_rate_type         		:=				:NEW.mrc_exchange_rate_type;
		r_new.mrc_exchange_rate              		:=				:NEW.mrc_exchange_rate;
		r_new.mrc_exchange_date              		:=				:NEW.mrc_exchange_date;
		r_new.payment_server_order_num       		:=				:NEW.payment_server_order_num;
		r_new.approval_code                  		:=				:NEW.approval_code;
		r_new.address_verification_code      		:=				:NEW.address_verification_code;
		r_new.tax_rate                       		:=				:NEW.tax_rate;
		r_new.actual_value_date              		:=				:NEW.actual_value_date;
		r_new.postmark_date                  		:=				:NEW.postmark_date;

	END init_new;


	PROCEDURE init_old
	IS
	BEGIN
		r_old.cash_receipt_id                   :=					:OLD.cash_receipt_id;
		r_old.last_updated_by                		:=				:OLD.last_updated_by;
		r_old.last_update_date               		:=				:OLD.last_update_date;
		r_old.last_update_login              		:=				:OLD.last_update_login;
		r_old.created_by                     		:=				:OLD.created_by;
		r_old.creation_date                  		:=				:OLD.creation_date;
		r_old.amount                         		:=				:OLD.amount;
		r_old.set_of_books_id                		:=				:OLD.set_of_books_id;
		r_old.currency_code                  		:=				:OLD.currency_code;
		r_old.receivables_trx_id             		:=				:OLD.receivables_trx_id;
		r_old.pay_from_customer              		:=				:OLD.pay_from_customer;
		r_old.status                         		:=				:OLD.status;
		r_old.type                           		:=				:OLD.type;
		r_old.receipt_number                 		:=				:OLD.receipt_number;
		r_old.receipt_date                   		:=				:OLD.receipt_date;
		r_old.misc_payment_source            		:=				:OLD.misc_payment_source;
		r_old.comments                       		:=				:OLD.comments;
		r_old.distribution_set_id            		:=				:OLD.distribution_set_id;
		r_old.reversal_date                  		:=				:OLD.reversal_date;
		r_old.reversal_category              		:=				:OLD.reversal_category;
		r_old.reversal_reason_code           		:=				:OLD.reversal_reason_code;
		r_old.reversal_comments              		:=				:OLD.reversal_comments;
		r_old.exchange_rate_type             		:=				:OLD.exchange_rate_type;
		r_old.exchange_rate                  		:=				:OLD.exchange_rate;
		r_old.exchange_date                  		:=				:OLD.exchange_date;
		r_old.attribute_category             		:=				:OLD.attribute_category;
		r_old.attribute1                     		:=				:OLD.attribute1;
		r_old.attribute2                     		:=				:OLD.attribute2;
		r_old.attribute3                     		:=				:OLD.attribute3;
		r_old.attribute4                     		:=				:OLD.attribute4;
		r_old.attribute5                     		:=				:OLD.attribute5;
		r_old.attribute6                     		:=				:OLD.attribute6;
		r_old.attribute7                     		:=				:OLD.attribute7;
		r_old.attribute8                     		:=				:OLD.attribute8;
		r_old.attribute9                     		:=				:OLD.attribute9;
		r_old.attribute10                    		:=				:OLD.attribute10;
		r_old.remittance_bank_account_id     		:=				:OLD.remittance_bank_account_id;
		r_old.attribute11                    		:=				:OLD.attribute11;
		r_old.attribute12                    		:=				:OLD.attribute12;
		r_old.attribute13                    		:=				:OLD.attribute13;
		r_old.attribute14                    		:=				:OLD.attribute14;
		r_old.attribute15                    		:=				:OLD.attribute15;
		r_old.confirmed_flag                 		:=				:OLD.confirmed_flag;
		r_old.customer_bank_account_id       		:=				:OLD.customer_bank_account_id;
		r_old.customer_site_use_id           		:=				:OLD.customer_site_use_id;
		r_old.deposit_date                   		:=				:OLD.deposit_date;
		r_old.program_application_id         		:=				:OLD.program_application_id;
		r_old.program_id                     		:=				:OLD.program_id;
		r_old.program_update_date            		:=				:OLD.program_update_date;
		r_old.receipt_method_id              		:=				:OLD.receipt_method_id;
		r_old.request_id                     		:=				:OLD.request_id;
		r_old.selected_for_factoring_flag    		:=				:OLD.selected_for_factoring_flag;
		r_old.selected_remittance_batch_id   		:=				:OLD.selected_remittance_batch_id;
		r_old.factor_discount_amount         		:=				:OLD.factor_discount_amount;
		r_old.ussgl_transaction_code         		:=				:OLD.ussgl_transaction_code;
		r_old.ussgl_transaction_code_context  		:=  				:OLD.ussgl_transaction_code_context;
		r_old.doc_sequence_value             		:=  				:OLD.doc_sequence_value;
		r_old.doc_sequence_id                		:=				:OLD.doc_sequence_id;
		r_old.vat_tax_id                     		:=				:OLD.vat_tax_id;
		r_old.reference_type                 		:=				:OLD.reference_type;
		r_old.reference_id                   		:=				:OLD.reference_id;
		r_old.customer_receipt_reference     		:=				:OLD.customer_receipt_reference;
		r_old.override_remit_account_flag    		:=				:OLD.override_remit_account_flag;
		r_old.org_id                         		:=				:OLD.org_id;
		r_old.anticipated_clearing_date      		:=				:OLD.anticipated_clearing_date;
		r_old.global_attribute1              		:=				:OLD.global_attribute1;
		r_old.global_attribute2              		:=				:OLD.global_attribute2;
		r_old.global_attribute3              		:=				:OLD.global_attribute3;
		r_old.global_attribute4              		:=				:OLD.global_attribute4;
		r_old.global_attribute5              		:=				:OLD.global_attribute5;
		r_old.global_attribute6              		:=				:OLD.global_attribute6;
		r_old.global_attribute7              		:=				:OLD.global_attribute7;
		r_old.global_attribute8              		:=				:OLD.global_attribute8;
		r_old.global_attribute9              		:=				:OLD.global_attribute9;
		r_old.global_attribute10             		:=				:OLD.global_attribute10;
		r_old.global_attribute11             		:=				:OLD.global_attribute11;
		r_old.global_attribute12             		:=				:OLD.global_attribute12;
		r_old.global_attribute13             		:=				:OLD.global_attribute13;
		r_old.global_attribute14             		:=				:OLD.global_attribute14;
		r_old.global_attribute15             		:=				:OLD.global_attribute15;
		r_old.global_attribute16             		:=				:OLD.global_attribute16;
		r_old.global_attribute17             		:=				:OLD.global_attribute17;
		r_old.global_attribute18             		:=				:OLD.global_attribute18;
		r_old.global_attribute19             		:=				:OLD.global_attribute19;
		r_old.global_attribute20             		:=				:OLD.global_attribute20;
		r_old.global_attribute_category      		:=				:OLD.global_attribute_category;
		r_old.customer_bank_branch_id        		:=				:OLD.customer_bank_branch_id;
		r_old.issuer_name                    		:=				:OLD.issuer_name;
		r_old.issue_date                     		:=				:OLD.issue_date;
		r_old.issuer_bank_branch_id          		:=				:OLD.issuer_bank_branch_id;
		r_old.mrc_exchange_rate_type         		:=				:OLD.mrc_exchange_rate_type;
		r_old.mrc_exchange_rate              		:=				:OLD.mrc_exchange_rate;
		r_old.mrc_exchange_date              		:=				:OLD.mrc_exchange_date;
		r_old.payment_server_order_num       		:=				:OLD.payment_server_order_num;
		r_old.approval_code                  		:=				:OLD.approval_code;
		r_old.address_verification_code      		:=				:OLD.address_verification_code;
		r_old.tax_rate                       		:=				:OLD.tax_rate;
		r_old.actual_value_date              		:=				:OLD.actual_value_date;
		r_old.postmark_date                  		:=				:OLD.postmark_date;

	END init_old;


BEGIN

  IF  jai_cmn_utils_pkg.check_jai_exists (p_calling_object   => 'jai_ar_cash_receipts_briud_trg',
                                   p_org_id           =>  nvl(:new.org_id,:old.org_id),
                                   p_set_of_books_id  =>  :new.set_of_books_id
                                  )
      =	FALSE
  THEN
  /* India Localization funtionality is not required */
    return;
  end if;


	IF INSERTING THEN

		init_new;

	ELSIF UPDATING THEN

		init_new;
		init_old;

	ELSIF DELETING THEN

		init_old;

	END IF;

	IF    INSERTING THEN
				lv_action := jai_constants.inserting ;
	ELSIF UPDATING THEN
				lv_action := jai_constants.updating ;
	ELSIF DELETING THEN
				lv_action := jai_constants.deleting ;
	END IF ;


	OPEN c_loc_receipt_class;
	FETCH c_loc_receipt_class INTO r_loc_receipt_class;
	CLOSE c_loc_receipt_class;

	OPEN c_receipt_class(:new.receipt_method_id,
											 r_loc_receipt_class.receipt_class);
	FETCH c_receipt_class INTO lv_flag;
	CLOSE c_receipt_class;

	OPEN c_receipt_class(:old.receipt_method_id,
											 r_loc_receipt_class.receipt_class);
	FETCH c_receipt_class INTO lv_old_flag;
	CLOSE c_receipt_class;


	IF INSERTING THEN
		IF lv_flag = '1' THEN
			JAI_AR_CR_TRIGGER_PKG.ARI_T1( 	pr_old            =>  r_old         ,
								pr_new            =>  r_new         ,
								pv_action         =>  lv_action         ,
								pv_return_code    =>  lv_return_code    ,
								pv_return_message =>  lv_return_message
	 						   );
			IF lv_return_code <> jai_constants.successful   then
				 RAISE le_error;
		       END IF;
	        END IF;
	ELSIF UPDATING THEN
		IF lv_old_flag = '1' THEN
			JAI_AR_CR_TRIGGER_PKG.ARU_T1( 	pr_old            =>  r_old         ,
								pr_new            =>  r_new         ,
								pv_action         =>  lv_action         ,
								pv_return_code    =>  lv_return_code    ,
								pv_return_message =>  lv_return_message
							   );
			IF lv_return_code <> jai_constants.successful   then
				RAISE le_error;
		       END IF;
		END IF;
	ELSIF DELETING THEN
		IF lv_old_flag = '1' THEN
			JAI_AR_CR_TRIGGER_PKG.ARD_T1( 	pr_old            =>  r_old         ,
								pr_new            =>  r_new         ,
								pv_action         =>  lv_action         ,
								pv_return_code    =>  lv_return_code    ,
								pv_return_message =>  lv_return_message
  							   );
			IF lv_return_code <> jai_constants.successful   then
				RAISE le_error;
		       END IF;
		END IF;
	END IF;
	EXCEPTION
	  WHEN le_error THEN
	    fnd_file.put_line(fnd_file.log, lv_return_message);
	    fnd_message.set_name ( application => 'JA',
	                            NAME        => 'JAI_ERR_DESC'
	                           );
	    fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
	                             value => lv_return_message
	                           );
	    app_exception.raise_exception;
	  WHEN OTHERS THEN
	     fnd_file.put_line(fnd_file.log, 'Encountered the error in trigger JAI_AR_CASH_RECEIPTS_ARIUD' || substr(sqlerrm,1,1900));
	     fnd_message.set_name ( application => 'JA',
	                            NAME        => 'JAI_ERR_DESC'
	                           );
	     fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
	                             value => 'Encountered the error in trigger JAI_AR_CASH_RECEIPTS_ARIUD' || substr(sqlerrm,1,1900)
	                           );
    app_exception.raise_exception;

END;


/
ALTER TRIGGER "APPS"."JAI_AR_CR_ARIUD_T1" ENABLE;
