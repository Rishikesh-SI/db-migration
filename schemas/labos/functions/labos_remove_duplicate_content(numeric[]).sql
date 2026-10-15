-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_remove_duplicate_content(numeric[])
-- Type: FUNCTION

-- Name: labos_remove_duplicate_content(numeric[]); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_remove_duplicate_content(p_page_id numeric[], OUT p_result_1 numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

	declare
	-- p_page_id := array[1];
	i record;
	j record;
	v_exclude_data jsonb;
	v_json jsonb;
	v_count numeric := 1 ;
	v_json_1 jsonb;
	v_exclude_data_1 jsonb;

	begin
	
	for i in select * from unnest(p_page_id) as page_id
	loop
	
		v_exclude_data := null;

	   for j in
	   select * from labos.labos_template_component_data 
	   where page_id = i.page_id  and component_id in (7,9) and (meta_info->>'duplicate_content')::numeric = 0
	   order by  (meta_info->>'widget_order')::numeric

		loop

		  if j.component_id = 7 then
		  
		  

		  select p_assetjson into v_json from labos.labos_get_asset_listing_r(1,coalesce(j.web_item_number,3),coalesce(j.web_item_number,3),coalesce(j.req_entity,array[4]), j.other_entity, null, null,j.exclude_entity,v_exclude_data);

		  update labos.labos_template_component_data 
		  set widget_data=coalesce(v_json,'{}')
		   where template_component_map_id = j.template_component_map_id 
		   and template_id = j.template_id and j.component_id = 7 ;

		
			if v_json_1 is not null then

			if v_exclude_data is null  then

				 select '['||string_agg(row_to_json(row)::text,',')||']' into v_exclude_data
				from (select asset_id, asset_type_id  from jsonb_to_recordset(v_json_1)
					as x("asset_id" numeric, "asset_type_id" numeric)) row;

			else

				select '['||string_agg(row_to_json(row)::text,',')||']' into v_exclude_data_1
				from (select asset_id, asset_type_id  from jsonb_to_recordset(v_json_1)
					as x("asset_id" numeric, "asset_type_id" numeric)) row;

					v_exclude_data := v_exclude_data || v_exclude_data_1 ;

			end if;
			
			end if;

		 else
		 
		 		--- raise notice '%,%',i.page_id,v_exclude_data;

			SELECT p_showcase_json into v_json from labos.labos_get_showcase_det_r('labos',j.template_component_map_id, coalesce (j.req_entity,array[4]), null, null, 1, coalesce(j.web_item_number,10), 10, j.is_fallback,v_exclude_data);	  

			  update labos.labos_template_component_data 
			  set widget_data=coalesce(v_json,'{}')
			  where template_component_map_id = j.template_component_map_id 
			  and template_id = j.template_id and j.component_id = 9 ;

			select v_json->'data'->'asset_map'
			into v_json_1; 
			
			if v_json_1 is not null then

			if v_exclude_data is null then

				 select '['||string_agg(row_to_json(row)::text,',')||']' into v_exclude_data
				from (select asset_id, asset_type as asset_type_id  from jsonb_to_recordset(v_json_1)
					as x("asset_id" numeric, "asset_type" numeric)) row;

			else

				select '['||string_agg(row_to_json(row)::text,',')||']' into v_exclude_data_1
				from (select asset_id, asset_type as asset_type_id  from jsonb_to_recordset(v_json_1)
					as x("asset_id" numeric, "asset_type" numeric)) row;

					v_exclude_data := v_exclude_data || v_exclude_data_1 ;

			end if;
			
			end if;

		  end if;

		   -- raise notice '%,%',j.component_id,v_exclude_data;

		  -- v_count := v_count + 1;

		end loop;

	end loop;
	
	
	p_result_1 := 1;

	end;

	
$$;


--
