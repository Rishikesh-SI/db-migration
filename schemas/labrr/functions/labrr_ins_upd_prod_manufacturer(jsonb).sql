-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_prod_manufacturer(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_prod_manufacturer(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_prod_manufacturer(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_manufacturer_id 					numeric;
v_manufacturer_name 				character varying;
v_desc								character varying;
v_display_order						numeric;
v_is_show_homepage					numeric;
v_sysdate 							timestamp;
v_created_by 						numeric;
V_updated_by						numeric;
V_is_active							numeric;
V_is_deleted						numeric;
V_is_published						numeric;
V_manufacturer_guid					character varying;
BEGIN

		select current_timestamp
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */
		
		SELECT 	v_json->'manufacturer'->>'product_manufacturer_id',
				v_json->'manufacturer'->>'manufacturer_name',
				v_json->'manufacturer'->>'description',
				v_json->'manufacturer'->>'display_order',
				--v_json->'manufacturer'->>'price_range'
				--v_json->'manufacturer'->>'is_show_homepage',
				--v_json->'manufacturer'->>'is_top_menu',
				--v_json->'manufacturer'->>'is_select_pagesize'
				--v_json->'manufacturer'->>'page_size_option'
				--v_json->'manufacturer'->>'discount'
				--v_json->'manufacturer'->>'customer_role_id'
				--v_json->'manufacturer'->>'limit_per_store'
				v_json->'manufacturer'->>'created_by',
				v_json->'manufacturer'->>'updated_by',               
				v_json->'manufacturer'->>'is_published',
                v_json->'manufacturer'->>'is_active',
				v_json->'manufacturer'->>'is_deleted'
				
		INTO            
				v_manufacturer_id,
				v_manufacturer_name,
				v_desc,				
				v_display_order,
				v_created_by,
				V_updated_by,
				V_is_published,
                V_is_active,
                V_is_deleted;
		---------------------------------------------------------------        

		if (v_manufacturer_id is null)
		then
			V_manufacturer_guid := uuid_generate_v4();	
			v_manufacturer_id   := nextval('labrr.seq_labrr_product_manufacturer_id');
            
            v_json 	         := jsonb_set(v_json, '{manufacturer,product_manufacturer_id}', v_manufacturer_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{manufacturer,manufacturer_guid}', ('"'||V_manufacturer_guid||'"')::text::jsonb, true);

			insert into labrr.labrr_product_manufacturer
			(
				product_manufacturer_id, manufacturer_name, description, display_order, 
			--	price_range, is_show_homepage, is_top_menu, is_select_pagesize, page_size_option, discount, customer_role_id, limit_per_store,
				manufacturer_json, created_date, updated_date, created_by, updated_by, manufacturer_guid, is_active, is_deleted, is_published		
			)    
			values
			(
				v_manufacturer_id, v_manufacturer_name, v_desc, v_display_order, v_json, v_sysdate, v_sysdate, v_created_by,  V_updated_by,
				V_manufacturer_guid, V_is_active, V_is_deleted,  V_is_published
				
			);    
		else
			 update labrr.labrr_product_manufacturer 
			 set manufacturer_name = v_manufacturer_name, 
				 description = v_desc, 
				 display_order = v_display_order,
				 manufacturer_json = v_json,
				 updated_date = v_sysdate, 
				 updated_by = V_updated_by, 
				 is_active = V_is_active, 
				 is_deleted = V_is_deleted, 
				 is_published = V_is_published
			where 	product_manufacturer_id = v_manufacturer_id; 
			 
			
		end if;

		p_result := 1;

		p_data := v_json;

END;

    

$$;


--
