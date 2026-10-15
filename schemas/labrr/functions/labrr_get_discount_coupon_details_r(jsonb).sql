-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_discount_coupon_details_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_discount_coupon_details_r(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_discount_coupon_details_r(p_json jsonb, OUT p_result numeric, OUT p_couponjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_discount_code character varying;
	v_discount_type character varying;
	v_product_id character varying;
	v_product_code character varying;
    v_coupon_product_code character varying;
	v_product_title character varying;
BEGIN		
        
        
        select 	p_json->'data'->>'discount_code',
			p_json->'data'->>'product_id'
		
           into v_discount_code,
				v_product_id
                ;
                
         --Check if discount coupon, product_code is not null it means coupon is tier specific      
        if (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and product_code is not null limit 1) then				
				select product_code into v_product_code from labrr.labrr_product where product_id=v_product_id::numeric;   
        end if;
        

		if (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) 
				and is_used<>1 and is_active=1 and expiry_date>=current_timestamp+'5:30 hours'::interval and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'') limit 1) THEN
                
		select discount_type into v_discount_type from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'');
		
			p_result:=1;
			p_couponjson:='{
						"message":"Discount coupon applied. Discounted amount will be visible while completing payment.",
                        "discount_code": "'||coalesce(v_discount_code::varchar,'')||'",
						"discount_type": "'||coalesce(v_discount_type::varchar,'')||'",
                        "status":"1"
						}';
						
		elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and coalesce(lower(product_code),'')<>coalesce(lower(v_product_code),'') limit 1) THEN                        
            p_result:=0;
			p_couponjson:='{
						"message":"This coupon code is not applicable on the selected membership plan. Please select a different plan and retry.",
                        "status":"0"
						}';				
		
       
        elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and expiry_date<current_timestamp+'5:30 hours'::interval and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'') limit 1)  THEN                        
			
            p_result:=0;
			p_couponjson:='{
						"message":"This coupon code has expired!",
                        "status":"0"
						}';
                        
        elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and is_used=1 and coalesce(lower(product_code),'')=coalesce(lower(v_product_code),'') limit 1)  THEN                        
			
            p_result:=0;
			p_couponjson:='{
						"message":"Coupon already in use!",
                        "status":"0"
						}';
                        

						
		ELSE
			p_result:=0;
			p_couponjson:='{
						"message":"Invalid Coupon code!",
                        "status":"0"
						}';
		
		end if;
  

END;

    

$$;


--
