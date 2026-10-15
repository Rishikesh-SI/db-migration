-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_order_payment(numeric, jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_order_payment(numeric, jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_order_payment(p_order_id numeric, p_payment_json jsonb, OUT p_result numeric, OUT p_json jsonb) RETURNS record
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
	v_invoice_no numeric;
	v_sporview_payment numeric;
	v_addline_1 text;
	v_addline_2 text;
	v_state text;
	v_country text;
	v_city  text;
	v_pin text;
	v_user_guid text;
	v_max_invoice_no numeric;
begin
	
	if exists(select 1 from labbsc_dev.labbsc_dev_purchase_order where order_id = p_order_id) then
			select p_payment_json->>'tracking_id', p_payment_json->>'order_status', p_payment_json->>'trans_date',
		p_payment_json->>'billing_name',p_payment_json->>'billing_state',p_payment_json->>'billing_address'
		into v_transaction_id, v_order_status, v_transaction_date,v_billing_name,v_billing_state,v_billing_address;
	
	---raise notice '%',v_is_state;
----	select 1/0;
	
		select max(version_number)
		into v_version_number
		from labbsc_dev.labbsc_dev_order_payment
		where order_id = p_order_id
		and transaction_id = v_transaction_id;
		
		v_version_number := coalesce(v_version_number,0) + 1;
		
		insert into labbsc_dev.labbsc_dev_order_payment(payment_id, order_id, transaction_id, payment_details, status, payment_date, version_number,
												created_date, updated_date)
		select nextval('labbsc_dev.seq_labbsc_dev_order_payment_id'), p_order_id, v_transaction_id, p_payment_json, v_order_status, v_transaction_date,
				v_version_number, v_current_timestamp, v_current_timestamp;
		
		
	select c.cart_id,c.user_id,c.pancard_number,c.gst_number,c.is_state,c.counseller_id,c.counseller_name,
	 v.title_alias  ,v.title,c.activity_id,
	 po.billing_details_json->>'address1',
	 po.billing_details_json->>'address2',
	 po.billing_details_json->>'state',
	 po.billing_details_json->>'country',
	  po.billing_details_json->>'city',
	   po.billing_details_json->>'zip'
		from	labbsc_dev.labbsc_dev_cart c
	   join labbsc_dev.labbsc_dev_purchase_order po
		on po.cart_id = c.cart_id  
		left join labbsc_dev.labbsc_dev_video v
		on v.video_id=c.video_id
	where   po.order_id = p_order_id
	into v_cart_id,v_user_id,v_pan_number,v_gst_number,v_is_state,v_counseller_id,v_counseller_name,
	v_video_url,v_video_title,v_activity_id, v_addline_1,v_addline_2,
	v_state,v_country,v_city,v_pin;
	
	if lower(v_order_status) in ('captured','success')
	then
	 v_order_status:='Success';
	end if;
 
		update labbsc_dev.labbsc_dev_cart c
		set status = case v_order_status when 'Success' then 2 else -1 end
		 where c.cart_id = v_cart_id
		and useR_id =v_user_id
		 ;
		 
		 if v_activity_id=1 and v_order_status='Success' then
		 
		 update labbsc_dev.labbsc_dev_cart c
		set status = 2
		 where activity_id=5
		and useR_id =v_user_id
		 ;
		 
		 
		 end if;
		 
		  if v_activity_id in (7,16,17,18) and v_order_status='Success' then
		 
		 update labbsc_dev.labbsc_dev_web_user
		set module_name='Sporjo Plus'
		 where   useR_id =v_user_id
		 ;
		  end if;
		   if v_activity_id=8 and v_order_status='Success' then
		 
		 update labbsc_dev.labbsc_dev_web_user
		set module_name='Sporjo Mentor'
		 where   useR_id =v_user_id
		 ;
		  end if;
		  
		   if v_activity_id in (10,11) and v_order_status='Success' then
		 
		 update labbsc_dev.labbsc_dev_web_user
		set module_name='Sporjo Coach'
		 where   useR_id =v_user_id
		 ;
		  end if;
		 
		 
		 
		 if v_order_status <>'Success' then
		 update labbsc_dev.labbsc_dev_pending_order  
		set status = case v_order_status when 'Success' then 2 else -1 end,
		updated_date=v_current_timestamp
		 where cart_id = v_cart_id
		 and order_id=p_order_id;
		 else
		 
		 update labbsc_dev.labbsc_dev_pending_order  
		set status = case v_order_status when 'Success' then 2 else -1 end,
		updated_date=v_current_timestamp
		 where cart_id = v_cart_id;
		 
		 end if;
		 
		 begin
		 select email_id,first_name,last_name,user_guid
		 from labbsc_dev.labbsc_dev_web_user
		 where user_id=v_user_id
		 into v_email_id,v_first_name,v_last_name,v_user_guid;
		  
		 
		 exception
		 when no_data_found then
		 v_email_id:=null;
		 end;
		
		
		
		
		if (v_order_status = 'Success' and
			v_cart_id is not null and
			v_user_id is not null  
		   )
		then
		
		
		
		 if v_activity_id in (1,7,8,9,10,11,13,14,16,17,18) then
		 if v_activity_id =1 then
		 select count(1)
		from labbsc_dev.labbsc_dev_cart
		where activity_id=5
		and user_id=v_user_id
		and status=2
		into v_sporview_payment;
		
		---raise notice '%',v_sporview_payment;
		
		if v_sporview_payment >0
		then v_activity_id:=6;
		end if;
		end if;
		
		---raise notice '%',v_activity_id;
		
			insert into labbsc_dev.labbsc_dev_user_tests(test_id, user_id, cart_id, valid_till, is_attempted, created_date, updated_date)
				select nextval('labbsc_dev.seq_labbsc_dev_user_test_id'), v_user_id, v_cart_id, v_current_timestamp + '1 year'::interval, 0, v_current_timestamp, v_current_timestamp;
				
				if not exists(select 1 from labbsc_dev.labbsc_dev_user_newsletter_subscription
								where user_id = v_user_id) then
					
					insert into labbsc_dev.labbsc_dev_user_newsletter_subscription(user_id, cart_id, valid_till, created_date, updated_date)
					select v_user_id, v_cart_id, v_current_timestamp + '1 year'::interval, v_current_timestamp, v_current_timestamp;
					
			 end if;
			 end if;
			 
			 select fee,taxable_amount,tax_rate,igst,cgst,sgst,product_display_name,sac_code,discount_amount,
			 base_amount,merchant_name
		from labbsc_dev.labbsc_dev_journey_activity
		where activity_id=v_activity_id
		into v_total_amount,v_taxable_amount,v_tax_rate,v_igst,
		v_cgst,v_sgst,v_service_type,v_sac_code,v_discount_amount,v_base_amount,
		v_merchant_name;
		
		 /*SELECT TO_CHAR(nextval('labbsc_dev.seq_invoice_id'),'fm000')
		into v_invoice_seq;	*/
		
		select max(invoice_no)
		from  labbsc_dev.labbsc_dev_invoice_detail
		into v_invoice_no;
		v_invoice_seq:=v_invoice_no+1;
		
		v_invoice_number:= 'BCCPL/2021/'||	v_invoice_seq;
		 	 
		insert into labbsc_dev.labbsc_dev_invoice_detail
		(invoice_detail_id,user_id,pan_number,gst_number,bill_date,bill_no,transaction_id,transaction_status,invoice_id,invoice_status,
		total_amount,taxable_amount,tax_rate,igst,
		cgst,sgst,service_type,sac_code,first_name,state_name,is_state,counseller_name,
		merchant_name,invoice_no)
		select nextval('labbsc_dev.seq_labbsc_dev_invoice_detail'),v_user_id,v_pan_number,
		v_gst_number,v_transaction_date,p_order_id,v_transaction_id,'Success',v_invoice_number ,'Success',
		v_total_amount,v_taxable_amount,v_tax_rate,v_igst,
		v_cgst,v_sgst,v_service_type,v_sac_code,v_billing_name,v_billing_state,v_is_state,v_counseller_name,
		v_merchant_name,v_invoice_seq;

		
		select row_to_json(row)
		from (select v_pan_number as pan_number, v_gst_number as gst_number,
		v_transaction_date as  bill_date, p_order_id as  bill_no,v_transaction_id as  transaction_id,
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
			  v_base_amount as base_amount,
			  v_addline_1 as address_line1,
			v_addline_1 as address_line2,
			v_city as city,
			v_pin as pin,
			v_state as state_name,
			v_country as country
           ) row
		into v_invoice_pdf_json;
		 
		
		end if;
		
		
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
			  v_transaction_date as  purchase_date,
			  v_first_name as first_name,
			  v_last_name as last_name
			  from labbsc_dev.labbsc_dev_purchase_order
			  where order_id = p_order_id) row
		into p_json;
		
		p_result := 1;
		
	else
		
		p_result := 0;
		
	end if;
	
-- exception
-- 	when others then
-- 		p_result := -1;
	
end;
$$;


--
