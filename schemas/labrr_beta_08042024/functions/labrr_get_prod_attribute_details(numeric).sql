-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_prod_attribute_details(numeric)
-- Type: FUNCTION

-- Name: labrr_get_prod_attribute_details(numeric); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_prod_attribute_details(p_attribute_id numeric, OUT p_attributejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	   
begin
	
	
    	 
	select row_to_json(a)
	from(  select * from labrr.labrr_product_attribute
          where is_active = 1 
          and is_deleted = 0 
          and is_published = 1
		  and  product_attribute_id = p_attribute_id
       )a
     into p_attributejson ;
     
  
           
end;

$$;


--
