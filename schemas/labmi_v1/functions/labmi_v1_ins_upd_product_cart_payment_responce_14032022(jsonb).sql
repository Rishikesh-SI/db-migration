-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_ins_upd_product_cart_payment_responce_14032022(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_upd_product_cart_payment_responce_14032022(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_ins_upd_product_cart_payment_responce_14032022(p_payjson jsonb, OUT p_result numeric, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
		v_sysdate  timestamp; 
        v_product_cart_paydetailsid numeric;
        v_product_cart_id numeric;
        v_tracking_id numeric;
        v_bank_ref_no character varying(500);
        v_order_status  character varying(50);
        v_failure_message text;
        v_payment_mode character varying(500);
        v_card_name  character varying(500);
        v_status_code  character varying(50);
        v_status_message text;
        v_amount  decimal;
        v_payment_json jsonb;
        v_payment_guid character varying(500);
        v_trans_date timestamp;
		m record;
		v_billing_email character varying(500);
		v_billing_tel numeric;
		v_auth_token text;
		
		v_email_id character varying(1000);
		v_mobile_no character varying(1000); 
		v_is_status_flag numeric ;
		v_user_full_name character varying(500);
		v_user_guid character varying(1000);
		v_product_id numeric;
		v_product_inv_code text;
		v_random_num numeric;
		v_invoice_id varchar(50);
		v_inv_json jsonb;
		v_response numeric;
		v_campaign_id numeric;
		v_coupon_code varchar(250);
BEGIN

     v_payment_json :=p_payjson;
     
		select current_timestamp at time zone 'utc' 
		into   v_sysdate;		
        
        
        select 	v_payment_json->'data'->>'order_id',
                v_payment_json->'data'->>'tracking_id',
                v_payment_json->'data'->>'bank_ref_no',
                v_payment_json->'data'->>'order_status',
                v_payment_json->'data'->>'response_code',
                v_payment_json->'data'->>'payment_mode',
                v_payment_json->'data'->>'card_name',
                v_payment_json->'data'->>'status_code',
                v_payment_json->'data'->>'status_message',
                v_payment_json->'data'->'amount',
                v_payment_json->'data'->>'trans_date',
				v_payment_json->'data'->>'billing_email',
				v_payment_json->'data'->>'billing_tel',
				v_payment_json->'data'->>'user_guid'                
           into v_product_cart_id,
                v_tracking_id,
                v_bank_ref_no,
                v_order_status,
                v_failure_message,
                v_payment_mode,
                v_card_name,
                v_status_code,
                v_status_message
                v_amount,
                v_trans_date ,
				v_billing_email,
				v_billing_tel,
				v_user_guid ;
				
			select v_payment_json->'data'->>'user_guid' into v_user_guid;	
      
	 -- raise notice '% test 1' ,v_user_guid;
	 -- select 1/0;
	 
	 if exists(select 1 from labmi_v1.labmi_v1_product_cart_paydetails
			  where tracking_id = v_tracking_id and lower(order_status) = lower(v_order_status) ) then
			  
			  
		v_response := 1;
		
		select payment_guid into v_payment_guid from labmi_v1.labmi_v1_product_cart_paydetails
		where tracking_id = v_tracking_id and lower(order_status) = lower(v_order_status);
		
	else
	
	    v_response := 0;
		v_payment_guid := uuid_generate_v4();
	end if;
	
	
     if not exists (select 1 from labmi_v1.labmi_v1_product_cart_paydetails
				where tracking_id = v_tracking_id and (lower (order_status)= lower('REFUND') or
													  lower (order_status)= lower('PARTIALREFUND'))) then
				
      		 v_product_cart_paydetailsid  := nextval('labmi_v1.seq_labmi_v1_product_cart_paydetails_id');	
			v_is_status_flag := case when lower(v_order_status)=lower('SUCCESS') then 1
               						when lower(v_order_status)=lower('Failed') then 0
									when lower(v_order_status)=lower('SI-Initiated') then 2 
									when lower(v_order_status)=lower('AWAITED') then 2 
			   					    else 0 end ;
									
		raise notice '%',v_user_guid;
		raise notice '%',v_tracking_id;
		raise notice '%',v_order_status;
		
		if 	v_user_guid is not null and v_tracking_id is not null and lower(v_order_status) = lower('SI-Initiated') then
		

		
		if not exists (select 1 from labmi_v1.labmi_v1_product_cart_paydetails
					   where user_guid = v_user_guid and (lower (order_status)= lower('SUCCESS') 
					   or lower(order_status) = lower('SI-Initiated') or lower(order_status) = lower('AWAITED')) )then 
		
		  
            insert into labmi_v1.labmi_v1_product_cart_paydetails
            (product_cart_paydetails_id,
             product_cart_id, 
             tracking_id, 
             bank_ref_no, 
             order_status, 
             failure_message,  
             payment_mode, 
             card_name, 
             status_code,
             status_message,  
             amount, 
             payment_json,
             transaction_date,
             payment_guid, 
             created_date, 
             updated_date, 
             created_by, 
             updated_by, 
             is_active, 
             is_deleted,
			 is_status_flag,
			 user_guid,
			 is_mail_sent
	)
            
            values ( v_product_cart_paydetailsid, 
                  	 v_product_cart_id, 
                     v_tracking_id, 
                  v_bank_ref_no, 
                  v_order_status,
            	  v_failure_message,
                  v_payment_mode,
                  v_card_name, 
                  v_status_code, 
                  v_status_message,
                  v_amount,
          		  v_payment_json, 
                  v_trans_date, 
                  v_payment_guid, 
                  v_sysdate, 
                  v_sysdate, 
                  1 , 
                  1, 
                  0, 
                  0,
				 v_is_status_flag,
				 v_user_guid,
				  0 );
				 
				else
						p_tran_status := 0;

				end if;		
				 
		elseif  v_tracking_id is not null  then	
		
				if lower (v_order_status)= lower('REFUND') then

				insert into labmi_v1.labmi_v1_product_cart_paydetails_refund 
				select * from labmi_v1.labmi_v1_product_cart_paydetails
				where tracking_id = v_tracking_id;

				end if;
				
		  if not exists (select 1 from labmi_v1.labmi_v1_product_cart_paydetails
					where tracking_id = v_tracking_id and (lower (order_status)= lower('REFUND') or
													  lower (order_status)= lower('PARTIALREFUND')) ) then
		
			update labmi_v1.labmi_v1_product_cart_paydetails
			set  bank_ref_no = v_bank_ref_no, 
				 order_status = v_order_status, 
				 failure_message = v_failure_message,  
				 payment_mode =  v_payment_mode, 
				 card_name =  v_card_name, 
				 status_code =  v_status_code,
				 status_message = v_status_message ,  
				 amount = v_amount, 
				 payment_json = v_payment_json,
				 transaction_date = v_trans_date ,
				 payment_guid = v_payment_guid, 
				 created_date = v_sysdate, 
				 updated_date = v_sysdate, 
				 created_by = 1, 
				 updated_by =1 , 
				 is_active =  case when lower(v_order_status)=lower('SUCCESS') then 1
				 			  else 0 end 	, 
				 is_deleted = case when lower(v_order_status)=lower('SUCCESS') then 0
				 					when lower(v_order_status)in (lower('AWAITED'))then 0
				 			  else 1 end ,
				 is_status_flag = v_is_status_flag
			where tracking_id = v_tracking_id;	
			
			select user_guid,product_cart_id into v_user_guid,v_product_cart_id from labmi_v1.labmi_v1_product_cart_paydetails
			where tracking_id = v_tracking_id;
			
		end if;	

        end if ;
		
		if lower (v_order_status)= lower('REFUND') then
			
				select product_id,product_cart_id 
				into v_product_id,v_product_cart_id
				from labmi_v1.labmi_v1_product_cart
				where user_guid= v_user_guid and is_active = 1
       			and is_deleted = 0;
				
				update labmi_v1.labmi_v1_product_cart
				set expiry_date = null,is_active = 0,
       			is_deleted = 1
	    		where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_web_user
				set campaign_id = 1,
					membership_start_date = null
				where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_product_inventory
				set stock_quantity=stock_quantity + 1
				where product_id=v_product_id;

		end if;
		
		
		
		if lower(v_order_status)=lower('SUCCESS') then
				
				-- select 1/0;
				
				select product_id
				into v_product_id
				from labmi_v1.labmi_v1_product_cart
				where user_guid= v_user_guid and product_cart_id =v_product_cart_id ;
				
				select product_code into v_product_inv_code 
				from labmi_v1.labmi_v1_product
				where product_id=v_product_id ;
				
				
				-- select floor(100 + random() * 899) into v_random_num;
				
				v_invoice_id:=v_product_inv_code||v_product_cart_id ;
				
				update labmi_v1.labmi_v1_product_cart
				set expiry_date = '2022-02-28'::timestamp
	    		where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_web_user
				set campaign_id = v_product_id,
					membership_start_date = v_sysdate
				where user_guid= v_user_guid;
				
				update labmi_v1.labmi_v1_product_cart_paydetails
				set invoice_id=v_invoice_id
				where tracking_id = v_tracking_id;
				
				update labmi_v1.labmi_v1_product_inventory
				set stock_quantity=stock_quantity - 1
				where product_id=v_product_id;
				
				
				if not exists(select 1 from labmi_v1.labmi_v1_membership_coupon_code
							  where user_guid = v_user_guid and product_id = v_product_id and is_used = 1) then
							  
						select coupon_code into v_coupon_code 
						from labmi_v1.labmi_v1_membership_coupon_code 
						where product_id = v_product_id and is_used = 0
						order by coupon_code_id
						limit 1;
						
						update labmi_v1.labmi_v1_membership_coupon_code
						set is_used = 1,
							allocated_date = v_sysdate,
							user_guid = v_user_guid
						where coupon_code = v_coupon_code and product_id = v_product_id;
				else
						
						 select coupon_code into v_coupon_code 
						 from labmi_v1.labmi_v1_membership_coupon_code 
						 where user_guid = v_user_guid and product_id = v_product_id and is_used = 1;
						
				end if;	
				
				
				
				
					select to_jsonb(tab)::jsonb from (
					select 
					'27AADCR8195F1Z0' as gst_no,
					a.shipment_name,
					b.invoice_id as Invoice_No,
					a.total_amount,
					round(a.taxes,2) as gst_amt,	
					round(a.taxes/2,2) as CGST,
					round(a.taxes/2,2) as SGST,	
					b.bank_ref_no as transaction_id,	
					(a.total_amount - round(a.taxes,2)) as amount,
					-- d.expiry_date::date,
					d.expiry_date::date expiry_date	,
					-- c.membership_start_date::date Date_of_Issue,
					to_char(c.membership_start_date::date, 'DD-MM-YYYY') Date_of_Issue,
					to_char(d.expiry_date::date, 'DD-MM-YYYY') expiry_date_1,		
					case when e.product_id in(3,4) then '18%'
						when e.product_id in(5,6) then '28%' end as gst_percentage,
					e.product_name,
					case e.product_id  when 3 then 846.60
						when 4 then 2541.52 end as product_base_amt,
					case e.product_id  when 3 then 999
						when 4 then 2999 end as product_actual_amt,		
					d.discount_percent as discount_percentage
						
					from labmi_v1.labmi_v1_product_shipment_user a
					join labmi_v1.labmi_v1_product_cart_paydetails b on a.product_cart_id=b.product_cart_id
					join labmi_v1.labmi_v1_web_user c on c.user_guid=b.user_guid
					join labmi_v1.labmi_v1_product_cart d on  d.product_cart_id=a.product_cart_id
													and d.user_guid=c.user_guid
					join labmi_v1.labmi_v1_product e on 	e.product_id=d.product_id	
					where 
					upper(status_message)='SUCCESS' 
					and status_code='000' and b.tracking_id = v_tracking_id and b.user_guid = v_user_guid 
					)tab into v_inv_json;
				
		elseif  lower(v_order_status)= lower('CANCELLED') 
				or lower(v_order_status)= lower('FAILED')  then
				
				select campaign_id into  v_campaign_id from labmi_v1.labmi_v1_web_user 
				where user_guid= v_user_guid;
		
				update labmi_v1.labmi_v1_web_user
				set campaign_id = 1,
					membership_start_date = null
				where user_guid= v_user_guid;
								
		end if;
			
	   
	   
	   if lower(v_order_status)=lower('SUCCESS') 
	   or lower(v_order_status) = lower('SI-Initiated') 
	   or lower(v_order_status) = lower('AWAITED')
	   then 

		/* for m in (select product_sku_id,quantity from  labmi_v1.labmi_v1_product_cart_details 
                                where product_cart_id=v_product_cart_id
                                and is_active=1)
         LOOP
        
		 update labmi_v1.labmi_v1_product_inventory
		 set stock_quantity=(stock_quantity - m.quantity)
		 where product_sku_id=m.product_sku_id;
		
		
         END LOOP;*/
		
		begin
		
		
			select user_guid into v_user_guid from labmi_v1.labmi_v1_product_cart_paydetails
			where tracking_id = v_tracking_id;
		/*select auth_token ,email_id,mobile_no into v_auth_token , v_email_id,v_mobile_no
		from labmi_v1.labmi_v1_web_user where user_guid = (select user_cart_guid
		from labmi_v1.labmi_v1_product_cart where product_cart_id = v_product_cart_id and is_login_user = 1);*/
		select row_to_json(tab)  from(
		select wu.email_id as user_email,wu.user_full_name as user_name,
			p.product_name,pp.payment_guid as invoice_guid,p.product_id,pp.is_mail_sent,
			pp.tracking_id,pa.membership_owner,pa.name_on_card ,to_char(pa.expiry_date::date, 'DD-MM-YYYY') expiry_date,
			/*pa.expiry_date::date,*/v_coupon_code as coupon_code,wu.user_guid
		from labmi_v1.labmi_v1_web_user wu
		left join  labmi_v1.labmi_v1_product_cart pa on wu.user_guid=pa.user_guid
		left join labmi_v1.labmi_v1_product p on pa.product_id=p.product_id
		left join labmi_v1.labmi_v1_product_cart_paydetails pp 
		on pa.product_cart_id = pp.product_cart_id
		where wu.user_guid = v_user_guid and tracking_id = v_tracking_id)tab 
		into p_tran_json ;
		
		 if lower(v_order_status)=lower('SUCCESS') then
		
		 p_tran_json:=jsonb_set(p_tran_json,'{invoice_data}',coalesce(v_inv_json,null));
		 
		 end if;
		
		-- raise notice '%',v_product_cart_id;
		
		
          /*row_to_json(tab)  from (
           select -- v_tracking_id as transactionID,
		    --v_billing_email as user_email,
		   -- v_billing_tel as user_mobile, 
		    -- 4 as delivery_method,
		   --  v_auth_token as auth_token,
		    -- 6 as coupon_code,
			v_email_id  as user_email,
			-- v_mobile_no as user_mobile,
			v_user_full_name as user_name,
           (select array_to_json(array_agg(row)) from (
           select a.quantity,b.product_id,a.product_price
           from labmi_v1.labmi_v1_product_cart_details a
           join labmi_v1.labmi_v1_product_sku b on a.product_sku_id=b.product_sku_id
		   join labmi_v1.labmi_v1_product_cart c on a.product_cart_id=c.product_cart_id
		   join labmi_v1.labmi_v1_product p on c.product_id=p.product_id  
           where a.product_cart_id = c.product_cart_id and c.user_guid = v_user_guid
           and a.is_active=1)row) as products
           )tab into p_tran_json*/ 
	   
	   p_tran_status:=1;
	   
	 
	   
		exception
			when no_data_found then
				p_tran_json := '{"error":"transaction failed"}';
				p_tran_status:=0;
		end;
		
		/* update labmi_v1.labmi_v1_product_cart
		 set is_active=0,payment_status=1
		 where product_cart_id=v_product_cart_id;
		
		 update labmi_v1.labmi_v1_product_cart_details
		 set is_active=0
		 where product_cart_id=v_product_cart_id;*/
		
		-- p_tran_status:=1;
		else 
				-- p_tran_json := '{"error":"transaction failed"}';
				
				/*select row_to_json(tab)  from(
				select wu.email_id as user_email,wu.user_full_name as user_name,
					p.product_name,pa.expiry_date,'transaction failed' as error
				from labmi_v1.labmi_v1_web_user wu
				left join  labmi_v1.labmi_v1_product_cart pa on wu.user_guid=pa.user_guid
				left join labmi_v1.labmi_v1_product p on pa.product_id=p.product_id
				where wu.user_guid = v_user_guid)tab 
				into p_tran_json ;*/
				
				
				select row_to_json(tab)  from(
		select wu.email_id as user_email,wu.user_full_name as user_name,p.product_name,
				pa.expiry_date, case when lower(v_order_status)= lower('REFUND') then 'REFUND'
					else 'transaction failed' end as error,p.product_id,pp.is_mail_sent,pp.tracking_id,
					case when v_campaign_id is null then 0 else 1 end as already_exists
		from labmi_v1.labmi_v1_web_user wu
		left join  labmi_v1.labmi_v1_product_cart pa on wu.user_guid=pa.user_guid
		left join labmi_v1.labmi_v1_product p on pa.product_id=p.product_id
		left join labmi_v1.labmi_v1_product_cart_paydetails pp on pa.product_cart_id = pp.product_cart_id
		where wu.user_guid = v_user_guid and tracking_id = v_tracking_id )tab 
		into p_tran_json ;

				p_tran_status:=0;
       end if;
        
		p_result := 1;
		
		p_tran_json:=jsonb_set(p_tran_json,'{response}',coalesce(v_response::text::jsonb,null));
		
		
	else
		
		
		p_result := 1;
		v_response := 1;
		p_tran_json:=jsonb_set(p_tran_json,'{response}',coalesce(v_response::text::jsonb,null));

	end if;
	
	

END;

    

$$;


--
