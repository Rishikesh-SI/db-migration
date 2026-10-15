-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_prod_attribute_specification_search(numeric, character varying)
-- Type: FUNCTION

-- Name: labmi_v1_get_prod_attribute_specification_search(numeric, character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_prod_attribute_specification_search(p_attribute_id numeric, p_search_text character varying, OUT p_attributejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_attribute 		text;
	 v_searchwords varchar(4000);
     
    
begin
	
    v_searchwords := upper(p_search_text);
    
	--v_searchwords := p_attribute_name;          
   -- v_searchwords:='*'|| replace(v_searchwords,' ',':* & *') ||':*';
    	 
	 select array_to_json(array_agg(a))
	from( select s.* , a.attribute_name from labmi_v1.labmi_v1_product_attribute_specification s 
          inner join labmi_v1.labmi_v1_product_attribute a 
          on (s.product_attribute_id = a.product_attribute_id)
          where s.is_active = 1 
          and s.is_deleted = 0 
          and s.is_published = 1
          and a.is_active = 1 
          and a.is_deleted = 0 
         and (s.product_attribute_id = p_attribute_id or coalesce(p_attribute_id,0) = 0)
		 and  (upper(s.specification_name ) like '%'||v_searchwords||'%' or coalesce(v_searchwords,'') = '')
       )a
     into v_attribute ;
     
     p_attributejson := '{ "specificationattribute" : '|| v_attribute || '}';
     
     
           
end;

$$;


--
