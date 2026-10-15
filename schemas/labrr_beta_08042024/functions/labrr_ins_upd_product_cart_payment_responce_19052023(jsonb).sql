-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_product_cart_payment_responce_19052023(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_product_cart_payment_responce_19052023(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_product_cart_payment_responce_19052023(p_payjson jsonb, OUT p_result numeric, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
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
        v_final_payment_json jsonb;
        v_payment_guid character varying(500);
        v_trans_date timestamp;
        v_trans_date1 character varying;
		m record;
		v_billing_email character varying(500);
		v_billing_tel character varying;
		v_auth_token text;
		
		v_email_id character varying(1000);
		v_mobile_no character varying(1000); 
		v_is_status_flag numeric ;
		v_user_full_name character varying(500);
		v_user_guid character varying(1000);
		v_random_num numeric;
		v_inv_json jsonb;
		v_response numeric;
		v_campaign_id numeric;
		v_coupon_code varchar(250);
        v_add_info jsonb;
        v_product_id numeric;
		v_product_inv_code text;
        v_invoice_id character varying;
        v_pancard character varying;
        v_donation_cause character varying;
        v_module_name character varying:= '';
        v_module_type character varying:= '';
        v_is_login numeric;
        v_gst_no character varying;
        v_sac numeric;
        v_discounted_amount decimal;
        v_gst decimal;
        v_cgst decimal;
        v_sgst decimal;
        v_total_amount decimal;
		v_user_id numeric;
        v_order_id numeric;
		v_membership_code character varying;
		v_discount_code character varying;
		v_discount_type character varying;
        v_discount_amt  decimal;
        v_gst_amount decimal;
        v_cgst_amount decimal;
        v_sgst_amount decimal;
        v_product_discount_coupon_map_id numeric;
        v_product_price decimal;
        
BEGIN

     v_final_payment_json :=p_payjson;
     
		select current_timestamp at time zone 'utc' 
		into   v_sysdate;		
        
        
        select 	v_final_payment_json->'data'->>'order_id',
                v_final_payment_json->'data'->>'tracking_id',
                v_final_payment_json->'data'->>'product_cart_id',
                v_final_payment_json->'data'->>'bank_ref_no',
                v_final_payment_json->'data'->>'order_status',
                v_final_payment_json->'data'->>'response_code',
                v_final_payment_json->'data'->>'payment_mode',
                v_final_payment_json->'data'->>'card_name',
                v_final_payment_json->'data'->>'status_code',
                v_final_payment_json->'data'->>'status_message',
                v_final_payment_json->'data'->>'amount',
                v_final_payment_json->'data'->>'trans_date',
				v_final_payment_json->'data'->>'billing_email',
				v_final_payment_json->'data'->>'billing_tel',
				v_final_payment_json->'data'->>'user_guid',
				v_final_payment_json->'data'->>'offer_code',
				v_final_payment_json->'data'->>'offer_type'
				
           into v_order_id,
                v_tracking_id,
                v_product_cart_id,
                v_bank_ref_no,
                v_order_status,
                v_failure_message,
                v_payment_mode,
                v_card_name,
                v_status_code,
                v_status_message,
                v_amount,
                v_trans_date1,
				v_billing_email,
				v_billing_tel,
				v_user_guid,
				v_discount_code,
				v_discount_type
                ;
                
            
            
             if v_trans_date1 ='null' or v_trans_date1 ='' or 
             v_final_payment_json->'data'->>'trans_date' is null then
             
                v_trans_date :=current_timestamp+'5.5 hours'::interval;
             else
                v_trans_date :=to_char(to_timestamp(v_trans_date1,'dd-mm-yyyy HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS');
                --to_char(to_timestamp(v_trans_date1,'yyyy-mm-dd HH24:MI:SS'),'yyyy-mm-dd HH24:MI:SS');
             end if;
             --raise notice 'v_payment_mode: %',v_payment_mode;
             --raise notice 'v_trans_date:%',v_trans_date;
               
                select v_final_payment_json->'data'->>'module_name',
                v_final_payment_json->'data'->>'type' 
                into v_module_name,v_module_type; 
            
            if (v_discount_code='' or v_discount_type='' or v_discount_code='null' or v_discount_type='null') then
                v_discount_code:=null;
                v_discount_type:=null;
                end if;          
                
                --raise notice 'v_discount_type:%',v_discount_type;
                --raise notice 'v_module_type:%',v_module_type;
                
   v_is_status_flag := case when lower(v_order_status)=lower('SUCCESS') then 1
               						when lower(v_order_status)=lower('Failure') then 0
									when lower(v_order_status)=lower('SI-Initiated') then 2 
									when lower(v_order_status)=lower('AWAITED') then 2
                                    when lower(v_order_status)=lower('Aborted') then 3
			   					    else 0 end ;
                                    
   
         
     --raise notice 'v_is_status_flag:%',v_is_status_flag;                               
    select product_id,donation_cause from labrr.labrr_product_cart where 
    product_cart_id =v_product_cart_id into v_product_id,v_donation_cause; 
    --raise notice '%', v_is_status_flag; 
    if v_is_status_flag  in (0,1,3) and (lower(v_discount_type)=lower('COMMON') or v_discount_type is null) then
    --raise notice '1';
    select product_cart_id into v_product_cart_id 
         from labrr.labrr_product_cart_paydetails
         where tracking_id=v_tracking_id;
         
    select product_id,donation_cause from labrr.labrr_product_cart where product_cart_id =v_product_cart_id into v_product_id,v_donation_cause;
    
    end if;    
    
    select add_info,add_info->>'is_login',add_info->>'gst_no',add_info->>'sac',
    add_info->>'gst',add_info->>'cgst',add_info->>'sgst',product_price
    into 
    v_add_info,v_is_login,v_gst_no,v_sac,v_gst,v_cgst,v_sgst,v_product_price
    from labrr.labrr_product 
	where product_id= v_product_id; 
                              
    --raise notice 'v_discount_type:%',v_discount_type;	
	if v_is_login =0 then
     if not exists (select 1 from labrr.labrr_product_cart_paydetails
				where tracking_id = v_tracking_id) then
		
      		 v_product_cart_paydetailsid  := nextval('labrr.seq_labrr_product_cart_paydetails_id');
             /*
			v_is_status_flag := case when lower(v_order_status)=lower('SUCCESS') then 1
               						when lower(v_order_status)=lower('Failed') then 0
									when lower(v_order_status)=lower('SI-Initiated') then 2 
									when lower(v_order_status)=lower('AWAITED') then 2 
			   					    else 0 end ;*/
        --raise notice 'v_product_cart_paydetailsid:%',v_product_cart_paydetailsid;
		
		if 	 v_tracking_id is not null and lower(v_order_status) = lower('SI-Initiated') then
		
		
            insert into labrr.labrr_product_cart_paydetails
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
             final_payment_json,
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
			 is_mail_sent,
             initiated_payment_json,
             module_name,
             module_type,
			 order_id
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
          		  v_final_payment_json, 
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
				  0 ,
                  v_final_payment_json,
                  v_module_name,
                  v_module_type,
				  v_order_id
                   );
                  
				
                 
				else
						p_tran_status := 0;

				end if;	
                
                
    else
    
    			
    
    --raise notice 'v_product_cart_id:%',v_product_cart_id;
   
         
         /*select product_cart_id into v_product_cart_id 
         from labrr.labrr_product_cart_paydetails
         where tracking_id=v_tracking_id;*/
         
         select pancard into v_pancard from labrr.labrr_product_shipment_user where product_cart_id =v_product_cart_id; 
         
         select module_name,module_type from labrr.labrr_product_cart_paydetails where product_cart_id =v_product_cart_id into v_module_name,v_module_type;
         --(select product_cart_id from labrr.labrr_product_cart_paydetails where product_cart_id= v_product_cart_id);
         
         --select product_id,donation_cause from labrr.labrr_product_cart where product_cart_id =v_product_cart_id into v_product_id,v_donation_cause;
         
         select product_code into v_product_inv_code from labrr.labrr_product where product_id=v_product_id ;

		v_invoice_id:=v_product_inv_code||v_product_cart_id;
         
         update labrr.labrr_product_cart_paydetails
			set  bank_ref_no = v_bank_ref_no, 
				 order_status = v_order_status, 
				 failure_message = v_failure_message,  
				 payment_mode =  v_payment_mode, 
				 card_name =  v_card_name, 
				 status_code =  v_status_code,
				 status_message = v_status_message ,  
				 amount = v_amount,
                 invoice_id=v_invoice_id,
				 final_payment_json = v_final_payment_json,
				 transaction_date = v_trans_date ,
				 payment_guid = v_payment_guid, 
				 created_date = v_sysdate, 
				 updated_date = v_sysdate, 
				 created_by = 1, 
				 updated_by =1,
				 order_id=v_order_id,
				 is_active =  case when lower(v_order_status)=lower('SUCCESS') then 1
				 			  else 0 end 	, 
				 is_deleted = case when lower(v_order_status)=lower('SUCCESS') then 0
				 					when lower(v_order_status)in (lower('AWAITED'))then 0
				 			  else 1 end ,
				 is_status_flag = v_is_status_flag
			where tracking_id = v_tracking_id;	
            
            p_result := 1;
		v_response := 1;
        p_tran_status := 1;
		p_tran_json:= v_final_payment_json;
        
        
		p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));
        p_tran_json:=jsonb_set(p_tran_json,'{data,pancard}',('"'||coalesce(v_pancard,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,invoice_no}',('"'||coalesce(v_invoice_id,'')||'"')::jsonb, true);
        
		 
	     end if;
		
		if lower(v_order_status) = lower('SI-Initiated') 
	   or lower(v_order_status) = lower('AWAITED')
	   then 
	   
	   /*
	   select row_to_json(tab)  from(
		select wu.email_id as user_email,wu.user_full_name as user_name,p.product_name,
				pa.expiry_date, case when lower(v_order_status)= lower('REFUND') then 'REFUND'
					else 'transaction failed' end as error,p.product_id,pp.is_mail_sent,pp.tracking_id,
					case when v_campaign_id is null then 0 else 1 end as already_exists
		from labrr.labrr_web_user wu
		left join  labrr.labrr_product_cart pa on wu.user_guid=pa.user_guid
		left join labrr.labrr_product p on pa.product_id=p.product_id
		left join labrr.labrr_product_cart_paydetails pp on pa.product_cart_id = pp.product_cart_id
		where  tracking_id = v_tracking_id )tab 
		into p_tran_json ;*/
		
		p_result := 1;
		v_response := 1;
        p_tran_status := 1;
		p_tran_json:= v_final_payment_json;
		p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));
	   
	   end if;
       
       
       p_tran_json:=jsonb_set(p_tran_json,'{data,add_info}',coalesce(to_jsonb(v_add_info),'{}'));
      p_tran_json:=jsonb_set(p_tran_json,'{data,module_name}',('"'||coalesce(v_module_name,'')||'"')::jsonb, true);
     p_tran_json:=jsonb_set(p_tran_json,'{data,module_type}',('"'||coalesce(v_module_type,'')||'"')::jsonb, true);
     --p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||to_char(v_trans_date,'mm/dd/yyyy HH12:MI:SS AM')||'"')::jsonb, true);
	 p_tran_json:=jsonb_set(p_tran_json,'{data,user_guid}',('"'||coalesce(v_user_guid,'')||'"')::jsonb, true);
     p_tran_json:=jsonb_set(p_tran_json,'{data,donation_cause}',('"'||coalesce(v_donation_cause,'')||'"')::jsonb, true);
     
        p_tran_json:=jsonb_set(p_tran_json,'{data,product_id}',coalesce(v_product_id::text::jsonb,null));
	--raise notice 'p_tran_json:%',p_tran_json;
       
    elsif v_is_login =1 then
	--raise notice '1';
    
	if lower (v_discount_type)=lower('UNIQUE') then
	--raise notice '1';
    v_product_discount_coupon_map_id  := nextval('labrr.seq_labrr_product_discount_coupon_map_id');
    if not exists (select 1 from labrr.labrr_product_cart_paydetails where 
        tracking_id = v_tracking_id) and exists (select 1 from labrr.labrr_web_user 
        where user_guid=v_user_guid) then
		
      		 v_product_cart_paydetailsid  := nextval('labrr.seq_labrr_product_cart_paydetails_id');
             
  
	
	insert into labrr.labrr_product_cart_paydetails
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
             final_payment_json,
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
			 is_mail_sent,
             initiated_payment_json,
             module_name,
             module_type,
			 order_id
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
          		  v_final_payment_json, 
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
				  0 ,
                  v_final_payment_json,
                  v_module_name,
                  v_module_type,
				  v_order_id
                   );
                   
        
										 		   
		update labrr.labrr_product_discount_coupon set is_used=1 where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type);
				   
		ELSE
		
		p_result:=0;
        p_tran_status:=0;
        p_tran_json:='{}';
				   
		end if;    
 
        
        insert into labrr.labrr_product_discount_coupon_map(product_discount_coupon_map_id,discount_code,user_guid,used_date) 
        values (v_product_discount_coupon_map_id,v_discount_code,v_user_guid,v_sysdate); 
    
				   
		select user_id into v_user_id from labrr.labrr_web_user where user_guid=v_user_guid;
         --,membership_code  ,v_membership_code
         select pancard,discounted_amount,gst_amount,cgst_amount,sgst_amount 
         into v_pancard,v_discount_amt,v_gst_amount,v_cgst_amount,v_sgst_amount
         from labrr.labrr_product_shipment_user where product_cart_id =v_product_cart_id; 
         
         --select module_name,module_type from labrr.labrr_product_cart_paydetails where product_cart_id =v_product_cart_id into v_module_name,v_module_type;
         
         select product_code into v_product_inv_code from labrr.labrr_product where product_id=v_product_id ;

		v_invoice_id:=v_product_inv_code||v_product_cart_id;
				   
		p_result := 1;
		v_response := 1;
        p_tran_status := 1;
		p_tran_json:= v_final_payment_json;
        
        
		p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));
        p_tran_json:=jsonb_set(p_tran_json,'{data,pancard}',('"'||coalesce(v_pancard,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,invoice_no}',('"'||coalesce(v_invoice_id,'')||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||to_char(v_trans_date,'mm/dd/yyyy HH12:MI:SS AM')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||v_trans_date||'"')::jsonb, true);
        
        p_tran_json:=jsonb_set(p_tran_json,'{data,membership_type}',('"'||coalesce(v_product_inv_code,'')||'"')::jsonb, true);
      --p_tran_json:=jsonb_set(p_tran_json,'{data,module_name}',('"'||coalesce(v_module_name,'')||'"')::jsonb, true);
     
     --p_tran_json:=jsonb_set(p_tran_json,'{data,module_type}',('"'||coalesce(v_module_type,'')||'"')::jsonb, true);
	 --raise notice '%',p_tran_json;
     p_tran_json:=jsonb_set(p_tran_json,'{data,user_id}',coalesce(v_user_id::text::jsonb,null));
	 	-- p_tran_json:=jsonb_set(p_tran_json,'{data,membership_code}',coalesce(v_membership_code,''),true);

--raise notice'%',p_tran_json;
	 p_tran_json:=jsonb_set(p_tran_json,'{data,user_guid}',('"'||coalesce(v_user_guid,'')||'"')::jsonb, true);
          
     p_tran_json:=jsonb_set(p_tran_json,'{data,donation_cause}',('"'||coalesce(v_donation_cause,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,product_id}',coalesce(v_product_id::text::jsonb,null));
        p_tran_json:=jsonb_set(p_tran_json,'{data,base_price}',coalesce(v_product_price::text::jsonb,null));
        p_tran_json:=jsonb_set(p_tran_json,'{data,add_info}',coalesce(to_jsonb(v_add_info),'{}'));
        p_tran_json:=jsonb_set(p_tran_json,'{data,gst_no}',('"'||coalesce(v_gst_no,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,sac}',('"'||coalesce(v_sac,0)||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,discounted_amount}',('"'||coalesce(v_discounted_amount,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,gst}',('"'||coalesce(v_gst,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,cgst}',('"'||coalesce(v_cgst,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,sgst}',('"'||coalesce(v_sgst,0)||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,total_amount}',('"'||coalesce(v_total_amount,0)||'"')::jsonb, true);
	p_tran_json:=jsonb_set(p_tran_json,'{data,gst_amount}',('"'||coalesce(v_gst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,cgst_amount}',('"'||coalesce(v_cgst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,sgst_amount}',('"'||coalesce(v_sgst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,discounted_amount}',('"'||coalesce(v_discount_amt,0)||'"')::jsonb, true);
	
	
  
    elsif lower(v_discount_type)<>lower('UNIQUE') or v_discount_type is null then
     --raise notice '1';
   
    if not exists (select 1 from labrr.labrr_product_cart_paydetails where 
        tracking_id = v_tracking_id) and exists (select 1 from labrr.labrr_web_user 
        where user_guid=v_user_guid) then
		
      		 v_product_cart_paydetailsid  := nextval('labrr.seq_labrr_product_cart_paydetails_id');
             /*
			v_is_status_flag := case when lower(v_order_status)=lower('SUCCESS') then 1
               						when lower(v_order_status)=lower('Failed') then 0
									when lower(v_order_status)=lower('SI-Initiated') then 2 
									when lower(v_order_status)=lower('AWAITED') then 2 
			   					    else 0 end ;*/
        --raise notice 'v_product_cart_paydetailsid:%',v_product_cart_paydetailsid;
		
		if 	v_tracking_id is not null and lower(v_order_status) = lower('SI-Initiated')then
		
		
            insert into labrr.labrr_product_cart_paydetails
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
             final_payment_json,
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
			 is_mail_sent,
             initiated_payment_json,
             module_name,
             module_type,
			 order_id
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
          		  v_final_payment_json, 
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
				  0 ,
                  v_final_payment_json,
                  v_module_name,
                  v_module_type,
				  v_order_id
                   );
                  
				
                 
				else
						p_tran_status := 0;

				end if;	
            
                
    else
    
    	if lower(v_order_status)=lower('SUCCESS') or 
        lower(v_order_status)=lower('Failure')or
        lower(v_order_status)=lower('Aborted')then	
        
		--if lower(v_order_status)=lower('SUCCESS') and v_discount_code is not null and v_discount_type is not null THEN
		
		--update labrr.labrr_product_discount_coupon set is_used=1,used_date=v_sysdate,user_guid=v_user_guid where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type);
        
        --elsif v_discount_code is not null and v_discount_type is not null then
        
        --update labrr.labrr_product_discount_coupon set is_used=0,used_date=v_sysdate,user_guid=v_user_guid where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type);
		
		--end if;
        --select transaction_date into v_trans_date from labrr.labrr_product_cart_paydetails where tracking_id = v_tracking_id;
          
         select user_guid into v_user_guid from labrr.labrr_product_cart_paydetails where tracking_id = v_tracking_id;
		 
		 select user_id into v_user_id from labrr.labrr_web_user where user_guid=v_user_guid;
         --,membership_code  ,v_membership_code
         select pancard,discounted_amount,gst_amount,cgst_amount,sgst_amount 
         into v_pancard,v_discount_amt,v_gst_amount,v_cgst_amount,v_sgst_amount 
         from labrr.labrr_product_shipment_user where product_cart_id =v_product_cart_id; 
         
         select module_name,module_type from labrr.labrr_product_cart_paydetails where product_cart_id =v_product_cart_id into v_module_name,v_module_type;
         
         select product_code into v_product_inv_code from labrr.labrr_product where product_id=v_product_id ;

		v_invoice_id:=v_product_inv_code||v_product_cart_id;
         
         update labrr.labrr_product_cart_paydetails
			set  bank_ref_no = v_bank_ref_no, 
				 order_status = v_order_status, 
				 failure_message = v_failure_message,  
				 payment_mode =  v_payment_mode, 
				 card_name =  v_card_name, 
				 status_code =  v_status_code,
				 status_message = v_status_message,  
				 amount = v_amount,
                 invoice_id=v_invoice_id,
				 final_payment_json = v_final_payment_json,
				 transaction_date = v_trans_date,
				 payment_guid = v_payment_guid, 
				 created_date = v_sysdate, 
				 updated_date = v_sysdate, 
				 created_by = 1, 
				 updated_by =1,
				 order_id=v_order_id,
				 is_active =  case when lower(v_order_status)=lower('SUCCESS') then 1
				 			  else 0 end 	, 
				 is_deleted = case when lower(v_order_status)=lower('SUCCESS') then 0
				 					when lower(v_order_status)in (lower('AWAITED'))then 0
				 			  else 1 end ,
				 is_status_flag = v_is_status_flag
			where tracking_id = v_tracking_id;	
            
            p_result := 1;
		v_response := 1;
        p_tran_status := 1;
		p_tran_json:= v_final_payment_json;
        
        
		p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));
        p_tran_json:=jsonb_set(p_tran_json,'{data,pancard}',('"'||coalesce(v_pancard,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,invoice_no}',('"'||coalesce(v_invoice_id,'')||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||to_char(v_trans_date,'mm/dd/yyyy HH12:MI:SS AM')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||v_trans_date||'"')::jsonb, true);
        
        p_tran_json:=jsonb_set(p_tran_json,'{data,membership_type}',('"'||coalesce(v_product_inv_code,'')||'"')::jsonb, true);
       p_tran_json:=jsonb_set(p_tran_json,'{data,base_price}',coalesce(v_product_price::text::jsonb,null));
       p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));        
      p_tran_json:=jsonb_set(p_tran_json,'{data,module_name}',('"'||coalesce(v_module_name,'')||'"')::jsonb, true);
     
     p_tran_json:=jsonb_set(p_tran_json,'{data,module_type}',('"'||coalesce(v_module_type,'')||'"')::jsonb, true);
	 --raise notice '%',p_tran_json;
     p_tran_json:=jsonb_set(p_tran_json,'{data,user_id}',coalesce(v_user_id::text::jsonb,null));
	 	-- p_tran_json:=jsonb_set(p_tran_json,'{data,membership_code}',coalesce(v_membership_code,''),true);

--raise notice'%',p_tran_json;
	 p_tran_json:=jsonb_set(p_tran_json,'{data,user_guid}',('"'||coalesce(v_user_guid,'')||'"')::jsonb, true);
          
     p_tran_json:=jsonb_set(p_tran_json,'{data,donation_cause}',('"'||coalesce(v_donation_cause,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,product_id}',coalesce(v_product_id::text::jsonb,null));
        
        p_tran_json:=jsonb_set(p_tran_json,'{data,add_info}',coalesce(to_jsonb(v_add_info),'{}'));
        p_tran_json:=jsonb_set(p_tran_json,'{data,gst_no}',('"'||coalesce(v_gst_no,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,sac}',('"'||coalesce(v_sac,0)||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,discounted_amount}',('"'||coalesce(v_discounted_amount,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,gst}',('"'||coalesce(v_gst,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,cgst}',('"'||coalesce(v_cgst,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,sgst}',('"'||coalesce(v_sgst,0)||'"')::jsonb, true);
        --p_tran_json:=jsonb_set(p_tran_json,'{data,total_amount}',('"'||coalesce(v_total_amount,0)||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,gst_amount}',('"'||coalesce(v_gst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,cgst_amount}',('"'||coalesce(v_cgst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,sgst_amount}',('"'||coalesce(v_sgst_amount,0)||'"')::jsonb, true);
    p_tran_json:=jsonb_set(p_tran_json,'{data,discounted_amount}',('"'||coalesce(v_discount_amt,0)||'"')::jsonb, true);
    
        
		else
        p_result:=0;
	    p_tran_status :=0;
	    p_tran_json :='{}';
	    
        
        end if;
         
   end if;
		
		if exists (select 1 from labrr.labrr_web_user 
        where user_guid=v_user_guid) and 
        lower(v_order_status) = lower('SI-Initiated') 
	   --or lower(v_order_status) = lower('AWAITED')
	   then 
	   
		p_result := 1;
		v_response := 1;
        p_tran_status := 1;
		p_tran_json:= v_final_payment_json;
        
		p_tran_json:=jsonb_set(p_tran_json,'{data,response}',coalesce(v_response::text::jsonb,null));        
        p_tran_json:=jsonb_set(p_tran_json,'{data,add_info}',coalesce(to_jsonb(v_add_info),'{}'));
      p_tran_json:=jsonb_set(p_tran_json,'{data,module_name}',('"'||coalesce(v_module_name,'')||'"')::jsonb, true);
     p_tran_json:=jsonb_set(p_tran_json,'{data,module_type}',('"'||coalesce(v_module_type,'')||'"')::jsonb, true);
	 p_tran_json:=jsonb_set(p_tran_json,'{data,user_guid}',('"'||coalesce(v_user_guid,'')||'"')::jsonb, true);
     p_tran_json:=jsonb_set(p_tran_json,'{data,donation_cause}',('"'||coalesce(v_donation_cause,'')||'"')::jsonb, true);
        p_tran_json:=jsonb_set(p_tran_json,'{data,product_id}',coalesce(v_product_id::text::jsonb,null));
   
	   end if;
       
       if lower(v_order_status)=lower('Aborted') then
       
       p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||v_trans_date||'"')::jsonb, true);
       
       end if;

       --p_tran_json:=jsonb_set(p_tran_json,'{data,trans_date}',('"'||to_char(v_trans_date,'mm/dd/yyyy HH12:MI:SS AM')||'"')::jsonb, true);
       
    
    else
    p_result:=0;
    p_tran_status:=null;
    p_tran_json:='{}';
    end if;
    else    
    p_result:=0;
    p_tran_status:=null;
    p_tran_json:='{}';
    
    end if;
       /*
       select p.add_info into v_add_info from labrr.labrr_product_cart_paydetails pcp  
       join labrr.labrr_product_cart pc on pc.product_cart_id=pcp.product_cart_id
       join labrr.labrr_product p on p.product_id=pc.product_id 
       where pcp.tracking_id=v_tracking_id;
     */
    
     EXCEPTION
		WHEN sqlstate '23000' THEN
        p_result:=0;
        p_tran_status:=0;
		p_tran_json	:='{}';  
	  

END;

    

$$;


--
