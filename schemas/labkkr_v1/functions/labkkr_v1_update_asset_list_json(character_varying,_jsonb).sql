-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_update_asset_list_json(character varying, jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_update_asset_list_json(character varying, jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_update_asset_list_json(p_schema_prefix character varying, p_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
i record ;
v_json jsonb;
v_entity_role_map_id text;
v_entity_role_map_id_1 int[];
v_asset_data jsonb;
v_entity_json jsonb;
v_videourl character varying;
v_contentsourceid numeric;
/*p_json jsonb := '{
"entity_role_map_id" : "201"
}' ;*/

begin 

	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'labkkr_v1_update_asset_list_json',
	'{"exception":""}',uuid_generate_v4(),p_data,CURRENT_TIMESTAMP,'labkkr_v1','db-error');

	select p_data->>'entity_role_map_id' 
	into v_entity_role_map_id ;

	v_entity_role_map_id_1 := string_to_array(v_entity_role_map_id,',')::int[];

	-- raise notice '%',v_entity_role_map_id_1;

		for i in (select * from labkkr_v1.labkkr_v1_asset_list
				 where is_published=1 and asset_type_id in(1,2,4) and tagged_entity @> v_entity_role_map_id_1
				 order by asset_type_id )
		loop

			select p_json into v_json from labkkr_v1._get_web_list_json('labkkr_v1',i.asset_type_id,i.asset_id);
			
			select asset_data into v_asset_data from labkkr_v1.labkkr_v1_asset_draft
           where asset_id = i.asset_id and asset_type_id= i.asset_type_id 
		   and version_number = i.published_version_number ;
		
		if i.asset_type_id = 4 then
		
		   select v_asset_data->'data'->>'video_url',
			      v_asset_data->'data'->>'content_source_id'
		   into v_videourl,
		        v_contentsourceid;
		   
			v_json:= jsonb_set(v_json, '{video_url}', ('"'||coalesce(v_videourl,'')||'"')::text::jsonb, true);
			v_json:= jsonb_set(v_json, '{content_source_id}', ('"'||coalesce(v_contentsourceid,0)||'"')::text::jsonb, true);		   
		   
		end if;
		
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
			join labkkr_v1.labkkr_v1_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
			join labkkr_v1.labkkr_v1_entity_master b on b.entity_master_id=a.entity_master_id
			join labkkr_v1.labkkr_v1_entity_role c on c.entity_role_id=a.entity_role_id
			join labkkr_v1.labkkr_v1_entity_type d on d.entity_type_id=c.entity_type_id
			)tab;
			
			v_asset_data := jsonb_set(v_asset_data,'{data,entitydata}',v_entity_json,true);
			
			update labkkr_v1.labkkr_v1_asset_draft
			set asset_data = v_asset_data
           	where asset_id = i.asset_id and asset_type_id= i.asset_type_id 
		   	and version_number = i.published_version_number ;

			update labkkr_v1.labkkr_v1_asset_list
			set web_listing_json = v_json,
			    web_detail_jsn = v_asset_data
			where asset_id = i.asset_id and asset_type_id= i.asset_type_id;

		end loop ;

	p_result := 1;
end ;
$$;


--
