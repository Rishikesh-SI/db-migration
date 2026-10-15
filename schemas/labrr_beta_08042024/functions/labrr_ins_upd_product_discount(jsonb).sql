-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_product_discount(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_product_discount(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_product_discount(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

	declare
		
	i record;
	
	BEGIN
		
		for i in 
		select b->>'from_product_id' as from_product_id,
		     b->>'to_product_id' as to_product_id,
			 b->>'discount' as discount_percent,
			 b->>'opt_type' as opt_type,
			 b->>'old_user' as old_user
        from (select b from jsonb_array_elements(p_json->'data') b)as a 
		loop 
			
			if 	i.opt_type::numeric = 1 then
			  
				  if exists(select 1 from labrr.labrr_product_discount
							where from_product_id = i.from_product_id::numeric 
							and to_product_id = i.to_product_id::numeric and old_user = i.old_user::numeric) then

						update labrr.labrr_product_discount
			  			set discount = i.discount_percent::numeric,
			  				is_active = 1,
							gst_amt = i.gst_amt::numeric,
							base_amt = i.base_amt::numeric,
			  				updated_date = current_timestamp
						where from_product_id = i.from_product_id::numeric 
						and to_product_id = i.to_product_id::numeric 
						and old_user = i.old_user::numeric;
			  
				  else
			  			insert into labrr.labrr_product_discount
			  			select i.from_product_id::numeric,i.to_product_id::numeric,i.discount_percent::numeric
						,1,current_timestamp,current_timestamp,i.old_user::numeric,i.base_amt::numeric,i.gst_amt::numeric ;

				  end if;
			  
			elseif 	i.opt_type::numeric = 2 then 
			  
			  		update labrr.labrr_product_discount
			  		set is_active = 0,
			  		    updated_date = current_timestamp
					where from_product_id = i.from_product_id::numeric and to_product_id = i.to_product_id::numeric
					     and old_user = i.old_user::numeric;
			  
			end if;

	    end loop ;

		p_result:= 1;

	 /* exception 
			when others then 
				p_result := -1;
				p_data := null;
	  */         
	END;

	
$$;


--
