-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_ins_upd_product_attribute(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_product_attribute(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_ins_upd_product_attribute(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
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
BEGIN

		select current_timestamp
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */
		
		SELECT 	v_json->'attribute'->>'product_attribute_id',
				v_json->'attribute'->>'attribute_name',
				v_json->'attribute'->>'description',								
				v_json->'attribute'->>'created_by',
				v_json->'attribute'->>'updated_by',               
				v_json->'attribute'->>'is_published',
                v_json->'attribute'->>'is_active',
				v_json->'attribute'->>'is_deleted'
				
		INTO            
				v_product_attribute_id,
				v_attribute_name,
				v_desc,				
				v_created_by,
				V_updated_by,
				V_is_published,
                V_is_active,
                V_is_deleted;
		---------------------------------------------------------------        

		if (v_product_attribute_id is null)
		then
			V_attribute_guid := uuid_generate_v4();	
			v_product_attribute_id   := nextval('labmi.seq_labmi_product_attribute_id');
            
            v_json 	         := jsonb_set(v_json, '{attribute,product_attribute_id}', v_product_attribute_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{attribute,attribute_guid}', ('"'||V_attribute_guid||'"')::text::jsonb, true);

			insert into labmi.labmi_product_attribute
			(
				product_attribute_id, attribute_name, description, product_attribute_json, created_date, updated_date, created_by,
                updated_by,	attribute_guid, is_active, is_deleted, is_published			
			)    
			values
			(
				v_product_attribute_id, v_attribute_name, v_desc, v_json, v_sysdate, v_sysdate, v_created_by, 
                v_updated_by, V_attribute_guid, v_is_active, v_is_deleted, v_is_published
			);    
			
		else
			update labmi.labmi_product_attribute
			set attribute_name = v_attribute_name, 
				description = v_desc , 				
				product_attribute_json = v_json, 				 
				updated_date = v_sysdate, 				
				updated_by = v_updated_by, 				
				is_active = V_is_active, 
				is_deleted = V_is_deleted, 
				is_published = v_is_published
			where product_attribute_id = v_product_attribute_id;

		end if;

		p_result := 1;

		p_data := v_json;

exception 
	when others then 
    	p_result := -1;
		p_data := '{}';

END;

    

$$;


--
