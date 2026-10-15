-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_prod_manufacturer_details(numeric)
-- Type: FUNCTION

-- Name: labrr_get_prod_manufacturer_details(numeric); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_prod_manufacturer_details(p_manufacturer_id numeric, OUT p_manufacturerjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

    
begin
	
	    	 
	select row_to_json(a)
	from( select product_manufacturer_id, manufacturer_name, description, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, manufacturer_guid,is_active,is_deleted,is_published 
          from labrr.labrr_product_manufacturer
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and product_manufacturer_id = p_manufacturer_id
        )a
     into p_manufacturerjson; 
     
    -- p_manufacturerjson := '{ "manufacturer" : '||v_manufacturer || '}';
           
end;

$$;


--
