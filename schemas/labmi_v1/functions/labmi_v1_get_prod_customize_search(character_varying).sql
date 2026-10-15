-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_prod_customize_search(character varying)
-- Type: FUNCTION

-- Name: labmi_v1_get_prod_customize_search(character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_prod_customize_search(p_customize_name character varying, OUT p_customizejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_customize 		text;
	 v_searchwords varchar(4000);
    
begin
	
	v_searchwords := p_customize_name;          
    v_searchwords:='*'|| replace(v_searchwords,' ',':* & *') ||':*';
    	 
	select array_to_json(array_agg(a))
	from( select product_customize_id, customize_name, description, -- price, product_id, is_added_price,
         		created_date, updated_date, created_by, updated_by, 	
				 customize_guid, is_active, is_deleted, is_published,custmize_prize
          from labmi_v1.labmi_v1_product_customize
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and ((to_tsvector(customize_name) @@@ to_tsquery(v_searchwords)) or coalesce(v_searchwords,'') ='')
        )a
     into v_customize; 
     
     p_customizejson := '{ "customize" : '||v_customize || '}';
           
end;

$$;


--
