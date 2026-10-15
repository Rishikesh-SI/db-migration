-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_prod_category_search(character varying)
-- Type: FUNCTION

-- Name: labrr_get_prod_category_search(character varying); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_prod_category_search(p_category_name character varying, OUT p_categoryjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_category 		text;
	 v_searchwords varchar(4000);
    
begin
	
	v_searchwords := p_category_name;          
    v_searchwords:='*'|| replace(v_searchwords,' ',':* & *') ||':*';
    	 
	select array_to_json(array_agg(a))
	from( select product_category_id, category_name, description, parent_category_id, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, category_guid,is_active,is_deleted,is_published 
          from labrr.labrr_product_category
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and ((to_tsvector(category_name) @@@ to_tsquery(v_searchwords)) or coalesce(v_searchwords,'') ='')
        )a
     into v_category; 
     
     p_categoryjson := '{ "category" : '||v_category || '}';
           
end;

$$;


--
