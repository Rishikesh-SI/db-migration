-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_update_asset_list_json(character varying, jsonb)
-- Type: FUNCTION

-- Name: labwpl_update_asset_list_json(character varying, jsonb); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_update_asset_list_json(p_schema_prefix character varying, p_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
i record ;
v_json jsonb;
v_entity_role_map_id text;
v_entity_role_map_id_1 int[];
v_asset_data jsonb;
v_entity_json jsonb;

/*p_json jsonb := '{
"entity_role_map_id" : "201"
}' ;*/

begin 

-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- 	log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- 	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'labwpl_update_asset_list_json',
-- 	'{"exception":""}',uuid_generate_v4(),p_data,CURRENT_TIMESTAMP,'labwpl','db-error');

	select p_data->>'entity_role_map_id' 
	into v_entity_role_map_id ;

	v_entity_role_map_id_1 := string_to_array(v_entity_role_map_id,',')::int[];

	-- raise notice '%',v_entity_role_map_id_1;

		for i in (select * from labwpl.labwpl_asset_list
				 where is_published=1 and asset_type_id in(1,2,4) and tagged_entity @> v_entity_role_map_id_1
				 order by asset_type_id )
		loop

			select p_json into v_json from labwpl._get_web_list_json('labwpl',i.asset_type_id,i.asset_id);
			
			select asset_data into v_asset_data from labwpl.labwpl_asset_draft
           where asset_id = i.asset_id and asset_type_id= i.asset_type_id 
		   and version_number = i.published_version_number ;
		   
		   select v_asset_data->'data'->'entitydata'
		   into v_entity_json;
		   
		   select jsonb_agg(tab) into v_entity_json from (
			select b.entity_name as name,canonical_url as canonical,
			entity_display_name as ent_disp_name,
			x.entity_role_map_id ,
			entity_url,
			c.entity_type_id,
			d.entity_type_name,
			d.entity_url_type,
			x.priority
			from jsonb_to_recordset(v_entity_json)
			as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric,"priority" numeric )
			join labwpl.labwpl_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
			join labwpl.labwpl_entity_master b on b.entity_master_id=a.entity_master_id
			join labwpl.labwpl_entity_role c on c.entity_role_id=a.entity_role_id
			join labwpl.labwpl_entity_type d on d.entity_type_id=c.entity_type_id
			)tab;
			
			v_asset_data := jsonb_set(v_asset_data,'{data,entitydata}',v_entity_json,true);
			
			update labwpl.labwpl_asset_draft
			set asset_data = v_asset_data
           	where asset_id = i.asset_id and asset_type_id= i.asset_type_id 
		   	and version_number = i.published_version_number ;

			update labwpl.labwpl_asset_list
			set web_listing_json = v_json,
			    web_detail_jsn = v_asset_data
			where asset_id = i.asset_id and asset_type_id= i.asset_type_id;

		end loop ;

	p_result := 1;
end ;
$$;


--
