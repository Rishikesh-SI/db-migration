-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_prod_category(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_prod_category(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_prod_category(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_category_id 						numeric;
v_category_name 					character varying;
v_desc								character varying;
v_parent_category_id				numeric;
v_display_order						numeric;
v_is_show_homepage					numeric;
v_sysdate 							timestamp;
v_created_by 						numeric;
V_updated_by						numeric;
V_is_active							numeric;
V_is_deleted						numeric;
V_is_published						numeric;
V_category_guid						character varying;
BEGIN

		select current_timestamp
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */
		
		SELECT 	v_json->'category'->>'product_category_id',
				v_json->'category'->>'category_name',
				v_json->'category'->>'description',
				v_json->'category'->>'parent_category_id',
				v_json->'category'->>'display_order',
				--v_json->'category'->>'price_range'
				--v_json->'category'->>'is_show_homepage',
				--v_json->'category'->>'is_top_menu',
				--v_json->'category'->>'is_select_pagesize'
				--v_json->'category'->>'page_size_option'
				--v_json->'category'->>'discount'
				--v_json->'category'->>'customer_role_id'
				--v_json->'category'->>'limit_per_store'
				v_json->'category'->>'created_by',
				v_json->'category'->>'updated_by',               
				v_json->'category'->>'is_published',
                v_json->'category'->>'is_active',
				v_json->'category'->>'is_deleted'
				
		INTO            
				v_category_id,
				v_category_name,
				v_desc,
				v_parent_category_id,
				v_display_order,
				v_created_by,
				V_updated_by,
				V_is_published,
                V_is_active,
                V_is_deleted;
		---------------------------------------------------------------        

		if (v_category_id is null)
		then
			V_category_guid := uuid_generate_v4();	
			v_category_id   := nextval('dd.seq_dd_product_category_id');
            
            v_json 	         := jsonb_set(v_json, '{category,category_id}', v_category_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{category,category_guid}', ('"'||v_category_guid||'"')::text::jsonb, true);

			insert into dd.dd_product_category
			(
			product_category_id, category_name, description, parent_category_id, display_order,
			-- price_range,is_show_homepage,is_top_menu,is_select_pagesize,page_size_option,discount,customer_role_id,limit_per_store,
			category_json, created_date, updated_date, created_by, updated_by, category_guid, is_active, is_deleted, is_published			
			)    
			values
			(
			v_category_id, v_category_name, v_desc, v_parent_category_id, v_display_order,
			v_json, v_sysdate, v_sysdate, v_created_by, v_updated_by, V_category_guid, V_is_active, V_is_deleted, V_is_published
			);    
		else
			update dd.dd_product_category
			set category_name = v_category_name, 
				description = v_desc , 
				parent_category_id = v_parent_category_id, 
				display_order = v_display_order,
				category_json = v_json, 				 
				updated_date = v_sysdate, 				
				updated_by = v_updated_by, 				
				is_active = V_is_active, 
				is_deleted = V_is_deleted, 
				is_published = v_is_published
			where product_category_id = v_category_id;

		end if;

		p_result := 1;

		p_data := v_json;

END;

    

$$;


--
