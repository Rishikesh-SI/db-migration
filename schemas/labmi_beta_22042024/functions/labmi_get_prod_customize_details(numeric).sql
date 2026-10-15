-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_prod_customize_details(numeric)
-- Type: FUNCTION

-- Name: labmi_get_prod_customize_details(numeric); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_prod_customize_details(p_customize_id numeric, OUT p_customizejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

    
begin
	
	    	 
	select row_to_json(a)
	from( select product_customize_id, customize_name,
		      description, -- price, product_id, is_added_price,
         		created_date, updated_date, created_by, updated_by, 	
				 customize_guid, is_active, is_deleted, is_published,
		custmize_prize
          from  labmi.labmi_product_customize
	 	  where is_active = 1 
	 	  and is_deleted = 0 
	 	  and is_published = 1
		  and product_customize_id = p_customize_id
        )a
     into p_customizejson; 
     
    -- p_customizejson := '{ "customize" : '||v_customize || '}';
           
end;

$$;


--
