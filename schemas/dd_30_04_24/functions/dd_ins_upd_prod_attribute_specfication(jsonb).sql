-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_prod_attribute_specfication(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_prod_attribute_specfication(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_prod_attribute_specfication(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								json;
v_product_attribute_id 				numeric;
v_attribute_name 					character varying;
v_desc								character varying;
v_sysdate 							timestamp;
v_created_by 						numeric;
V_updated_by						numeric;
V_is_active							numeric;
V_is_deleted						numeric;
V_is_published						numeric;
V_attribute_guid					character varying;
v_attribute							jsonb;
v_attribute_specification_id		numeric;
v_display_order						numeric;
v_specification_code 				character varying;
BEGIN

		select current_timestamp
		into   v_sysdate;
		
		v_json := p_json;
                
				
				select p_json->'specificationattribute'->>'product_attribute_specification_id', 
					   p_json->'specificationattribute'->>'product_attribute_id',
					   p_json->'specificationattribute'->>'specification_name', 
                       p_json->'specificationattribute'->>'description',
					   p_json->'specificationattribute'->>'display_order',
					   p_json->'specificationattribute'->>'is_published',
					   p_json->'specificationattribute'->>'is_deleted',
					   p_json->'specificationattribute'->>'is_active',
                       p_json->'specificationattribute'->>'specification_code'
					   
				into   v_attribute_specification_id, 
						v_product_attribute_id, 
						v_attribute_name, 
                        v_desc,
						v_display_order,
						V_is_published,						
						V_is_deleted,
						V_is_active,
                        v_specification_code;
				
                raise notice 'attribute_specification_id 1 : %', v_attribute_specification_id;
                
				if v_attribute_specification_id is null then
					
					v_attribute_specification_id   := nextval('dd.seq_dd_product_attribute_specification_id');
					V_attribute_guid := uuid_generate_v4();
					
                   -- v_json := jsonb_set(v_json, '{specificationattribute,product_attribute_specification_id}', v_attribute_specification_id::text::jsonb, true);
				--	v_json := jsonb_set(v_json, '{specificationattribute,pas_guid}', ('"'||V_attribute_guid||'"')::jsonb, true);
                    
					insert into dd.dd_product_attribute_specification
					(product_attribute_specification_id, product_attribute_id, specification_name, description, 				
					 display_order, created_date, updated_date, created_by, updated_by, pas_guid, is_active	,						
					 is_deleted, is_published, specification_code)
					values
					(v_attribute_specification_id, v_product_attribute_id, v_attribute_name, v_desc,  v_display_order, v_sysdate,
					 v_sysdate, 1, 1, V_attribute_guid, V_is_active, V_is_deleted, V_is_published, v_specification_code );
				
				else
					
					update dd.dd_product_attribute_specification
					set  product_attribute_id = v_product_attribute_id, 
						 specification_name = v_attribute_name, 	
                         description = v_desc,
						 display_order = v_display_order, 
						 updated_date= v_sysdate, 
						 updated_by = 1, 						
						 is_active = V_is_active,					
						 is_deleted = V_is_deleted, 
						 is_published = V_is_published, 
                         specification_code = v_specification_code
					where product_attribute_specification_id = v_attribute_specification_id ;
					 
				end if;     
				
		p_data := v_json;
		p_result := 1 ;
 
 /* exception 
 	when others then 
    	p_data := ('{  "attribute": {}}')::json;
		p_result := -1 ;
 
 */ 
END;

    

$$;


--
