-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_image(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_image(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_image(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_image_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_image_id numeric;
	v_image_title text;
	v_image_caption text;
	v_image_desc text;
	v_image_file_name character varying(100);
	v_image_path character varying(100);
	v_image_copyright_text character varying(100);
	v_created_by numeric;
	v_json jsonb := p_json;
	v_image_entity_json jsonb;
	v_entity_json json;
	v_entity_role_map_id numeric;
	v_entity_name  character varying(100);
	v_entity_priority numeric;
	v_asset_entity_map_id numeric;
	-- ********** exception handling variables **********
	v_returned_sqlstate text;
	v_column_name text;
	v_constraint_name text;
	v_pg_datatype_name text;
	v_message_text text;
	v_table_name text;
	v_schema_name text;
	v_pg_exception_detail text;
	v_pg_exception_hint text;
	v_pg_exception_context text;
	
begin
	
    	select v_json->'data'->>'image_id', v_json->'data'->>'img_title', v_json->'data'->>'img_caption', v_json->'data'->>'img_desc',
			v_json->'data'->>'img_file_name', v_json->'data'->>'img_path', v_json->'data'->>'copyright_text', v_json->'data'->>'uploaded_by'
	into v_image_id, v_image_title, v_image_caption, v_image_desc, v_image_file_name, v_image_path, v_image_copyright_text, v_created_by;
     
	if v_image_id is null then
		execute 'select nextval('''||$1||'.seq_'||$1||'_image_id'')' into v_image_id using p_schema_prefix;
		v_image_id := nextval('dd.seq_dd_image_id');
          v_json := jsonb_set(v_json, '{data,image_id}', v_image_id::text::jsonb, true);
          execute 'insert into '||$1||'.'||$1||'_image(image_id, title, image_caption, image_desc, image_file_name, image_path, copyright_text,
											created_by, updated_by, created_date, updated_date)
          		values($1, $2, $3, $4, $5, $6, $7, $9, $9, $10, $10)'
		using p_schema_prefix, v_image_id, v_image_title, v_image_caption, v_image_desc, v_image_file_name, v_image_path,
				v_image_copyright_text, v_updated_by, v_current_timetamp;
     else
		execute 'update '||$1||'.'||$1||'_image
				set image_title = $2, image_caption = $3, image_desc = $4, copyright_text = $5, updated_date = $6, updated_by = $7
				where image_id = $8'
		using p_schema_prefix, v_image_title, v_image_caption, v_image_desc, v_image_copyright_text, v_current_timestamp, v_updated_by,
				v_image_id;
	end if;
	
  	select v_json->'data'->>'entitydata' into v_image_entity_json;
	
	if v_image_entity_json is not null then
		for v_entity_json in select * from json_array_elements(v_image_entity_json::json)
          loop
			select v_entity_json->>'entity_role_map_id', v_entity_json->>'name', v_entity_json->>'priority'
               into v_entity_role_map_id, v_entity_name, v_entity_priority;
               if v_entity_role_map_id is not null then
				execute 'select nextval('''||$1||'.seq_'||$1||'_asset_entity_map_id'')' into v_asset_entity_map_id using p_schema_prefix;
				execute 'insert into '||$1||'.'||$1||'_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id,
																priority, created_date, created_by)
            		values($2, $3, $4, $5, $6, $7, $8)'
				using p_schema_prefix, v_asset_entity_map_id, v_image_id, v_image_asset_type_id, v_entity_role_map_id, v_entity_priority,
						v_current_timetamp, v_updated_by;
               end if;
		end loop;
     end if; 
   	
	p_result := 1;
	p_image_json := v_json;
     
exception
	when others then
		p_result := -1;
		get stacked diagnostics 
		v_returned_sqlstate = returned_sqlstate,
		v_column_name = column_name,
		v_constraint_name = constraint_name,
		v_pg_datatype_name = pg_datatype_name,
		v_message_text = message_text,
		v_table_name = table_name,
		v_schema_name = schema_name,
		v_pg_exception_detail = pg_exception_detail,
		v_pg_exception_hint = pg_exception_hint,
		v_pg_exception_context = pg_exception_context;
		select ('{"error_message":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (select v_returned_sqlstate as returned_sqlstate, v_column_name as column_name, v_constraint_name as constraint_name,
			 		v_pg_datatype_name as pg_datatype_name, v_message_text as message_text, v_table_name as table_name,
			 		v_schema_name as schema_name, v_pg_exception_detail as pg_exception_detail, v_pg_exception_hint as pg_exception_hint,
			 		v_pg_exception_context as pg_exception_context
			)row
		into p_image_json;
	
end;

$_$;


--
