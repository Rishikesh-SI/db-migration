-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_product_cart(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_product_cart(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_product_cart(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

v_json 							jsonb;
v_product_cartid 				numeric;
v_product_id					numeric;
v_userid 						numeric;
v_total_selproduct				numeric;
v_base_price					decimal;
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
v_billing_address               character varying(1000);
v_billing_district				character varying(1000);
v_billing_landmark				character varying(1000);
v_billing_address2				character varying(1000);
v_billing_mobile_no				character varying(1000);
v_billing_pincode				character varying(1000);
v_billing_state					character varying(1000);
v_billing_city					character varying(1000);
v_delivery_name					character varying(1000);
v_shipment_address1				character varying(1000);
v_shipment_address2				character varying(1000);
v_delivery_mobile_no			character varying(1000);
v_delivery_state				character varying(1000);
v_delivery_city					character varying(1000);
v_delivery_pincode				character varying(1000);
v_delivery_address				character varying(1000);
v_delivery_email				character varying(1000);
v_fees							numeric;
v_shipment_guid					character varying(1000);
v_promocode						character varying(1000);
v_deductions					numeric;
v_isshipment_billing_addresssame numeric;
v_taxes 						numeric;
v_cart_guid						character varying(1000);
v_product_cart_detailsid		numeric;
v_product_skuid1				character varying(1000);
v_product_skuid					numeric;
v_sku_code						character varying(1000);
v_payment_info					character varying(1000);
v_product_price 				numeric;
v_quantity						numeric;
v_product_customize_map_id1		character varying;
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
v_delivery_country              character varying(1000);
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
v_discount_amt                  decimal;
v_old_user                      numeric;
v_personalised_name             text;
v_personalised_number           numeric;
v_is_personalised               numeric;
v_currency                      character varying; 
v_is_login numeric;
v_is_other_prices numeric;
v_donation_cause                character varying; 
v_pancard                character varying; 
v_is_membership numeric;
v_discount_code character varying; 
v_discount_type character varying;
v_gst_amount decimal;
v_cgst_amount decimal;
v_sgst_amount decimal;
v_gst numeric;
v_cgst numeric;
v_sgst numeric;
v_total_price decimal;
v_discount_price decimal;
v_product_group_code numeric;
v_delivery_firstname character varying;
v_delivery_lastname	character varying;
v_billing_firstname	character varying;
v_billing_lastname	character varying;
v_additional_price numeric;
v_membership_intiated_from character varying;
v_official_jersey boolean;
v_total_membership_price numeric;
v_jersey_base_price numeric;
v_jersey_gst numeric;
v_jersey_cgst numeric;
v_jersey_sgst numeric;
v_jersey_gst_amount numeric;
v_jersey_cgst_amount numeric;
v_jersey_sgst_amount numeric;
v_total_jersey_price numeric;
v_in_app_purchase numeric;

BEGIN

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'_ins_upd_product_cart',
	'{"exception":""}',uuid_generate_v4(),p_json,CURRENT_TIMESTAMP,'labrr','db-error');

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

		
		SELECT 	--v_json->'data'->>'product_cart_id',
				--v_json->'data'->>'user_id',
                v_json->'data'->>'donation_cause',
                --v_json->'data'->>'user_mailid',
                --v_json->'data'->>'is_login_user',
				--v_json->'data'->>'total_select_product',
				v_json->'data'->>'amount',
                v_json->'data'->>'currency',
				--v_json->'data'->>'delivery_charges',
				--v_json->'data'->>'payment_gateway_cancel_url',
				--v_json->'data'->>'payment_gateway_redirect_url',
				--v_json->'data'->>'payment_gateway_reference_no',
				--v_json->'data'->>'payment_status',
				--v_json->'data'->>'created_by',
				--v_json->'data'->>'updated_by',	
                --v_json->'data'->>'user_cart_guid',
				v_json->'data'->>'cartdetails',
				v_json->'data'->'user_info',
				v_json->'data'->>'user_guid',
				v_json->'data'->>'product_id',
				v_json->'data'->>'membership_intiated_from',
				v_json->'data'->>'official_jersey',
                v_json->'data'->>'in_app_purchase'
                
		INTO            
				--v_product_cartid,
				--v_userid,
                v_donation_cause,
               -- v_user_mailid,
                --v_is_loginuser,
				--v_total_selproduct,
				v_base_price,
                v_currency,
				--v_delivery_charges,
				--v_paygateway_cancelurl,
				--v_paygateway_redirecturl,
				--v_paygateway_referenceno,
				--v_pay_status,								
				--v_created_by,
				--V_updated_by,
                --v_cart_guid,
				v_cartdetails_json,
				v_shipmentadd_json,
				v_user_guid,
				v_product_id,
				v_membership_intiated_from,
				v_official_jersey,
                v_in_app_purchase
				;
        ---------------------------------------------------------------
        select add_info->>'is_login',add_info->>'is_other_prices',add_info->>'is_membership',gst,cgst,sgst,product_group_code,add_info->>'jersey_gst',add_info->>'jersey_cgst',add_info->>'jersey_sgst' from labrr.labrr_product 
		where product_id= v_product_id into v_is_login,v_is_other_prices,v_is_membership,v_gst,v_cgst,v_sgst,v_product_group_code,v_jersey_gst,v_jersey_cgst,v_jersey_sgst; 
		

		if v_is_other_prices = 0 THEN
			select product_price from labrr.labrr_product where product_id=v_product_id into v_base_price;
		end if;
		
		
                
		--------------------------------------------------------------- 
		      
       
		select  v_shipmentadd_json->>'product_shipment_id',	
                v_shipmentadd_json->>'pancard',
				v_shipmentadd_json->>'total_amount',
				v_shipmentadd_json->>'bill_amount',
				v_shipmentadd_json->>'billing_name',
				v_shipmentadd_json->>'billing_firstname',
				v_shipmentadd_json->>'billing_lastname',
                v_shipmentadd_json->>'billing_address',
				--v_shipmentadd_json->>'billing_address1',
				--v_shipmentadd_json->>'billing_address2',
				v_shipmentadd_json->>'billing_tel',
				v_shipmentadd_json->>'billing_zip',
				v_shipmentadd_json->>'billing_state',
				v_shipmentadd_json->>'billing_city',
				v_shipmentadd_json->>'delivery_name',
				v_shipmentadd_json->>'delivery_firstname',
				v_shipmentadd_json->>'delivery_lastname',
				--v_shipmentadd_json->>'shipment_address1',
				--v_shipmentadd_json->>'shipment_address2',
				v_shipmentadd_json->>'delivery_tel',
				v_shipmentadd_json->>'delivery_state',
				v_shipmentadd_json->>'delivery_city',
				v_shipmentadd_json->>'delivery_zip',
                v_shipmentadd_json->>'delivery_address',
                v_shipmentadd_json->>'delivery_email',
				v_shipmentadd_json->>'fees',
				v_shipmentadd_json->>'shipment_guid',
				--v_shipmentadd_json->>'promocode',
				--v_shipmentadd_json->>'deductions',
				--v_shipmentadd_json->>'is_shipment_billing_address_same',
				--v_shipmentadd_json->>'taxes',
                v_shipmentadd_json->>'billing_email',
				v_shipmentadd_json->>'billing_country',
				v_shipmentadd_json->>'delivery_country',
				--v_shipmentadd_json->>'shipping_state_id',
				--v_shipmentadd_json->>'shipping_city_id'	,
				v_shipmentadd_json->>'gst_no',
				v_shipmentadd_json->>'billing_district',
				v_shipmentadd_json->>'billing_landmark'
				--v_shipmentadd_json->>'membership_owner',
				--v_shipmentadd_json->>'name_on_card',
				--v_shipmentadd_json->>'whatsapp_consent',
				--v_shipmentadd_json->>'is_discount_user',
				--v_shipmentadd_json->>'personalised_name',
				--v_shipmentadd_json->>'personalised_number',
				--v_shipmentadd_json->>'is_personalised'
		into 
				v_product_shipmentid,	
                v_pancard,
				v_total_amount,
				v_bill_amount,
				v_billing_name,
				v_billing_firstname,
				v_billing_lastname,
                v_billing_address,
				--v_billing_address1,
				--v_billing_address2,
				v_billing_mobile_no,
				v_billing_pincode,
				v_billing_state,
				v_billing_city,
				v_delivery_name,
				v_delivery_firstname,
				v_delivery_lastname,
				--v_shipment_address1,
				--v_shipment_address2,
				v_delivery_mobile_no,
				v_delivery_state,
				v_delivery_city,
				v_delivery_pincode,
                v_delivery_address,
                v_delivery_email,
				v_fees,
				v_shipment_guid,
				--v_promocode,
				--v_deductions,
				--v_isshipment_billing_addresssame,
				--v_taxes,
                v_billing_emailid,
				v_billing_country,
				v_delivery_country,
				--v_shipment_state_id,
				--v_shipment_city_id,
				v_gst_no,
				v_billing_district,
				v_billing_landmark
				--v_membership_owner,
				--v_name_on_card,
				--v_whatsapp_consent,
				--v_is_discount_user,
				--v_personalised_name,
				--v_personalised_number,
				--v_is_personalised
                ;
				
				
            for v_cartdetails in select * from json_array_elements(v_cartdetails_json)
            loop
				select  v_cartdetails->>'discount_code',								
                        v_cartdetails->>'discount_type'
                into 	
				v_discount_code,
                v_discount_type;
                end loop;
                if (v_discount_code='' or v_discount_type='' or v_discount_code='null' or v_discount_type='null') then
                v_discount_code:=null;
                v_discount_type:=null;
                end if;
				
		--Check if discount coupon, product_code is not null it means coupon is tier specific      
        if (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type) and product_code is not null limit 1) then			
				select product_code into v_product_code from labrr.labrr_product where product_id=v_product_id;   
        end if;
                
	if v_base_price > 0 and v_billing_emailid<>'' and v_billing_mobile_no<>'' and v_delivery_email<>'' and v_delivery_mobile_no<>'' 
		 then 
			if v_is_login=0 then	
				
				v_product_shipmentid   := nextval('labrr.seq_labrr_product_shipment_user_id');
				v_shipment_guid := uuid_generate_v4();
				
				v_product_cartid   := nextval('labrr.seq_labrr_product_cart_id');
			     v_json 	       := jsonb_set(v_json, '{data,product_cart_id}', ('"'||v_product_cartid||'"')::text::jsonb, true);
				 

				 
				 
				
				insert into labrr.labrr_product_cart
			(
				product_cart_id, user_id, user_emailid, is_login_user, total_select_product, total_price, delivery_charges, payment_gateway_reference_no,
				payment_gateway_cancel_url, payment_gateway_redirect_url, payment_status, transaction_date, created_date,
				updated_date, created_by, updated_by, user_cart_guid, is_active, is_deleted, cart_json,user_guid,product_id,membership_owner,
				name_on_card,whatsapp_consent,discount_percent,personalised_name,personalised_number,is_personalised,donation_cause
			)    
			values
			(
				v_product_cartid, v_userid, 
				v_user_mailid, 
				v_is_loginuser,  
				v_total_selproduct, v_base_price, v_delivery_charges, v_paygateway_referenceno,
				v_paygateway_cancelurl, v_paygateway_redirecturl, v_pay_status, v_sysdate,  v_sysdate, v_sysdate, 1, 1, 
				v_user_guid , 1 ,0, v_json ,v_user_guid,v_product_id,v_membership_owner,v_name_on_card,v_whatsapp_consent,v_discount,
				v_personalised_name,v_personalised_number,v_is_personalised,v_donation_cause);  
				
				
		 insert into  labrr.labrr_product_shipment_user
                    (product_shipment_user_id, product_cart_id, delivery_name, shipment_address1, shipment_address2, 
                     delivery_state, delivery_city, delivery_pincode, delivery_mobile_no, is_shipment_billing_address_same, 
                     billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
                     billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, 
                     is_active, is_deleted, shipment_guid, billing_user_emailid, billing_country, delivery_country,shipment_state_id, 
                     shipment_city_id, shipment_country_id, gst_no, billing_district, billing_landmark, currency, 
                     delivery_address, delivery_email,billing_address,pancard,delivery_firstname,delivery_lastname,billing_firstname,billing_lastname)
                    values 
                    (
                        v_product_shipmentid, v_product_cartid,v_delivery_name, v_shipment_address1, v_shipment_address2,
                        v_delivery_state, v_delivery_city, v_delivery_pincode, v_delivery_mobile_no, v_isshipment_billing_addresssame, 
                        v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
                        v_billing_mobile_no, v_promocode, v_base_price, v_fees, v_taxes, v_deductions, v_base_price,
                        v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_delivery_country,
						v_shipment_state_id,v_shipment_city_id,v_shipment_country_id,v_gst_no,v_billing_district,v_billing_landmark,v_currency,
                        v_delivery_address,v_delivery_email,v_billing_address,v_pancard,v_delivery_firstname,v_delivery_lastname,v_billing_firstname,v_billing_lastname
                    );
                    
            if v_cartdetails_json is not null then 	
		          		
            for v_cartdetails in select * from json_array_elements(v_cartdetails_json)
            loop
                    select  v_cartdetails->>'product_cart_details_id',								
                            v_cartdetails->>'product_sku_id',
                            v_cartdetails->>'sku_code',
                            v_cartdetails->>'payment_info',                            
                            v_cartdetails->>'quantity',                          
                            v_cartdetails->>'product_customize_map_id',
                            v_cartdetails->>'is_customize',
                            v_cartdetails->>'customize_text',								
                            v_cartdetails->>'is_return',
							--v_cartdetails->>'Product_Id',
							v_cartdetails->>'customize_price'
                    into 		
                            v_product_cart_detailsid,
                            v_product_skuid,
                            v_sku_code,
                            v_payment_info,                           
                            v_quantity,                          
                            v_product_customize_map_id1,
                            v_is_customize,
                            v_customize_text,
                            v_is_return ,
							--v_product_id,
							v_customize_price
                    ;
					if v_product_customize_map_id1 is null or v_product_customize_map_id1='' THEN
					v_product_customize_map_id:=0;
					ELSE
					v_product_customize_map_id:=v_product_customize_map_id1::numeric;
					end if;
-- 					if v_product_skuid1 is null or v_product_skuid1='' THEN
-- 					v_product_skuid:=0;
-- 					ELSE
-- 					v_product_skuid:=v_product_skuid1::numeric;
-- 					end if;
					

                    v_cartdetails_guid := uuid_generate_v4();	
                    v_product_cart_detailsid   := nextval('labrr.seq_labrr_product_cart_details_id');	
					
				-- raise notice '%',v_product_skuid;
				
                  select product_price into  v_product_price 
				  from labrr.labrr_product_sku 
                  where product_sku_id = v_product_skuid 
                  and is_active = 1 and is_deleted = 0; 
                  
                  select customize_price 
				  into  v_customize_price 
                  from labrr.labrr_product_customize_map 
                  where product_customize_map_id = v_product_customize_map_id 
                  and is_active = 1 and is_deleted = 0;
                  

                                   
                  if not exists (select 1 from labrr.labrr_product_cart_details 
                                 where product_sku_id = v_product_skuid
                                 and  product_cart_id = v_product_cartid
                                 and is_active = 1 
                                 and is_deleted = 0)
                  then
                         
                    insert into labrr.labrr_product_cart_details
                    (
                        product_cart_details_id, product_cart_id, product_sku_id, sku_code, product_price, quantity, is_customize, 
                        product_customize_map_id, customize_text, payment_info, is_return, created_date, updated_date, created_by,	updated_by,	
                        pcd_guid, is_active, is_deleted, customize_price ,product_id
                    )
                    values
                    ( v_product_cart_detailsid, v_product_cartid, v_product_skuid, v_sku_code, (v_quantity * v_product_price), v_quantity, v_is_customize,
                      v_product_customize_map_id, v_customize_text, v_payment_info, v_is_return, v_sysdate, v_sysdate, 1, 1,
                      v_cartdetails_guid, 1, 0 , (v_customize_price * v_quantity),	v_product_id);	
                    
				 else
                 
                	update labrr.labrr_product_cart_details 
                    set    product_price = (v_quantity * v_product_price), 
                    	   quantity = v_quantity , 
                           is_customize = v_is_customize, 
                           product_customize_map_id = v_product_customize_map_id, 
                           customize_text = v_customize_text,
                           customize_price = (v_customize_price * v_quantity),
                           payment_info = v_payment_info, 
                           is_return = v_is_return,                         
                           updated_date = v_sysdate,
						   product_id=v_product_id
                    where product_sku_id = v_product_skuid
                    and  product_cart_id = v_product_cartid
                    and is_active = 1 
                    and is_deleted = 0;                 
                                          
                 end if ;   
                
            end loop ;
            
        end if ;
        v_total_product_count:=1;
		/*  
		  select 1 as total_product_count
       	  into v_total_product_count 
          from labrr.labrr_product_cart_details a         
          where a.product_cart_id = v_product_cartid and product_sku_id = v_product_skuid
          and a.is_active = 1 
          and a.is_deleted = 0 ;
            */
		
         v_delivery_charges := coalesce(v_delivery_charges,0);
         v_payable_amount := v_base_price + coalesce(v_delivery_charges,0);
                 

        update labrr.labrr_product_cart 
        set total_select_product =  v_total_product_count,
        	total_price = v_base_price,
            delivery_charges =v_delivery_charges ,
            transaction_date = v_sysdate, 				
			updated_date = v_sysdate,
            cart_json = v_json
        where product_cart_id = v_product_cartid
        and is_active = 1 
        and is_deleted = 0 ;
        

					
			v_json:= jsonb_set(v_json, '{data,amount}', ('"'||v_base_price||'"')::text::jsonb, true);
            
				
			p_result := 1;

           p_data := v_json;
		   
		   
		   elsif v_is_login=1 THEN
		   
		   
		   --Checks if product_group_code or product id exist or not before si-initiated or success the new payment
		   --(Ex: Pro and elite have same product_group_code so user can buy only one of them 
		   --or if user already initiated the payment, he/she cannot can't initiated payment for same product until previous one status changed as failure)
           if (not exists (select 1 from labrr.labrr_product p join labrr.labrr_product_cart pc on pc.product_id=p.product_id join labrr.labrr_product_cart_paydetails pcp on pcp.product_cart_id=pc.product_cart_id 
						where pc.user_guid=v_user_guid and lower(pcp.order_status) in ('success','si-initiated') 
						and pcp.module_name='membership'and (pc.product_id=v_product_id or p.product_group_code=v_product_group_code)) and not exists (select 1 from labrr.labrr_product_cart_paydetails
						where user_guid=v_user_guid and lower(order_status)='si-initiated'
						and module_name='membership')) 
						and v_is_membership = 1 and ((nullif(v_membership_intiated_from,'') is not null and coalesce(v_in_app_purchase,0)=0) or v_in_app_purchase=1) and
						(v_billing_state <>'' and v_delivery_state <>'' and v_billing_city <>'' and
						v_delivery_city <>'' and v_billing_address <>'' and v_delivery_address <>'' and v_billing_pincode <>'' and v_delivery_pincode <>'') 
                        then --Membership
						
		-- Pro/Elite with default jersey and official_jersey should not be false if json contain customize jersey				
		if (exists(select 1 from jsonb_array_elements((v_json->'data'->>'cartdetails')::jsonb)x where (nullif((x->>'type_id'),''))::int=0 and v_product_id in (21,22)) or v_product_id=24) and 
		not exists (select 1 from jsonb_array_elements((v_json->'data'->>'cartdetails')::jsonb)x where (nullif((x->>'type_id'),''))::int=1 and v_official_jersey=false and v_product_id in (21,22,24))
		then
		
		--Unique coupon users cannot add customize jersey in their cart 
		if (v_official_jersey=true and (lower(v_discount_type)=lower('COMMON') or v_discount_type is null)) or
        (v_official_jersey=false and (lower(v_discount_type)=lower('COMMON') or v_discount_type is null)) or
		 (v_official_jersey=false and lower(v_discount_type)=lower('UNIQUE')) then
						
		--User can't buy Insider if pro/elite membership is already present 
		if exists (select 1 from labrr.labrr_product_cart pc join labrr.labrr_product_cart_paydetails 
						pcp on pcp.product_cart_id=pc.product_cart_id where pcp.user_guid=v_user_guid and pc.product_id in (21,22) and lower(pcp.order_status) in ('success')) 
						and v_product_id in (24) THEN
                        
           p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "Pro/Elite Membership already active",
                 "error_status": 1
                    }
                }';
                        
                        
        else 
		   
           if (exists(select 1 from labrr.labrr_product_discount_coupon where is_active=1 and expiry_date>=current_timestamp+'5:30 hours'::interval and is_used<>1
			and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'') and lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type)) 
			or v_discount_code is null or v_discount_type is null) 
            and not exists (select 1 from labrr.labrr_product_discount_coupon_map where lower(discount_code)=lower(v_discount_code) and coalesce(lower(product_code),'')=coalesce(lower(v_product_code))) then
			
    
           v_product_shipmentid   := nextval('labrr.seq_labrr_product_shipment_user_id');
				v_shipment_guid := uuid_generate_v4();
				
				v_product_cartid   := nextval('labrr.seq_labrr_product_cart_id');
			     v_json 	       := jsonb_set(v_json, '{data,product_cart_id}', ('"'||v_product_cartid||'"')::text::jsonb, true);
                 

				 
		
				 
				
				insert into labrr.labrr_product_cart
			(
				product_cart_id, user_id, user_emailid, is_login_user, total_select_product, total_price, delivery_charges, payment_gateway_reference_no,
				payment_gateway_cancel_url, payment_gateway_redirect_url, payment_status, transaction_date, created_date,
				updated_date, created_by, updated_by, user_cart_guid, is_active, is_deleted, cart_json,user_guid,product_id,membership_owner,
				name_on_card,whatsapp_consent,discount_percent,personalised_name,personalised_number,is_personalised,donation_cause
			)    
			values
			(
				v_product_cartid, v_userid, 
				v_user_mailid, 
				v_is_loginuser,  
				v_total_selproduct, v_base_price, v_delivery_charges, v_paygateway_referenceno,
				v_paygateway_cancelurl, v_paygateway_redirecturl, v_pay_status, v_sysdate,  v_sysdate, v_sysdate, 1, 1, 
				v_user_guid , 1 ,0, v_json ,v_user_guid,v_product_id,v_membership_owner,v_name_on_card,v_whatsapp_consent,v_discount,
				v_personalised_name,v_personalised_number,v_is_personalised,v_donation_cause);  
				
				
		 insert into  labrr.labrr_product_shipment_user
                    (product_shipment_user_id, product_cart_id, delivery_name, shipment_address1, shipment_address2, 
                     delivery_state, delivery_city, delivery_pincode, delivery_mobile_no, is_shipment_billing_address_same, 
                     billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
                     billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, 
                     is_active, is_deleted, shipment_guid, billing_user_emailid, billing_country, delivery_country,shipment_state_id, 
                     shipment_city_id, shipment_country_id, gst_no, billing_district, billing_landmark, currency, 
                     delivery_address, delivery_email,billing_address,pancard,discounted_amount,gst_amount,cgst_amount,sgst_amount,discount_code,discount_type,
					 delivery_firstname,delivery_lastname,billing_firstname,billing_lastname)
                    values 
                    (
                        v_product_shipmentid, v_product_cartid,v_delivery_name, v_shipment_address1, v_shipment_address2,
                        v_delivery_state, v_delivery_city, v_delivery_pincode, v_delivery_mobile_no, v_isshipment_billing_addresssame, 
                        v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
                        v_billing_mobile_no, v_promocode, v_total_price, v_fees, v_taxes, v_deductions, v_total_price,
                        v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_delivery_country,
						v_shipment_state_id,v_shipment_city_id,v_shipment_country_id,v_gst_no,v_billing_district,v_billing_landmark,v_currency,
                        v_delivery_address,v_delivery_email,v_billing_address,v_pancard,v_discount_amt,v_gst_amount,v_cgst_amount,v_sgst_amount,v_discount_code,v_discount_type,
						v_delivery_firstname,v_delivery_lastname,v_billing_firstname,v_billing_lastname
                    );
                    
            if v_cartdetails_json is not null then 	
		          		
            for v_cartdetails in select * from json_array_elements(v_cartdetails_json)
            loop
                    select  v_cartdetails->>'product_cart_details_id',								
                            v_cartdetails->>'product_sku_id',
                            v_cartdetails->>'sku_code',
                            v_cartdetails->>'payment_info',                            
                            v_cartdetails->>'quantity',                          
                            v_cartdetails->>'product_customize_map_id',
                            v_cartdetails->>'is_customize',
                            v_cartdetails->>'customize_text',								
                            v_cartdetails->>'is_return',
							--v_cartdetails->>'Product_Id',
							v_cartdetails->>'customize_price'
                    into 		
                            v_product_cart_detailsid,
                            v_product_skuid,
                            v_sku_code,
                            v_payment_info,                           
                            v_quantity,                          
                            v_product_customize_map_id1,
                            v_is_customize,
                            v_customize_text,
                            v_is_return ,
							--v_product_id,
							v_customize_price
                          
                    ;
					if v_product_customize_map_id1 is null or v_product_customize_map_id1='' THEN
					v_product_customize_map_id:=0;
					ELSE
					v_product_customize_map_id:=v_product_customize_map_id1::numeric;
					end if;
-- 					if v_product_skuid1 is null or v_product_skuid1='' THEN
-- 					v_product_skuid:=0;
-- 					ELSE
-- 					v_product_skuid:=v_product_skuid1::numeric;
-- 					end if;

                    v_cartdetails_guid := uuid_generate_v4();	
                    v_product_cart_detailsid   := nextval('labrr.seq_labrr_product_cart_details_id');	
					
				-- raise notice '%',v_product_skuid;
				
                  select product_price into  v_product_price 
				  from labrr.labrr_product_sku 
                  where product_sku_id = v_product_skuid 
                  and is_active = 1 and is_deleted = 0; 
                  
                  select customize_price 
				  into  v_customize_price 
                  from labrr.labrr_product_customize_map 
                  where product_customize_map_id = v_product_customize_map_id 
                  and is_active = 1 and is_deleted = 0;
                  

                                   
                  if not exists (select 1 from labrr.labrr_product_cart_details 
                                 where product_sku_id = v_product_skuid
                                 and  product_cart_id = v_product_cartid
								 and product_customize_map_id = v_product_customize_map_id
                                 and is_active = 1 
                                 and is_deleted = 0)
                  then
                         
                    insert into labrr.labrr_product_cart_details
                    (
                        product_cart_details_id, product_cart_id, product_sku_id, sku_code, product_price, quantity, is_customize, 
                        product_customize_map_id, customize_text, payment_info, is_return, created_date, updated_date, created_by,	updated_by,	
                        pcd_guid, is_active, is_deleted, customize_price ,product_id,cartdetails_json
                    )
                    values
                    ( v_product_cart_detailsid, v_product_cartid, v_product_skuid, v_sku_code, (v_quantity * v_product_price), v_quantity, v_is_customize,
                      v_product_customize_map_id, v_customize_text, v_payment_info, v_is_return, v_sysdate, v_sysdate, 1, 1,
                      v_cartdetails_guid, 1, 0 , (v_customize_price * v_quantity),	v_product_id,v_cartdetails::jsonb);	
                    
				 else
                 
                	update labrr.labrr_product_cart_details 
                    set    product_price = (v_quantity * v_product_price), 
                    	   quantity = v_quantity , 
                           is_customize = v_is_customize, 
                           product_customize_map_id = v_product_customize_map_id, 
                           customize_text = v_customize_text,
                           customize_price = (v_customize_price * v_quantity),
                           payment_info = v_payment_info, 
                           is_return = v_is_return,                         
                           updated_date = v_sysdate,
						   product_id=v_product_id,
                           cartdetails_json=v_cartdetails::jsonb
                    where product_sku_id = v_product_skuid
                    and  product_cart_id = v_product_cartid
					and product_customize_map_id = v_product_customize_map_id
                    and is_active = 1 
                    and is_deleted = 0;                 
                                          
                 end if ;   
                
            end loop ;
            
        end if ;
		
		
			if lower(v_discount_type)=lower('UNIQUE') THEN
			
			--update labrr.labrr_product_discount_coupon set is_used=1 
            --where lower(discount_type)=lower(v_discount_type) and 
            --lower(discount_code)=lower(v_discount_code);
			
			v_base_price:=0;
            v_gst_amount:=0;
            v_cgst_amount:=0;
            v_sgst_amount:=0;
			v_total_membership_price:=0;
			v_jersey_base_price:=0;
			v_jersey_gst_amount:=0;
			v_jersey_cgst_amount:=0;
			v_jersey_sgst_amount:=0;
			v_total_jersey_price:=0;
            v_total_price:=0;
			
            elsif lower(v_discount_type)=lower('COMMON') then
			
			select sum(coalesce(customize_price,0)) into v_jersey_base_price from labrr.labrr_product_cart_details where product_cart_id=v_product_cartid;
			
			--Jersey Calculation
			v_jersey_gst_amount:= ROUND((v_jersey_base_price*v_jersey_gst)/100,2);
            v_jersey_cgst_amount:= ROUND(v_jersey_gst_amount/2,2);
            v_jersey_sgst_amount:= ROUND(v_jersey_gst_amount/2,2);
            v_total_jersey_price:=ROUND(v_jersey_base_price+v_jersey_gst_amount,2);
			
            
            select discount into v_discount from labrr.labrr_product_discount_coupon where lower(discount_type)=lower(v_discount_type) and lower(discount_code)=lower(v_discount_code) and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),''); 
            
            if (select 1 from labrr.labrr_product_discount_coupon where lower(discount_type)=lower(v_discount_type) and lower(discount_code)=lower(v_discount_code) and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'') and is_percent=0) then
			--Membership calculation 
                v_discount_amt=ROUND(v_base_price-v_discount,2);
                v_gst_amount:= ROUND((v_discount_amt*v_gst)/100,2);
                v_cgst_amount:= ROUND(v_gst_amount/2,2);
                v_sgst_amount:= ROUND(v_gst_amount/2,2);
                v_total_membership_price:=ROUND(v_discount_amt+v_gst_amount,2);
				
				v_total_price:=ROUND(v_total_membership_price+v_total_jersey_price,2);
				
            else

            v_discount_price:=ROUND((v_base_price*v_discount)/100,2);
            v_discount_amt=v_base_price-v_discount_price;
            v_gst_amount:= ROUND((v_discount_amt*v_gst)/100,2);
            v_cgst_amount:= ROUND(v_gst_amount/2,2);
            v_sgst_amount:= ROUND(v_gst_amount/2,2);
            v_total_membership_price:=ROUND(v_discount_amt+v_gst_amount,2);
			
			v_total_price:=ROUND(v_total_membership_price+v_total_jersey_price,2);
			
            end if;
            
            else

            select sum(coalesce(customize_price,0)) into v_jersey_base_price from labrr.labrr_product_cart_details where product_cart_id=v_product_cartid;

			--Jersey Calculation
			v_jersey_gst_amount:= ROUND((v_jersey_base_price*v_jersey_gst)/100,2);
            v_jersey_cgst_amount:= ROUND(v_jersey_gst_amount/2,2);
            v_jersey_sgst_amount:= ROUND(v_jersey_gst_amount/2,2);
            v_total_jersey_price:=ROUND(v_jersey_base_price+v_jersey_gst_amount,2);
			
            --Membership Calculation
            v_discount_amt:=v_base_price;
            v_gst_amount:= ROUND((v_base_price*v_gst)/100,2);
            v_cgst_amount:= ROUND(v_gst_amount/2,2);
            v_sgst_amount:= ROUND(v_gst_amount/2,2);
            v_total_membership_price:=ROUND(v_base_price+v_gst_amount,2);
			
			v_total_price:=ROUND(v_total_membership_price+v_total_jersey_price,2);
		
			end if;	 

            
           v_total_product_count:=1; 
		  /*
		  select 1 as total_product_count
       	  into v_total_product_count 
          from labrr.labrr_product_cart_details a         
          where a.product_cart_id = v_product_cartid and product_sku_id = v_product_skuid
          and a.is_active = 1 
          and a.is_deleted = 0 ;*/
          
          raise notice 'v_total_price:%',v_total_price;

                 

        update labrr.labrr_product_cart 
        set total_select_product =  v_total_product_count,
        	total_price = v_total_price,
            delivery_charges =v_delivery_charges ,
            transaction_date = v_sysdate, 				
			updated_date = v_sysdate,
            cart_json = v_json
			
        where product_cart_id = v_product_cartid
        and is_active = 1 
        and is_deleted = 0 ;
		
		update labrr.labrr_product_shipment_user
		set gst_amount=v_gst_amount,
		cgst_amount=v_cgst_amount,
		sgst_amount=v_sgst_amount,
        discounted_amount=v_discount_amt,
		total_membership_price=v_total_membership_price,
		jersey_gst_amount=v_jersey_gst_amount,
		jersey_cgst_amount=v_jersey_cgst_amount,
		jersey_sgst_amount=v_jersey_sgst_amount,
		total_jersey_price=v_total_jersey_price
		where product_cart_id = v_product_cartid
        and is_active = 1 
        and is_deleted = 0;
        

			v_json:= jsonb_set(v_json, '{data,amount}', ('"'||coalesce(v_total_price::text,'')||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,discounted_amount}', ('"'||coalesce(v_discount_amt,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,gst_amount}', ('"'||coalesce(v_gst_amount,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,cgst_amount}', ('"'||coalesce(v_cgst_amount,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,sgst_amount}', ('"'||coalesce(v_sgst_amount,0)||'"')::jsonb, true);
			
			v_json:= jsonb_set(v_json, '{data,jersey_gst_amount}', ('"'||coalesce(v_jersey_gst_amount,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,jersey_cgst_amount}', ('"'||coalesce(v_jersey_cgst_amount,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,jersey_sgst_amount}', ('"'||coalesce(v_jersey_sgst_amount,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,total_membership_price}', ('"'||coalesce(v_total_membership_price,0)||'"')::jsonb, true);
            v_json:= jsonb_set(v_json, '{data,total_jersey_price}', ('"'||coalesce(v_total_jersey_price,0)||'"')::jsonb, true);			
			
            
            --v_json:= jsonb_set(v_json, '{data,base_amount}', ('"'||v_base_price||'"')::text::jsonb, true);
            --v_json:=jsonb_set(v_json,'{data,coupon_code}',('"'||coalesce(v_discount_code,'')||'"')::jsonb, true);
            --v_json:=jsonb_set(v_json,'{data,coupon_type}',('"'||coalesce(v_discount_type,'')||'"')::jsonb, true);
				
			p_result := 1;

           p_data := v_json;
		   
		   elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type) and coalesce(lower(product_code),'')<>coalesce(lower(v_product_code),'') and is_active=1 and expiry_date>=current_timestamp+'5:30 hours'::interval and is_used<>1) THEN 
		   
			p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "This coupon code is not applicable on the selected membership plan. Please select a different plan and retry.",
                 "error_status": 1
                    }
                }';						
           
           else
           
           p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "Invalid Coupon",
                 "error_status": 1
                    }
                }';
           
           end if;
		   

		   
		   
		   end if;
                  
                        
		   
		   elsif exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid) and v_is_membership = 0 THEN --Donation
		   
		   v_product_shipmentid   := nextval('labrr.seq_labrr_product_shipment_user_id');
				v_shipment_guid := uuid_generate_v4();
				
				v_product_cartid   := nextval('labrr.seq_labrr_product_cart_id');
			     v_json 	       := jsonb_set(v_json, '{data,product_cart_id}', ('"'||v_product_cartid||'"')::text::jsonb, true);
				 

				 
				 
				
				insert into labrr.labrr_product_cart
			(
				product_cart_id, user_id, user_emailid, is_login_user, total_select_product, total_price, delivery_charges, payment_gateway_reference_no,
				payment_gateway_cancel_url, payment_gateway_redirect_url, payment_status, transaction_date, created_date,
				updated_date, created_by, updated_by, user_cart_guid, is_active, is_deleted, cart_json,user_guid,product_id,membership_owner,
				name_on_card,whatsapp_consent,discount_percent,personalised_name,personalised_number,is_personalised,donation_cause
			)    
			values
			(
				v_product_cartid, v_userid, 
				v_user_mailid, 
				v_is_loginuser,  
				v_total_selproduct, v_base_price, v_delivery_charges, v_paygateway_referenceno,
				v_paygateway_cancelurl, v_paygateway_redirecturl, v_pay_status, v_sysdate,  v_sysdate, v_sysdate, 1, 1, 
				v_user_guid , 1 ,0, v_json ,v_user_guid,v_product_id,v_membership_owner,v_name_on_card,v_whatsapp_consent,v_discount,
				v_personalised_name,v_personalised_number,v_is_personalised,v_donation_cause);  
				
		 insert into  labrr.labrr_product_shipment_user
                    (product_shipment_user_id, product_cart_id, delivery_name, shipment_address1, shipment_address2, 
                     delivery_state, delivery_city, delivery_pincode, delivery_mobile_no, is_shipment_billing_address_same, 
                     billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
                     billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, 
                     is_active, is_deleted, shipment_guid, billing_user_emailid, billing_country, delivery_country,shipment_state_id, 
                     shipment_city_id, shipment_country_id, gst_no, billing_district, billing_landmark, currency, 
                     delivery_address, delivery_email,billing_address,pancard,delivery_firstname,delivery_lastname,billing_firstname,billing_lastname)
                    values 
                    (
                        v_product_shipmentid, v_product_cartid,v_delivery_name, v_shipment_address1, v_shipment_address2,
                        v_delivery_state, v_delivery_city, v_delivery_pincode, v_delivery_mobile_no, v_isshipment_billing_addresssame, 
                        v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
                        v_billing_mobile_no, v_promocode, v_base_price, v_fees, v_taxes, v_deductions, v_base_price,
                        v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_delivery_country,
						v_shipment_state_id,v_shipment_city_id,v_shipment_country_id,v_gst_no,v_billing_district,v_billing_landmark,v_currency,
                        v_delivery_address,v_delivery_email,v_billing_address,v_pancard,v_delivery_firstname,v_delivery_lastname,v_billing_firstname,v_billing_lastname
                    );
					
			v_json:= jsonb_set(v_json, '{data,amount}', ('"'||v_base_price||'"')::text::jsonb, true);	
			
			
				
			p_result := 1;

           p_data := v_json;	
           
			  
           elsif not exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid) then
           
           p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "User not found",
                 "error_status": 1
                    }
                }';

           elsif (v_billing_state ='' or v_delivery_state ='' or v_billing_city ='' or
						v_delivery_city  ='' or v_billing_address ='' or v_delivery_address ='' or v_billing_pincode ='' or
						v_delivery_pincode ='') then 
						
			p_result := 0;
			 p_data := '{
						 "data": {
						 "error_message": "Invalid Details",
						 "error_status": 1
							}
						}';
						
-- 			elsif(total_amount>=10000000)
-- 			then
-- 			p_result := 0;
-- 			p_data:='{
-- 					"data":{
-- 					"error_message":"Amount should not exceed more than 10000000",
-- 					"error_status":1
-- 					}
-- 				}';
			else
			    p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "Add-on jersey is not purchasable for unique discount codes",
                 "error_status": 1
                    }
                }';
			
			
			end if;
			else
			    p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "Invalid Cart Details",
                 "error_status": 1
                    }
                }';
			
			
			end if;
			
			
		   
		   else

   
		   p_result := 0;
           p_data := '{
                 "data": {
                 "error_message": "Your previous transaction to purchase membership is still being processed. Please keep an eye out on your registered email or try again in an hour, in case you do not receive any communication on your registered email.",
                 "error_status": 1
                    }
                }';
		   
		   end if;
           
		   
		   elsif not exists (select 1 from labrr.labrr_product where product_id=v_product_id) THEN 
		   p_result := 0;
		   --p_data := '{"data":{"message":"Product not found"}}';
           p_data := '{
                 "data": {
                 "error_message": "Product not found",
                 "error_status": 1
                    }
                }';
		   
		   ELSE
		   		   p_result := 0;   
		   --p_data := '{"data":{"message":"Invalid Request"}}';
           --is_login is not present
                p_data := '{
                 "data": {
                 "error_message": "Invalid Request",
                 "error_status": 1
                    }
                }';
		   
			end if;
			

	else
     p_result := 0;
     p_data := '{
                 "data": {
                 "error_message": "Invalid Details",
                 "error_status": 1
                    }
                }';
	end if;		

  
END;
$$;


--
