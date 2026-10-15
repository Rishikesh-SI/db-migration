-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_product_cart_payment_refund(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_product_cart_payment_refund(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_product_cart_payment_refund(p_payjson jsonb, OUT p_result numeric, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
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
		v_stock_increase numeric;
		v_response numeric;
		v_updated_by numeric;
		v_refund_reason text;
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
                v_payment_json->'data'->>'mer_amount',
                v_payment_json->'data'->>'trans_date',
				v_payment_json->'data'->>'billing_email',
				v_payment_json->'data'->>'billing_tel',
				v_payment_json->'data'->>'user_guid' ,
				v_payment_json->'data'->>'stock_increase',
				v_payment_json->'data'->>'updated_by',
				v_payment_json->'data'->>'refund_reason'
           into v_product_cart_id,
                v_tracking_id,
                v_bank_ref_no,
                v_order_status,
                v_failure_message,
                v_payment_mode,
                v_card_name,
                v_status_code,
                v_status_message,
                v_amount,
                v_trans_date ,
				v_billing_email,
				v_billing_tel,
				v_user_guid,
				v_stock_increase,
				v_updated_by,
				v_refund_reason;
				
		 if exists(select 1 from labmi.labmi_product_cart_paydetails
			  where tracking_id = v_tracking_id and lower(order_status) = lower(v_order_status) ) then			  			  
			v_response := 1;
		
		else
			v_response := 0;

		end if;		
				
	
           --  v_payment_guid := uuid_generate_v4();	
			v_is_status_flag := case when lower(v_order_status)=lower('Partialrefund') then 1
			   					 else 3 end ;
			
				 
			if  v_tracking_id is not null  then	
		
				if lower (v_order_status)= lower('REFUND') or lower (v_order_status)= lower('PARTIALREFUND') then

					insert into labmi.labmi_product_cart_paydetails_refund 
					select product_cart_paydetails_id,product_cart_id,tracking_id,bank_ref_no,
							order_status,failure_message,payment_mode,card_name,status_code,status_message,
							amount,payment_json,transaction_date,payment_guid,created_date,updated_date,
							created_by,updated_by,is_active,is_deleted,favcy_responce_status,favcy_responce_status_json,
							is_status_flag,user_guid,response_count,invoice_id,is_mail_sent 
					from labmi.labmi_product_cart_paydetails
					where tracking_id = v_tracking_id;

				end if;
				
		
			update labmi.labmi_product_cart_paydetails
			set  order_status = v_order_status, 
				 failure_message = v_failure_message,  
				 status_code =  v_status_code,
				 status_message = v_status_message,  
				 payment_json = v_payment_json,
				 updated_date = v_sysdate, 
				 created_by = v_updated_by, 
				 updated_by = v_updated_by, 
				 is_active =  case when lower(v_order_status)=lower('PARTIALREFUND') then 1
				 			  else 0 end 	, 
				 is_deleted = case when lower(v_order_status)=lower('PARTIALREFUND') then 0
				 			  else 1 end ,
				 is_status_flag = v_is_status_flag,
				 is_mail_sent = 0,
				 refund_reason = v_refund_reason
			where tracking_id = v_tracking_id;	
			
			select user_guid,product_cart_id into v_user_guid,v_product_cart_id from labmi.labmi_product_cart_paydetails
			where tracking_id = v_tracking_id;
			

        end if ;
		
				select product_id
				into v_product_id
				from labmi.labmi_product_cart
				where user_guid= v_user_guid and product_cart_id=v_product_cart_id;
		
		if lower (v_order_status)= lower('REFUND') then
											
				update labmi.labmi_product_cart
				set expiry_date = null,is_active = 0,is_deleted=1
	    		where user_guid= v_user_guid and product_cart_id = v_product_cart_id;
				
				update labmi.labmi_web_user
				set campaign_id = 1,
					membership_start_date = null
				where user_guid= v_user_guid ;
				
				update labmi.labmi_product_inventory
				set stock_quantity=stock_quantity + 1
				where product_id=v_product_id;
				
				update labmi.labmi_product_cart_details
				set is_active=0 ,is_deleted=1,is_return=1
				where product_id=v_product_id and product_cart_id =v_product_cart_id;
				
		elseif lower (v_order_status)= lower('PARTIALREFUND') then
				
 
				update labmi.labmi_product_cart
				set total_price = (total_price - v_amount::numeric)
	    		where user_guid= v_user_guid and product_cart_id = v_product_cart_id ;
				
					if v_stock_increase = 1 then

						update labmi.labmi_product_inventory
						set stock_quantity=stock_quantity + 1
						where product_id=v_product_id;
			

					end if;
				
		end if;
		

				

				select row_to_json(tab)  from(
		select wu.email_id as user_email,wu.user_full_name as user_name,p.product_name,pp.payment_guid as invoice_guid,
				pa.expiry_date, case when lower(v_order_status)= lower('REFUND') then 'REFUND'
							  when lower(v_order_status)= lower('PARTIALREFUND') then 'PARTIALREFUND'
					else 'transaction failed' end as error,p.product_id,pp.is_mail_sent,pp.tracking_id
		from labmi.labmi_web_user wu
		left join  labmi.labmi_product_cart pa on wu.user_guid=pa.user_guid
		left join labmi.labmi_product p on pa.product_id=p.product_id
		left join labmi.labmi_product_cart_paydetails pp on pa.product_cart_id = pp.product_cart_id
		where wu.user_guid = v_user_guid and pp.tracking_id = v_tracking_id )tab 
		into p_tran_json ;

				p_tran_status:= 1;
   
        
		p_result := 1;

		p_tran_json:=jsonb_set(p_tran_json,'{response}',coalesce(v_response::text::jsonb,null));
	

END;

    

$$;


--
