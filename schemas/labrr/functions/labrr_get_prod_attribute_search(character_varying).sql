-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_prod_attribute_search(character varying)
-- Type: FUNCTION

-- Name: labrr_get_prod_attribute_search(character varying); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_prod_attribute_search(p_attribute_name character varying, OUT p_attributejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_attribute 		text;
	 v_searchwords varchar(4000);
    
begin
	
	v_searchwords := p_attribute_name;          
    v_searchwords:='*'|| replace(v_searchwords,' ',':* & *') ||':*';
    	 
	 select array_to_json(array_agg(a))
	from( select  product_attribute_id, attribute_name, description, created_date, updated_date,
         		  created_by, updated_by, attribute_guid, is_active, is_deleted,
				  is_published
          from labrr.labrr_product_attribute
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
		  and ((to_tsvector(attribute_name) @@@ to_tsquery( v_searchwords)) or coalesce(v_searchwords,'') ='')
       )a
     into v_attribute ;
     
     p_attributejson := '{ "attribute" : '|| v_attribute || '}';
     
           
end;

$$;


--
