-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_prod_category_details(numeric)
-- Type: FUNCTION

-- Name: dd_get_prod_category_details(numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_prod_category_details(p_category_id numeric, OUT p_categoryjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

    
begin
	
	    	 
	select row_to_json(a)
	from( select product_category_id, category_name, description, parent_category_id, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, category_guid,is_active,is_deleted,is_published 
          from dd.dd_product_category
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and product_category_id = p_category_id
        )a
     into p_categoryjson; 
     
    -- p_categoryjson := '{ "category" : '||v_category || '}';
           
end;

$$;


--
