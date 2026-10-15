-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_prod_attribute_details(numeric)
-- Type: FUNCTION

-- Name: dd_get_prod_attribute_details(numeric); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_prod_attribute_details(p_attribute_id numeric, OUT p_attributejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	   
begin
	
	
    	 
	select row_to_json(a)
	from(  select * from dd.dd_product_attribute
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
		  and  product_attribute_id = p_attribute_id
       )a
     into p_attributejson ;
     
  
           
end;

$$;


--
