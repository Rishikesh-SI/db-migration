-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_prod_attribute_specification_details(numeric)
-- Type: FUNCTION

-- Name: dd_get_prod_attribute_specification_details(numeric); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_prod_attribute_specification_details(p_attribute_specificationid numeric, OUT p_specificationjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_attribute 		text;

     
    
begin
	
   
	 select row_to_json(a)
	from(  select * from dd.dd_product_attribute_specification
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
         and (product_attribute_specification_id = p_attribute_specificationid or coalesce(p_attribute_specificationid,0) = 0)
		 
       )a
     into v_attribute ;
     
     p_specificationjson := '{ "specificationattribute" : '|| v_attribute || '}';
     
     
           
end;

$$;


--
