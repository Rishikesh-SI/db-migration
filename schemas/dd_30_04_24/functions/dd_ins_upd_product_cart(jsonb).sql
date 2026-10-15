-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_product_cart(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_product_cart(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_product_cart(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
v_billing_name					character varying(200);
v_billing_address1				character varying(200);
v_billing_address2				character varying(200);
v_billing_mobile_no				character varying(20);
v_billing_pincode				character varying(10);
v_billing_state					character varying(200);
v_billing_city					character varying(200);
v_shipment_name					character varying(200);
v_shipment_address1				character varying(200);
v_shipment_address2				character varying(200);
v_shipment_mobile_no			character varying(20);
v_shipment_state				character varying(200);
v_shipment_city					character varying(200);
v_shipment_pincode				character varying(10);
v_fees							numeric;
v_shipment_guid					character varying(100);
v_promocode						character varying(20);
v_deductions					numeric;
v_isshipment_billing_addresssame numeric;
v_taxes 						numeric;
v_cart_guid						character varying(100);
v_product_cart_detailsid		numeric;
v_product_skuid					numeric;
v_sku_code						character varying(100);
v_payment_info					character varying(100);
v_product_price 				numeric;
v_quantity						numeric;
v_product_customize_map_id		numeric;
v_is_customize					numeric;
v_customize_text				character varying(500);
v_is_return  					numeric;
v_cartdetails_guid				character varying(100);
v_user_mailid					character varying(500);
v_is_loginuser					numeric;
v_customize_price				numeric;
v_payable_amount				numeric;
v_total_product_count			numeric;
v_billing_emailid				character varying(500);
v_billing_country               character varying(500);
v_shipping_country              character varying(500);

BEGIN

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
				v_json->'data'->>'total_price',
				v_json->'data'->>'delivery_charges',
				v_json->'data'->>'payment_gateway_cancel_url',
				v_json->'data'->>'payment_gateway_redirect_url',
				v_json->'data'->>'payment_gateway_reference_no',
				v_json->'data'->>'payment_status',
				v_json->'data'->>'created_by',
				v_json->'data'->>'updated_by',	
                v_json->'data'->>'user_cart_guid',
				v_json->'data'->>'cartdetails',
				v_json->'data'->'shipmentadd'
				
				
				
		INTO            
				v_product_cartid,
				v_userid,
                v_user_mailid,
                v_is_loginuser,
				v_total_selproduct,
				v_total_price,
				v_delivery_charges,
				v_paygateway_cancelurl,
				v_paygateway_redirecturl,
				v_paygateway_referenceno,
				v_pay_status,								
				v_created_by,
				V_updated_by,
                v_cart_guid,
				v_cartdetails_json,
				v_shipmentadd_json
				;
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
				v_shipmentadd_json->>'shipping_country'
				
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
				v_shipping_country;
		
       select product_cart_id into v_product_cartid
       from dd.dd_product_cart 
       where user_cart_guid = v_cart_guid
       and coalesce(payment_gateway_redirect_url,'') not in ('true', 'false')
       and is_active = 1
       and is_deleted = 0;     
      
	  
	  
	-- v_delivery_charges :=  (case when v_total_price >500 then 0 else 60 end );
        
		if v_product_cartid is null then 
		
			-- v_cart_guid := uuid_generate_v4();	
			v_product_cartid   := nextval('dd.seq_dd_product_cart_id');
			
            
            v_json 	         := jsonb_set(v_json, '{data,product_cart_id}', v_product_cartid::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,user_cart_guid}', ('"'||v_cart_guid||'"')::text::jsonb, true);
			
			
			
			
			insert into dd.dd_product_cart
			(
				product_cart_id, user_id, user_emailid, is_login_user, total_select_product, total_price, delivery_charges, payment_gateway_reference_no,
				payment_gateway_cancel_url, payment_gateway_redirect_url, payment_status, transaction_date, created_date,
				updated_date, created_by, updated_by, user_cart_guid, is_active, is_deleted, cart_json
			)    
			values
			(
				v_product_cartid, v_userid, 
				v_user_mailid, 
				v_is_loginuser,  
				v_total_selproduct, v_total_price, v_delivery_charges, v_paygateway_referenceno,
				v_paygateway_cancelurl, v_paygateway_redirecturl, v_pay_status, v_sysdate,  v_sysdate, v_sysdate, 1, 1, 
				v_cart_guid , 1 ,0, v_json 
			);    
			            
		/* else
			update dd.dd_product_cart 
			set total_select_product = v_total_selproduct, 
				total_price = v_total_price, 
				delivery_charges = v_delivery_charges, 
                is_login_user = v_is_loginuser,				
				transaction_date = v_sysdate, 				
				updated_date = v_sysdate,				
				updated_by = 1, 				 
				is_active = 1, 
				is_deleted = 0, 
				cart_json = v_json
			where product_cart_id =  v_product_cartid
            -- and user_id = v_userid
            ;
			*/          
		end if ; 
		
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
							v_cartdetails->>'Product_Id',
							v_cartdetails->>'customize_price'
                    into 		
                            v_product_cart_detailsid,
                            v_product_skuid,
                            v_sku_code,
                            v_payment_info,                           
                            v_quantity,                          
                            v_product_customize_map_id,
                            v_is_customize,
                            v_customize_text,
                            v_is_return ,
							v_product_id,
							v_customize_price
                    ;

                    v_cartdetails_guid := uuid_generate_v4();	
                    v_product_cart_detailsid   := nextval('dd.seq_dd_product_cart_details_id');	
					
                  select product_price into  v_product_price 
				  from dd.dd_product_sku 
                  where product_sku_id = v_product_skuid 
                  and is_active = 1 and is_deleted = 0; 
                  
                  select customize_price 
				  into  v_customize_price 
                  from dd.dd_product_customize_map 
                  where product_customize_map_id = v_product_customize_map_id 
                  and is_active = 1 and is_deleted = 0;
                  

                                   
                  if not exists (select 1 from dd.dd_product_cart_details 
                                 where product_sku_id = v_product_skuid
                                 and  product_cart_id = v_product_cartid
                                 and is_active = 1 
                                 and is_deleted = 0)
                  then
                         
                    insert into dd.dd_product_cart_details
                    (
                        product_cart_details_id, product_cart_id, product_sku_id, sku_code, product_price, quantity, is_customize, 
                        product_customize_map_id, customize_text, payment_info, is_return, created_date, updated_date, created_by,	updated_by,	
                        pcd_guid, is_active, is_deleted, customize_price ,product_id
                    )
                    values
                    ( v_product_cart_detailsid, v_product_cartid, v_product_skuid, v_sku_code, (v_quantity * v_product_price), v_quantity, v_is_customize,
                      v_product_customize_map_id, v_customize_text, v_payment_info, v_is_return, v_sysdate, v_sysdate, 1, 1,
                      v_cartdetails_guid, 1, 0 , (v_customize_price * v_quantity),	v_product_id					  
                    );	
                    
				 else
                 
                	update dd.dd_product_cart_details 
                    set product_price = (v_quantity * v_product_price), 
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
		
        select sum(product_price + coalesce(customize_price,0)) total_price,  	
        		count(1) total_product_count
       	 into v_total_price,    		
    		  v_total_product_count 
          from dd.dd_product_cart_details a         
          where a.product_cart_id = v_product_cartid
          and a.is_active = 1 
          and a.is_deleted = 0 ;
        
        v_delivery_charges := (case when v_total_price >=500 then 0 else 60 end );
        v_payable_amount := v_total_price + coalesce(v_delivery_charges,0);
                
              --  select * from          dd.dd_product_cart 

        update dd.dd_product_cart 
        set total_select_product =  v_total_product_count,
        	total_price = v_total_price,
            delivery_charges =v_delivery_charges ,
            transaction_date = v_sysdate, 				
			updated_date = v_sysdate,
            cart_json = v_json
        where product_cart_id = v_product_cartid
        and is_active = 1 
        and is_deleted = 0 ;
        
        v_bill_amount := (v_total_price + v_delivery_charges);
        v_total_amount := (v_total_price + v_delivery_charges);
        v_bill_amount:= v_bill_amount+(case when lower(v_shipping_country)='nepal' then 300 else 0 end );
        
        if (v_shipmentadd_json::text != 'null') then
            		
               if not exists (select 1 from dd.dd_product_shipment_user
                           where product_cart_id = v_product_cartid
                		   and is_active = 1 
                			and is_deleted = 0 ) 
               then 
                	v_product_shipmentid   := nextval('dd.seq_dd_product_shipment_user_id');
					v_shipment_guid := uuid_generate_v4();
            
                    insert into  dd.dd_product_shipment_user
                    (product_shipment_user_id, product_cart_id, shipment_name, shipment_address1, shipment_address2, shipment_state, shipment_city, shipment_pincode,
                     shipment_mobile_no, is_shipment_billing_address_same, billing_name, billing_address1, billing_address2, billing_state, billing_city, billing_pincode,
                     billing_mobile_no, promocode, bill_amount, fees, taxes, deductions, total_amount, created_date, updated_date, is_active, is_deleted, shipment_guid,
                     billing_user_emailid,billing_country,shipping_country)
                    values 
                    (
                        v_product_shipmentid, v_product_cartid,v_shipment_name, v_shipment_address1, v_shipment_address2,
                        v_shipment_state, v_shipment_city, v_shipment_pincode, v_shipment_mobile_no, v_isshipment_billing_addresssame, 
                        v_billing_name, v_billing_address1,	v_billing_address2,	v_billing_state, v_billing_city, v_billing_pincode,
                        v_billing_mobile_no, v_promocode, v_bill_amount, v_fees, v_taxes, v_deductions, v_total_amount,
                        v_sysdate, v_sysdate, 1, 0,  v_shipment_guid, v_billing_emailid,v_billing_country,v_shipping_country
                    );
                    
                else
                
                    update dd.dd_product_shipment_user 
                    set            	 
                        shipment_name = v_shipment_name, 
                        shipment_address1 = v_shipment_address1, 
                        shipment_address2 = v_shipment_address2, 
                        shipment_state = v_shipment_city, 
                        shipment_city = v_shipment_city, 
                        shipment_pincode = v_shipment_pincode,
                        shipment_mobile_no = v_shipment_mobile_no, 
                        is_shipment_billing_address_same = v_isshipment_billing_addresssame, 
                        billing_name = v_billing_name, 
                        billing_address1 = v_billing_address1, 
                        billing_address2 = v_billing_address2, 
                        billing_state = v_billing_state, 
                        billing_city = v_billing_city, 
                        billing_pincode = v_billing_pincode ,
                        billing_mobile_no = v_billing_mobile_no, 
                        promocode = v_promocode, 
                        bill_amount = v_bill_amount, 
                        billing_user_emailid = v_billing_emailid,
						billing_country=v_billing_country,
						shipping_country=v_shipping_country,
                        fees = v_fees, 
                        taxes = v_taxes , 
                        deductions = v_deductions, 
                        total_amount = v_total_amount,                  
                        updated_date = v_sysdate                
                    where product_cart_id = v_product_cartid
                    and is_active = 1 
                    and is_deleted = 0;
				end if;
        end if;
        
		p_result := 1;

		p_data := v_json;
	
/*	exception 
		when others then 
			p_result := -1;
			p_data := '{}';
*/	
END;

    

$$;


--
