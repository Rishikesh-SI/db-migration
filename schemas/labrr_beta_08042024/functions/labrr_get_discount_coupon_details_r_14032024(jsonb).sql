-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_discount_coupon_details_r_14032024(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_discount_coupon_details_r_14032024(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_discount_coupon_details_r_14032024(p_json jsonb, OUT p_result numeric, OUT p_couponjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_discount_code character varying;
	v_discount_type character varying;
BEGIN		
        
        
        select 	p_json->'data'->>'discount_code'                   
           into v_discount_code
                ;
				
		if (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) 
				and is_used<>1 and is_active=1 and expiry_date::date>=(current_timestamp+'5:30 hours'::interval)::date) THEN
		
			select discount_type into v_discount_type from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code);
		
			p_result:=1;
			p_couponjson:='{
						"message":"Discount coupon applied. Discounted amount will be visible while completing payment.",
                        "discount_code": "'||coalesce(v_discount_code::varchar,'')||'",
						"discount_type": "'||coalesce(v_discount_type::varchar,'')||'",
                        "status":"1"
						}';
       
        elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and expiry_date::date<(current_timestamp+'5:30 hours'::interval)::date) THEN                        
			
            p_result:=0;
			p_couponjson:='{
						"message":"This coupon code has expired!",
                        "status":"0"
						}';
                        
        elsif (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and is_used=1) THEN                        
			
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
