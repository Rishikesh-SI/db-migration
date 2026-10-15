-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_ins_upd_product_cart_payment_responce(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_product_cart_payment_responce(jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_ins_upd_product_cart_payment_responce(p_payjson jsonb, OUT p_result numeric, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
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
		
		v_email_id character varying(500);
		v_mobile_no numeric ;
		v_is_status_flag numeric ;
BEGIN

     v_payment_json :=p_payjson;
     
		select current_timestamp at time zone 'utc' 
		into   v_sysdate;		
        
        
        select 	v_payment_json->'data'->>'order_id',
                v_payment_json->'data'->>'tracking_id',
                v_payment_json->'data'->>'bank_ref_no',
                v_payment_json->'data'->>'order_status',
                v_payment_json->'data'->>'failure_message',
                v_payment_json->'data'->>'payment_mode',
                v_payment_json->'data'->>'card_name',
                v_payment_json->'data'->>'status_code',
                v_payment_json->'data'->>'status_message',
                v_payment_json->'data'->'amount',
                v_payment_json->'data'->>'trans_date',
				v_payment_json->'data'->>'billing_email',
				v_payment_json->'data'->>'billing_tel'
                
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
				v_billing_tel;
      
	  -- raise notice '% test 1' ,v_status_message;
	 -- select 1/0;
	  
	  
      		 v_product_cart_paydetailsid  := nextval('dd.seq_dd_product_cart_paydetails_id');
            v_payment_guid := uuid_generate_v4();	
			v_is_status_flag := case 
               when v_order_status='Success' then 1
               when v_order_status='Awaited' then 2 else 0 end ;
			
            
            insert into dd.dd_product_cart_paydetails
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
			 is_status_flag
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
                  1, 
                  0,
				v_is_status_flag);
       
      
            
       -- end if ;
	   
	   
	   if v_order_status='Success'
	   then 

		 for m in (select product_sku_id,quantity from  dd.dd_product_cart_details 
                                where product_cart_id=v_product_cart_id
                                and is_active=1)
         LOOP
        
		 update dd.dd_product_inventory
		 set stock_quantity=(stock_quantity - m.quantity)
		 where product_sku_id=m.product_sku_id;
		
		
         END LOOP;
		
		begin
		
		select auth_token ,email_id,mobile_no into v_auth_token , v_email_id,v_mobile_no
		from dd.dd_web_user where user_guid = (select user_cart_guid
		from dd.dd_product_cart where product_cart_id = v_product_cart_id and is_login_user = 1);
		
		select  
          row_to_json(tab)  from (
           select v_tracking_id as transactionID,
		    v_billing_email as user_email,
		    v_billing_tel as user_mobile, 
		    -- 4 as delivery_method,
		    v_auth_token as auth_token,
		    -- 6 as coupon_code,
			v_email_id  as user_email,
			v_mobile_no as user_mobile,																									
           (select array_to_json(array_agg(row)) from (
           select a.quantity,b.product_id,a.product_price
           from dd.dd_product_cart_details a
           join dd.dd_product_sku b on a.product_sku_id=b.product_sku_id
           where a.product_cart_id=v_product_cart_id
           and a.is_active=1)row) as products

           )tab into p_tran_json ;
	   
	   p_tran_status:=1;
	   
	 
	   
		exception
			when no_data_found then
				p_tran_json := '{"error":"transaction failed"}';
				p_tran_status:=0;
		end;
		
		 update dd.dd_product_cart
		 set is_active=0,payment_status=1
		 where product_cart_id=v_product_cart_id;
		
		 update dd.dd_product_cart_details
		 set is_active=0
		 where product_cart_id=v_product_cart_id;
		
		-- p_tran_status:=1;
		else 
		p_tran_json := '{"error":"transaction failed"}';
		
		p_tran_status:=0;
       end if;
        
		p_result := 1;

	
	

END;

    

$$;


--
