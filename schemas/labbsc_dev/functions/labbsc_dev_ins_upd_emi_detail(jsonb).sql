-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_emi_detail(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_emi_detail(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_emi_detail(p_json jsonb, OUT p_out numeric, OUT p_ret_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
    v_transaction_id character varying(50);
	v_order_status character varying(50);
	v_transaction_date varchar(500);
	v_version_number numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_cart_id numeric;
	v_user_id numeric;
	v_invoice_number varchar(500);
	v_pan_number text;
	v_gst_number text;
	v_tax_rate varchar(50);
	v_service_type varchar(500);
	v_sac_code numeric;
	v_taxable_amount numeric;
	v_igst varchar(50);
	v_cgst varchar(50);
	v_sgst varchar(50);
	v_total_amount numeric;
	v_invoice_seq numeric;
	v_billing_name text;
	v_billing_state text;
	v_invoice_pdf_json jsonb;
	v_is_state numeric;
	v_counseller_id numeric;
	v_counseller_name varchar(500);
	v_discount_amount numeric(10,2);
	v_billing_address text;
	v_base_amount numeric;
	v_video_url text;
	v_video_title varchar(4000);
	v_email_id text;
	v_activity_id numeric;
	v_first_name text;
	v_last_name text;
	v_merchant_name varchar(500);
	v_sporview_payment numeric;
	v_emi_json jsonb;
	v_status varchar(500);
	v_order_id numeric;
	v_opt_type varchar(500);
	v_invoice_no numeric;
	 
	 
begin

/*
{
 "status": "ELS301",
 "description": "Application is disbursed",
 "UTRN": "UTIB0019192123",
 "disbursed_amount": "58000",
 "meta_data": "19002"
# This is Financepeer’s Loan Id
 "bank_name" : "IDBI Bank",
 "institute_id" : "486",
 "branch_id" : "1608",
 "student_id" : "",
 "reference1" : "",
 "reference2" : "",
 "reference3" : ""
}
*/

v_emi_json:=p_json;
select p_json->>'student_id' ,p_json->>'status',p_json->>'reference3'
into v_cart_id,v_status,v_opt_type;

v_order_status:=case when v_status='ELS301' then 'Success' else 'Fail' end;

 select c.user_id,c.pancard_number,c.gst_number,c.is_state,c.counseller_id,c.counseller_name,
	 c.activity_id,po.order_id,po.billing_details_json->>'full_name',c.updated_date,
	 po.billing_details_json->>'state'
	 as state_name
		from	labbsc_dev.labbsc_dev_cart c
	 left join labbsc_dev.labbsc_dev_purchase_order po on c.cart_id = po.cart_id
	 left join labbsc_dev.labbsc_dev_web_user wu on c.user_id=wu.user_id
	 where   c.cart_id=v_cart_id
	into v_user_id,v_pan_number,v_gst_number,v_is_state,v_counseller_id,v_counseller_name,
	 v_activity_id,v_order_id,v_billing_name,v_transaction_date,v_billing_state;
 
	update labbsc_dev.labbsc_dev_cart c
		set status = case v_order_status when 'Success' then 2 else -1 end,
		emi_json=v_emi_json,
		reference_type=v_opt_type
		 where c.cart_id = v_cart_id
		  ;
		  
		  if v_order_status ='Success' then
		  
		   select fee,taxable_amount,tax_rate,igst,cgst,sgst,product_display_name,sac_code,discount_amount,
			 base_amount,merchant_name
		from labbsc_dev.labbsc_dev_journey_activity
		where activity_id=v_activity_id
		into v_total_amount,v_taxable_amount,v_tax_rate,v_igst,
		v_cgst,v_sgst,v_service_type,v_sac_code,v_discount_amount,v_base_amount,
		v_merchant_name;
		
		if v_activity_id=8 then
		update labbsc_dev.labbsc_dev_web_user
		set module_name='Sporjo Mentor'
		where user_id=v_user_id;
		
		end if;
		if v_activity_id=7 then
		update labbsc_dev.labbsc_dev_web_user
		set module_name='Sporjo+'
		where user_id=v_user_id;
	    end if;
		
		select max(invoice_no)
		from  labbsc_dev.labbsc_dev_invoice_detail
		into v_invoice_no;
		
		v_invoice_seq:=v_invoice_no+1;
		
		v_invoice_number:= 'BCCPL/2021/'||	v_invoice_seq;
		 	 
		insert into labbsc_dev.labbsc_dev_invoice_detail
		(invoice_detail_id,user_id,pan_number,gst_number,bill_date,bill_no,transaction_id,transaction_status,invoice_id,invoice_status,
		total_amount,taxable_amount,tax_rate,igst,
		cgst,sgst,service_type,sac_code,first_name,state_name,is_state,counseller_name,
		merchant_name,activity_id,invoice_no)
		select nextval('labbsc_dev.seq_labbsc_dev_invoice_detail'),v_user_id,v_pan_number,
		v_gst_number,v_transaction_date,v_order_id,v_transaction_id,'Success',v_invoice_number ,'Success',
		v_total_amount,v_taxable_amount,v_tax_rate,v_igst,
		v_cgst,v_sgst,v_service_type,v_sac_code,v_billing_name,v_billing_state,v_is_state,v_counseller_name,
		v_merchant_name,v_activity_id,v_invoice_seq;
		
		
		if v_activity_id in (1,7,8) then
		insert into labbsc_dev.labbsc_dev_user_tests(test_id, user_id, cart_id, valid_till, is_attempted, created_date, updated_date)
				select nextval('labbsc_dev.seq_labbsc_dev_user_test_id'), v_user_id, v_cart_id, v_current_timestamp + '1 year'::interval, 0, v_current_timestamp, v_current_timestamp;
				
				if not exists(select 1 from labbsc_dev.labbsc_dev_user_newsletter_subscription
								where user_id = v_user_id) then
					
					insert into labbsc_dev.labbsc_dev_user_newsletter_subscription(user_id, cart_id, valid_till, created_date, updated_date)
					select v_user_id, v_cart_id, v_current_timestamp + '1 year'::interval, v_current_timestamp, v_current_timestamp;
					
			 end if;
		end if;

		
		select row_to_json(row)
		from (select v_pan_number as pan_number, v_gst_number as gst_number,
		v_transaction_date as  bill_date, v_order_id as  bill_no,v_transaction_id as  transaction_id,
		'Success' as transaction_status,
		v_invoice_number as invoice_id,
		'Success' as  invoice_status,
		v_total_amount as total_amount,v_taxable_amount as  taxable_amount,v_tax_rate as  tax_rate,
		v_igst as igst,
		v_cgst as cgst,v_sgst as sgst,v_merchant_name as service_type,v_sac_code as sac_code,
		v_billing_name as billing_name,
		v_billing_state	as state_name,
			  v_is_state as is_state, 
			  v_counseller_name as counseller_name,
			  v_discount_amount as discount_amount,
			  v_billing_address as billing_address,
			  v_base_amount as base_amount
           ) row
		into v_invoice_pdf_json;
		 
		
		end if;
		
		
		/*select row_to_json(row)
		from (select v_order_status as order_status, 
			  v_counseller_id as counselor_id,
			  v_counseller_name as counselor_name,
			  v_invoice_pdf_json as invoice_pdf_json,
			  v_video_title as video_title,
			  v_video_url as video_url,
			  v_billing_name as candidate_name,
			  v_user_id as candidate_id,
			  v_email_id as candidate_email,
			  v_transaction_date as  purchase_date
			  ) row
		into p_ret_json;*/
		
		select row_to_json(row)
		from (select v_order_status as order_status, page_flag, email_subject,
			  v_counseller_id as counselor_id,
			  v_counseller_name as counselor_name,
			  v_invoice_pdf_json as invoice_pdf_json,
			  v_video_title as video_title,
			  v_video_url as video_url,
			  v_billing_name as candidate_name,
			  v_user_id as candidate_id,
			  v_email_id as candidate_email,
			  v_transaction_date as  purchase_date
			  from labbsc_dev.labbsc_dev_purchase_order
			  where order_id = v_order_id) row
		into p_ret_json;
		
		
		p_out := 1;
		  

end;
$$;


--
