-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_prod_manufacturer_search(character varying)
-- Type: FUNCTION

-- Name: labmi_get_prod_manufacturer_search(character varying); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_prod_manufacturer_search(p_manufacturer_name character varying, OUT p_manufacturerjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_manufacturer		text;
	 v_searchwords varchar(4000);
    
begin
	
	v_searchwords := p_manufacturer_name;          
    v_searchwords:='*'|| replace(v_searchwords,' ',':* & *') ||':*';
    	 
	select array_to_json(array_agg(a))
	from( select product_manufacturer_id, manufacturer_name, description, display_order,price_range,is_show_homepage,is_top_menu,
         		 is_select_pagesize, page_size_option,discount,customer_role_id,limit_per_store,
				created_date, updated_date, created_by, updated_by, manufacturer_guid,is_active,is_deleted,is_published 
          from labmi.labmi_product_manufacturer
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and ((to_tsvector( manufacturer_name ) @@@ to_tsquery(v_searchwords)) or coalesce(v_searchwords,'') ='')
        )a
     into v_manufacturer; 
     
     p_manufacturerjson := '{ "manufacturer" : '||v_manufacturer || '}';
           
end;

$$;


--
