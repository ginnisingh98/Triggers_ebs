--------------------------------------------------------
--  DDL for Trigger PAY_ELEMENT_LINKS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ELEMENT_LINKS_T1" 
--------------------------------------------------------------------------------
/*$Header: pyeltr01.sql 120.0.12010000.3 2008/10/20 06:21:58 pparate ship $
+==============================================================================+
|			Copyright (c) 1994 Oracle Corporation		       |
|			   Redwood Shores, California, USA		       |
|			        All rights reserved.			       |
+==============================================================================+
--
Name
	Element Links trigger #1
Purpose
	To cascade effect of changes to costable type
History
	16-MAR-1994 	N Simpson    Created
	26-APR-2003 	JFord        BUG 2906032, cache bg_id before the
                                     cascading updates so DYT do not fail
        12-OCT-2005     tvankayl     Bug 4667106. The previous change was
                                     not done when costable_type is 'C'
                                     or 'F'.
        20-OCT-2008     pparate      Bug 7475365, changed the check for
	                             updating input value costed flag to
				     included 'D' along with 'F' and 'C'
				     as costed.
									*/
after update of costable_type
-- NB Costable type must not be updateable if there are date-effective updates
-- This is enforced by the form on entry. Failure to do this will cause this
-- trigger to operate incorrectly.
on "HR"."PAY_ELEMENT_LINKS_F"
for each row
--
declare
--
v_effective_date	date;
--
cursor csr_effective_date is
	select	effective_date
	from	fnd_sessions
	where	session_id	= userenv('sessionid');
--
begin
-- If the costable type is updated from costed or fixed to distributed or
-- not costed then we need to make all the link input values not costed.
--
if hr_general.g_data_migrator_mode <> 'Y' then
--
-- Bug 7475365: On updating costing type from others to Distributed,
-- input value was updated with costed flag as 'N' and this avoided the
-- distribution element to be costed. Changed condition to set costed flag
-- as 'Y' if costing type is distributed.
--
  if :old.costable_type in ('C','F','D') and :new.costable_type = 'N' then
--
  pay_core_utils.g_business_group_id := :new.business_group_id;
  update	pay_link_input_values_f
  set		costed_flag 	= 'N'
  where 	costed_flag 	= 'Y'
  and 		element_link_id = :new.element_link_id;
--
-- If the costable type is changed from non_costed or distributed to fixed or
-- costed then the pay_value will become costed.
--
-- Bug 7475365: Included 'D' along with 'F' and 'C' since distributed
-- elements are to be costed as well.
--
  elsif :old.costable_type = 'N' and :new.costable_type in ('F','C','D') then
--
  -- Get the session date
  open csr_effective_date;
  fetch csr_effective_date into v_effective_date;
--
  -- Stop if no session date exists (eg not being updated via a form)
  if csr_effective_date%notfound then
      hr_utility.set_message (801,'HR_6153_ALL_PROCEDURE_FAIL');
      hr_utility.set_message_token ('PROCEDURE','PAY_ELEMENT_LINKS_T1');
      hr_utility.raise_error;
  end if;
--
  close csr_effective_date;
--
-- Set global BG so DYnamic Trigger on child input_vals
-- has access to BG and wont fire sql on this changing record
  pay_core_utils.g_business_group_id := :new.business_group_id;

--
  update	pay_link_input_values_f LIV
  set		liv.costed_flag 	= 'Y'
  where		liv.element_link_id 	= :new.element_link_id
  and		liv.input_value_id 	=
--
	(select	iv.input_value_id
	from	pay_input_values_f	IV
	where	liv.input_value_id	= iv.input_value_id
	and	iv.name                 = 'Pay Value'
	and	v_effective_date	between	iv.effective_start_date
					and	iv.effective_end_date);
--
  end if;
end if;
--
end;

/
ALTER TRIGGER "APPS"."PAY_ELEMENT_LINKS_T1" ENABLE;
