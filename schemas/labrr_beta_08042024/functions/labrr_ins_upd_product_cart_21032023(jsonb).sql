-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_product_cart_21032023(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_product_cart_21032023(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_product_cart_21032023(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 							jsonb;
v_product_cartid 				numeric;
v_product_id					numeric;
v_userid 						numeric;
v_total_selproduct				numeric;
v_total_price					numeric;
v_delivery_charges				numeric;
v_paygateway_cancelurl       	character varying;
v_paygateway_redirecturl		character varying;
v_paygateway_referenceno		character varying;
v_pay_status					numeric;								
v_cartdetails_json				json;
v_shipmentadd_json				jsonb;
v_sysdate 						timestamp;
v_created_by 					numeric;
V_updated_by					numeric;
V_data_guid						character varying;
v_is_approved					numeric;
v_cartdetails					json;
v_product_shipmentid			numeric;					
v_total_amount					numeric;
v_bill_amount					numeric;
v_billing_name					character varying(1000);
v_billing_address1				character varying(1000);
v_billing_district				character varying(1000);
v_billing_landmark				character varying(1000);
v_billing_address2				character varying(1000);
v_billing_mobile_no				character varying(1000);
v_billing_pincode				character varying(1000);
v_billing_state					character varying(1000);
v_billing_city					character varying(1000);
v_shipment_name					character varying(1000);
v_shipment_address1				character varying(1000);
v_shipment_address2				character varying(1000);
v_shipment_mobile_no			character varying(1000);
v_shipment_state				character varying(1000);
v_shipment_city					character varying(1000);
v_shipment_pincode				character varying(1000);
v_fees							numeric;
v_shipment_guid					character varying(1000);
v_promocode						character varying(1000);
v_deductions					numeric;
v_isshipment_billing_addresssame numeric;
v_taxes 						numeric;
v_cart_guid						character varying(1000);
v_product_cart_detailsid		numeric;
v_product_skuid					numeric;
v_sku_code						character varying(1000);
v_payment_info					character varying(1000);
v_product_price 				numeric;
v_quantity						numeric;
v_product_customize_map_id		numeric;
v_is_customize					numeric;
v_customize_text				character varying(1000);
v_is_return  					numeric;
v_cartdetails_guid				character varying(1000);
v_user_mailid					character varying(1000);
v_is_loginuser					numeric;
v_customize_price				numeric;
v_payable_amount				numeric;
v_total_product_count			numeric;
v_billing_emailid				character varying(1000);
v_billing_country               character varying(1000);
v_shipping_country              character varying(1000);
v_user_guid 					character varying(1000);
v_shipment_state_id				numeric;
v_shipment_city_id 				numeric;
v_shipment_country_id 			numeric := 101;
v_gst_no 						text;
v_product_code 					character varying;
v_membership_owner              text;
v_name_on_card 					text;
v_whatsapp_consent				numeric;
v_is_discount_user              numeric;
v_old_campaign_id               numeric;
v_discount                      numeric;
v_discount_amt                  numeric;
v_old_user                      numeric;
v_personalised_name             text;
v_personalised_number           numeric;
v_is_personalised               numeric;
v_currency                      character varying; 

BEGIN

		--v_json := '{"data":{
	--	"product_cart_id" : "0"
	   --            }}'::jsonb;
				
		
		--p_data 	 := v_json;
		--p_result := 1;

	
	select current_timestamp at time zone 'utc' 
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */

		
		SELECT 	v_json->'data'->>'product_cart_id',
				v_json->'data'->>'user_id',
                v_json->'data'->>'user_mailid',
                v_json->'data'->>'is_login_user',
				v_json->'data'->>'total_select_product',
				v_json->'data'->>'amount',
                v_json->'data'->>'currency',
				v_json->'data'->>'delivery_charges',
				v_json->'data'->>'payment_gateway_cancel_url',
				v_json->'data'->>'payment_gateway_redirect_url',
				v_json->'data'->>'payment_gateway_reference_no',
				v_json->'data'->>'payment_status',
				v_json->'data'->>'created_by',
				v_json->'data'->>'updated_by',	
                v_json->'data'->>'user_cart_guid',
				v_json->'data'->>'cartdetails',
				v_json->'data'->'user_info',
				v_json->'data'->>'user_guid',
				v_json->'data'->>'product_id'																
		INTO            
				v_product_cartid,
				v_userid,
                v_user_mailid,
                v_is_loginuser,
				v_total_selproduct,
				v_total_price,
                v_currency,
				v_delivery_charges,
				v_paygateway_cancelurl,
				v_paygateway_redirecturl,
				v_paygateway_referenceno,
				v_pay_status,								
				v_created_by,
				V_updated_by,
                v_cart_guid,
				v_cartdetails_json,
				v_shipmentadd_json,
				v_user_guid,
				v_product_id;
         
                
		--------------------------------------------------------------- 
		      
       
		select  v_shipmentadd_json->>'product_shipment_id',				
				v_shipmentadd_json->>'total_amount',
				v_shipmentadd_json->>'bill_amount',
				v_shipmentadd_json->>'billing_name',
				v_shipmentadd_json->>'billing_address1',
				v_shipmentadd_json->>'billing_address2',
				v_shipmentadd_json->>'billing_mobile_no',
				v_shipmentadd_json->>'billing_pincode',
				v_shipmentadd_json->>'billing_state',
				v_shipmentadd_json->>'billing_city',
				v_shipmentadd_json->>'shipment_name',
				v_shipmentadd_json->>'shipment_address1',
				v_shipmentadd_json->>'shipment_address2',
				v_shipmentadd_json->>'shipment_mobile_no',
				v_shipmentadd_json->>'shipment_state',
				v_shipmentadd_json->>'shipment_city',
				v_shipmentadd_json->>'shipment_pincode',
				v_shipmentadd_json->>'fees',
				v_shipmentadd_json->>'shipment_guid',
				v_shipmentadd_json->>'promocode',
				v_shipmentadd_json->>'deductions',
				v_shipmentadd_json->>'is_shipment_billing_address_same',
				v_shipmentadd_json->>'taxes',
                v_shipmentadd_json->>'billing_user_mailid',
				v_shipmentadd_json->>'billing_country',
				v_shipmentadd_json->>'shipping_country',
				v_shipmentadd_json->>'shipping_state_id',
				v_shipmentadd_json->>'shipping_city_id'	,
				v_shipmentadd_json->>'gst_no',
				v_shipmentadd_json->>'billing_district',
				v_shipmentadd_json->>'billing_landmark',
				v_shipmentadd_json->>'membership_owner',
				v_shipmentadd_json->>'name_on_card',
				v_shipmentadd_json->>'whatsapp_consent',
				v_shipmentadd_json->>'is_discount_user',
				v_shipmentadd_json->>'personalised_name',
				v_shipmentadd_json->>'personalised_number',
				v_shipmentadd_json->>'is_personalised'
		into 
				v_product_shipmentid,				
				v_total_amount,
				v_bill_amount,
				v_billing_name,
				v_billing_address1,
				v_billing_address2,
				v_billing_mobile_no,
				v_billing_pincode,
				v_billing_state,
				v_billing_city,
				v_shipment_name,
				v_shipment_address1,
				v_shipment_address2,
				v_shipment_mobile_no,
				v_shipment_state,
				v_shipment_city,
				v_shipment_pincode,
				v_fees,
				v_shipment_guid,
				v_promocode,
				v_deductions,
				v_isshipment_billing_addresssame,
				v_taxes,
                v_billing_emailid,
				v_billing_country,
				v_shipping_country,
				v_shipment_state_id,
				v_shipment_city_id,
				v_gst_no,
				v_billing_district,
				v_billing_landmark,
				v_membership_owner,
				v_name_on_card,
				v_whatsapp_consent,
				v_is_discount_user,
				v_personalised_name,
				v_personalised_number,
				v_is_personalised;
				
				v_product_shipmentid   := nextval('labrr.seq_labrr_product_shipment_user_id');
				v_shipment_guid := uuid_generate_v4();
				
				v_product_cartid   := nextval('labrr.seq_labrr_product_cart_id');
			     v_json 	       := jsonb_set(v_json, '{data,product_cart_id}', ('"'||v_product_cartid||'"')::text::jsonb, true);
				
				insert into labrr.labrr_product_cart
			(
				product_cart_id, user_id, user_emailid, is_login_user, total_select_product, total_price, delivery_charges, payment_gateway_reference_no,
				payment_gateway_cancel_url, payment_gateway_redirect_url, payment_status, transaction_date, created_date,
				updated_date, created_by, updated_by, user_cart_guid, is_active, is_deleted, cart_json,user_guid,product_id,membership_owner,
				name_on_card,whatsapp_consent,discount_percent,personalised_name,personalised_number,is_personalised
			)    
			values
			(
				v_product_cartid, v_userid, 
				v_user_mailid, 
				v_is_loginuser,  
				v_total_selproduct, v_total_price, v_delivery_charges, v_paygateway_referenceno,
				v_paygateway_cancelurl, v_paygateway_redirecturl, v_pay_status, v_sysdate,  v_sysdate, v_sysdate, 1, 1, 
				v_user_guid , 1 ,0, v_json ,v_user_guid,v_product_id,v_membership_owner,v_name_on_card,v_whatsapp_consent,v_discount,
				v_personalised_name,v_personalised_number,v_is_personalised);  
				
				
		 insert into  labrr.labrr_product_shipment_user
                    (product_shipment_user_id, product_cart_id, shipment_name, shipment_address1, shipment_address2, shipment_state, shipment_city, shipment_pincode,
                     shipment_mobile_no, is_shipment_billing_address_same, billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
                     billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, is_active, is_deleted, shipment_guid,
                     billing_user_emailid,billing_country,shipping_country,shipment_state_id,shipment_city_id,shipment_country_id,gst_no,billing_district,billing_landmark,currency)
                    values 
                    (
                        v_product_shipmentid, v_product_cartid,v_shipment_name, v_shipment_address1, v_shipment_address2,
                        v_shipment_state, v_shipment_city, v_shipment_pincode, v_shipment_mobile_no, v_isshipment_billing_addresssame, 
                        v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
                        v_billing_mobile_no, v_promocode, v_total_price, v_fees, v_taxes, v_deductions, v_total_price,
                        v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_shipping_country,
						v_shipment_state_id,v_shipment_city_id,v_shipment_country_id,v_gst_no,v_billing_district,v_billing_landmark,v_currency
                    );		
				
				
			p_result := 1;

           p_data := v_json;	
		
--   -- raise notice '%',v_user_guid;
  
--  -- if exists(select 1 from labrr.labrr_web_user where user_guid = v_user_guid ) then
  
--   	   select pc.product_cart_id into v_product_cartid
--        from labrr.labrr_product_cart pc
-- 	   join labrr.labrr_product_cart_paydetails pp on pc.product_cart_id = pp.product_cart_id 
--        where pc.user_guid = v_user_guid and is_status_flag in (1,2);
	   
-- 	   select email_id,mobile_no,old_campaign_id into v_billing_emailid,v_billing_mobile_no,v_old_campaign_id 
-- 	   from labrr.labrr_web_user
-- 	   where user_guid = v_user_guid;
	   
--       -- raise notice 'v_product_cartid:%',v_product_cartid;
	   
-- 	--  if v_is_discount_user = 1 then
	   
-- 	   if v_old_campaign_id is null then 
-- 	      v_old_campaign_id := 1 ;
-- 		  v_old_user = 0 ;
-- 	   else
-- 	      v_old_user = 1 ;
-- 	   end if;
	 
-- --	 select discount into v_discount from labrr.labrr_product_discount
-- 	-- where to_product_id = v_product_id and from_product_id = v_old_campaign_id and old_user = v_old_user;
	 
-- 	 if  v_is_personalised = 1 then
	 
-- 	 select discount,personalised_base_amt,personalised_gst_amt into v_discount,v_bill_amount,v_taxes from labrr.labrr_product_discount
-- 	 where to_product_id = v_product_id and from_product_id = v_old_campaign_id and old_user = v_old_user;
	 
	 
-- 	 else
	 
-- 	  select discount,base_amt,gst_amt into v_discount,v_bill_amount,v_taxes from labrr.labrr_product_discount
-- 	 where to_product_id = v_product_id and from_product_id = v_old_campaign_id and old_user = v_old_user;
	 
	 
-- 	 end if;
	 
-- 	 v_total_price := v_bill_amount + v_taxes;
	 
	 
-- 	 	/*if v_product_id = 3 then			
			
-- 			v_discount_amt := (2 * v_discount )/100 ;
				   
-- 			v_bill_amount := 2 - v_discount_amt;
			
-- 			v_taxes := (v_bill_amount * 18 )/100 ;
			
-- 			v_total_price := v_bill_amount + v_taxes;

-- 		elseif 	v_product_id = 4 then 
			
-- 			v_discount_amt := (4 * v_discount )/100 ;
-- 			v_bill_amount := 4 - v_discount_amt ;
-- 			v_taxes := (v_bill_amount * 18 )/100 ;
			
-- 			v_total_price := v_bill_amount + v_taxes;
			
			

-- 		 end if;*/
		 
-- 		 /*if v_product_id = 3 then			
			
-- 			v_discount_amt := (846.60 * v_discount )/100 ;
				   
-- 			v_bill_amount := 846.60 - v_discount_amt;
			
-- 			v_taxes := (v_bill_amount * 18 )/100 ;
			
-- 			v_total_price := v_bill_amount + v_taxes;

-- 		elseif 	v_product_id = 4 then 
			
-- 			v_discount_amt := (2541.52 * v_discount )/100 ;
-- 			v_bill_amount := 2541.52 - v_discount_amt ;
-- 			v_taxes := (v_bill_amount * 18 )/100 ;
			
-- 			v_total_price := v_bill_amount + v_taxes;
			
			

-- 		 end if;*/
			
	 
-- -- 	 else
	 
-- -- 		 if v_product_id = 3 then

-- -- 			v_bill_amount := 846.60;
-- -- 			v_taxes := (76.20 * 2);
			
-- -- 			v_total_price := v_bill_amount + v_taxes;

-- -- 		elseif 	v_product_id = 4 then 

-- -- 			v_bill_amount := 2541.52;
-- -- 			v_taxes := (228.74 * 2);
			
-- -- 			v_total_price := v_bill_amount + v_taxes;

-- -- 		 end if;
	   
-- 	 --  end if;
	   
-- 	    v_total_price := round(v_total_price);
		
	  

-- 	-- v_delivery_charges :=  (case when v_total_price >500 then 0 else 60 end );
        
-- 		if v_product_cartid is null then 
		
			
		
-- 			-- v_cart_guid := uuid_generate_v4();	
-- 			v_product_cartid   := nextval('labrr.seq_labrr_product_cart_id');
-- 			raise notice 'v_product_cartid:%',v_product_cartid;
            
			
--             v_json 	         := jsonb_set(v_json, '{data,product_cart_id}', ('"'||v_product_cartid||'"')::text::jsonb, true);
--             -- v_json 	         := jsonb_set(v_json, '{data,user_cart_guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
-- 				--raise notice '%',v_total_price ;
				
			
			  
			            
-- 		 else
		 
-- 		 	/*if not exists(select 1 from labrr.labrr_product_cart pc
-- 					   join labrr.labrr_product_cart_paydetails pp on pc.product_cart_id = pp.product_cart_id
-- 					   where pc.user_guid = v_user_guid 
-- 					   and ( --lower(pp.order_status)= lower('SI-Initiated') or 
-- 							lower(pp.order_status)= lower('Approved')) )then
			
-- 					update labrr.labrr_product_cart 
-- 					set     total_select_product = v_total_selproduct, 
-- 							total_price = v_total_price, 
-- 							delivery_charges = v_delivery_charges,
-- 							payment_gateway_reference_no= v_paygateway_referenceno,
-- 							payment_gateway_cancel_url= v_paygateway_cancelurl, 
-- 							payment_gateway_redirect_url= v_paygateway_redirecturl, 
-- 							payment_status= v_pay_status, 
-- 							transaction_date = v_sysdate, 
-- 							-- created_date=v_sysdate,
-- 							updated_date=v_sysdate, 
-- 							created_by=1, 
-- 							updated_by=1, 
-- 							user_cart_guid= v_cart_guid, 
-- 							is_active=1, 
-- 							is_deleted=0, 
-- 							cart_json= v_json,
-- 							product_id= v_product_id
-- 					where 	user_guid = v_user_guid;*/
					
-- 					v_product_cartid := 0;
					
-- 			v_json 	 := jsonb_set(v_json, '{data,product_cart_id}', v_product_cartid::text::jsonb, true);				
		   
		
-- 		end if ; 
		
-- 		if v_cartdetails_json is not null then 	
		          		
--             for v_cartdetails in select * from json_array_elements(v_cartdetails_json)
--             loop
--                     select  v_cartdetails->>'product_cart_details_id',								
--                             v_cartdetails->>'product_sku_id',
--                             v_cartdetails->>'sku_code',
--                             v_cartdetails->>'payment_info',                            
--                             v_cartdetails->>'quantity',                          
--                             v_cartdetails->>'product_customize_map_id',
--                             v_cartdetails->>'is_customize',
--                             v_cartdetails->>'customize_text',								
--                             v_cartdetails->>'is_return',
-- 							v_cartdetails->>'Product_Id',
-- 							v_cartdetails->>'customize_price'
--                     into 		
--                             v_product_cart_detailsid,
--                             v_product_skuid,
--                             v_sku_code,
--                             v_payment_info,                           
--                             v_quantity,                          
--                             v_product_customize_map_id,
--                             v_is_customize,
--                             v_customize_text,
--                             v_is_return ,
-- 							v_product_id,
-- 							v_customize_price
--                     ;

--                     v_cartdetails_guid := uuid_generate_v4();	
--                     v_product_cart_detailsid   := nextval('labrr.seq_labrr_product_cart_details_id');	
					
-- 				-- raise notice '%',v_product_skuid;
				
--                   select product_price into  v_product_price 
-- 				  from labrr.labrr_product_sku 
--                   where product_sku_id = v_product_skuid 
--                   and is_active = 1 and is_deleted = 0; 
                  
--                   select customize_price 
-- 				  into  v_customize_price 
--                   from labrr.labrr_product_customize_map 
--                   where product_customize_map_id = v_product_customize_map_id 
--                   and is_active = 1 and is_deleted = 0;
                  

                                   
--                   if not exists (select 1 from labrr.labrr_product_cart_details 
--                                  where product_sku_id = v_product_skuid
--                                  and  product_cart_id = v_product_cartid
--                                  and is_active = 1 
--                                  and is_deleted = 0)
--                   then
                         
--                     insert into labrr.labrr_product_cart_details
--                     (
--                         product_cart_details_id, product_cart_id, product_sku_id, sku_code, product_price, quantity, is_customize, 
--                         product_customize_map_id, customize_text, payment_info, is_return, created_date, updated_date, created_by,	updated_by,	
--                         pcd_guid, is_active, is_deleted, customize_price ,product_id
--                     )
--                     values
--                     ( v_product_cart_detailsid, v_product_cartid, v_product_skuid, v_sku_code, (v_quantity * v_product_price), v_quantity, v_is_customize,
--                       v_product_customize_map_id, v_customize_text, v_payment_info, v_is_return, v_sysdate, v_sysdate, 1, 1,
--                       v_cartdetails_guid, 1, 0 , (v_customize_price * v_quantity),	v_product_id);	
                    
-- 				 else
                 
--                 	update labrr.labrr_product_cart_details 
--                     set    product_price = (v_quantity * v_product_price), 
--                     	   quantity = v_quantity , 
--                            is_customize = v_is_customize, 
--                            product_customize_map_id = v_product_customize_map_id, 
--                            customize_text = v_customize_text,
--                            customize_price = (v_customize_price * v_quantity),
--                            payment_info = v_payment_info, 
--                            is_return = v_is_return,                         
--                            updated_date = v_sysdate,
-- 						   product_id=v_product_id
--                     where product_sku_id = v_product_skuid
--                     and  product_cart_id = v_product_cartid
--                     and is_active = 1 
--                     and is_deleted = 0;                 
                                          
--                  end if ;   
                
--             end loop ;
            
--         end if ;
		
--           /* select sum(product_price + coalesce(customize_price,0)) total_price,  	
--         		count(1) total_product_count
--        	  into v_total_price,    		
--     		  v_total_product_count 
--           from labrr.labrr_product_cart_details a         
--           where a.product_cart_id = v_product_cartid and product_sku_id = v_product_skuid
--           and a.is_active = 1 
--           and a.is_deleted = 0 ;*/
		  
-- 		  select --product_price as total_price,  	
--         		1 as total_product_count
--        	  into -- v_total_price,    		
--     		  v_total_product_count 
--           from labrr.labrr_product_cart_details a         
--           where a.product_cart_id = v_product_cartid and product_sku_id = v_product_skuid
--           and a.is_active = 1 
--           and a.is_deleted = 0 ;
		  
-- 		--v_total_price :=  v_product_price;
--          -- v_total_product_count  := 1
		
--          v_delivery_charges := coalesce(v_delivery_charges,0);
--          v_payable_amount := v_total_price + coalesce(v_delivery_charges,0);
                 

--         update labrr.labrr_product_cart 
--         set total_select_product =  v_total_product_count,
--         	total_price = v_total_price,
--             delivery_charges =v_delivery_charges ,
--             transaction_date = v_sysdate, 				
-- 			updated_date = v_sysdate,
--             cart_json = v_json
--         where product_cart_id = v_product_cartid
--         and is_active = 1 
--         and is_deleted = 0 ;
        
--         v_bill_amount := (v_total_price + v_delivery_charges);
--         v_total_amount := (v_total_price + v_delivery_charges);
--         --v_bill_amount:= v_bill_amount+(case when lower(v_shipping_country)='nepal' then 300 else 0 end );
		
-- 		select product_code into v_product_code from labrr.labrr_product
-- 		where product_id = v_product_id;
		
      
-- 	 /* if v_product_id in (5,6) and v_product_code in('PTM','DTM') then
	  
-- 	   select (v_bill_amount * 28) / 100 into   v_taxes ;
	   
-- 	  else 
-- 	     select (v_bill_amount * 18) / 100 into   v_taxes ;
		 
-- 	 end if;*/
	 
	 
	   
--         if (v_shipmentadd_json::text != 'null') then
            		
--                if not exists (select 1 from labrr.labrr_product_shipment_user
--                            where product_cart_id = v_product_cartid
--                 		   and is_active = 1 
--                 			and is_deleted = 0 ) 
--                then 
--                 	v_product_shipmentid   := nextval('labrr.seq_labrr_product_shipment_user_id');
-- 					v_shipment_guid := uuid_generate_v4();
            
--                     insert into  labrr.labrr_product_shipment_user
--                     (product_shipment_user_id, product_cart_id, shipment_name, shipment_address1, shipment_address2, shipment_state, shipment_city, shipment_pincode,
--                      shipment_mobile_no, is_shipment_billing_address_same, billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
--                      billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, is_active, is_deleted, shipment_guid,
--                      billing_user_emailid,billing_country,shipping_country,shipment_state_id,shipment_city_id,shipment_country_id,gst_no,billing_district,billing_landmark)
--                     values 
--                     (
--                         v_product_shipmentid, v_product_cartid,v_shipment_name, v_shipment_address1, v_shipment_address2,
--                         v_shipment_state, v_shipment_city, v_shipment_pincode, v_shipment_mobile_no, v_isshipment_billing_addresssame, 
--                         v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
--                         v_billing_mobile_no, v_promocode, v_bill_amount, v_fees, v_taxes, v_deductions, v_total_amount,
--                         v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_shipping_country,
-- 						v_shipment_state_id,v_shipment_city_id,v_shipment_country_id,v_gst_no,v_billing_district,v_billing_landmark
--                     );
                    
--                 else
                
--                     update labrr.labrr_product_shipment_user 
--                     set            	 
--                         shipment_name = v_shipment_name, 
--                         shipment_address1 = v_shipment_address1, 
--                         shipment_address2 = v_shipment_address2, 
--                         shipment_state = v_shipment_city, 
--                         shipment_city = v_shipment_city, 
--                         shipment_pincode = v_shipment_pincode,
--                         shipment_mobile_no = v_shipment_mobile_no, 
--                         is_shipment_billing_address_same = v_isshipment_billing_addresssame, 
--                         billing_name = v_billing_name, 
--                         billing_address1 = v_billing_address1, 
--                         billing_address2 = v_billing_address2, 
--                         billing_state = v_billing_state, 
--                         billing_city = v_billing_city, 
--                         billing_pincode = v_billing_pincode ,
--                         billing_mobile_no = v_billing_mobile_no, 
--                         promocode = v_promocode, 
--                         bill_amount = v_bill_amount, 
--                         billing_user_emailid = v_billing_emailid,
-- 						billing_country=v_billing_country,
-- 						shipping_country=v_shipping_country,
--                         fees = v_fees, 
--                         taxes = v_taxes , 
--                         deductions = v_deductions, 
--                         total_amount = v_total_amount,                  
--                         updated_date = v_sysdate,
-- 						gst_no=v_gst_no,
-- 						billing_district=v_billing_district,
-- 						billing_landmark=v_billing_landmark
--                     where product_cart_id = v_product_cartid
--                     and is_active = 1 
--                     and is_deleted = 0;
-- 				end if;
--         end if;
        
-- 		p_result := 1;

-- 		p_data := v_json;
		
		
		
		
	--else
	
		-- p_result := -1;

		--p_data := '{}';
	
	-- end if;
		
	
/*	exception 
		when others then 
			p_result := -1;
			p_data := '{}';
			
			
*/	

  
END;

  

$$;


--
