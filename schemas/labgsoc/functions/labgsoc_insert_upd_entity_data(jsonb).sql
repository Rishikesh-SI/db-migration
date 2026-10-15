-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_insert_upd_entity_data(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_insert_upd_entity_data(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_insert_upd_entity_data(p_json jsonb, OUT p_result numeric, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
    v_result numeric := 0;
	v_count numeric := 0;
    v_sysdate timestamp;
    v_entity_master_id numeric;
	v_entity_master_id_ex numeric;
	v_waf_entity_master_id numeric;
    v_entity_role_map_id numeric;
    v_entity_guid character varying;
	v_ent_name character varying;

    v_item jsonb;
    v_priority numeric;
    v_ent_disp_name character varying;
    v_entity_type_name text;
    v_canonical text;
    v_source_object_id character varying;
	v_entity_role_id numeric;
	v_additional_info jsonb;
	v_hyperlink numeric;
	
	v_city character varying;
	v_country numeric;
	
		v_is_lang numeric;
		v_parent_entity_id numeric;
		v_show_content numeric;
		v_show_data numeric;
		v_entity_url character varying;
		v_client_id numeric;
		v_player_image_path text;
		v_image_available numeric;
		
	v_json jsonb;
begin
    select current_timestamp at time zone 'utc' into v_sysdate;

v_json := p_json;

    for v_item in
        select * from jsonb_array_elements(p_json -> 'entityData')
    loop
        v_priority := (v_item ->> 'priority')::numeric;
		v_ent_name := (v_item ->> 'name');
        v_ent_disp_name := v_item ->> 'ent_disp_name';
        v_entity_type_name := v_item ->> 'entity_type_name';
        v_canonical := v_item ->> 'canonical';
        v_source_object_id := (v_item ->> 'source_object_id');
		v_entity_role_id := (v_item ->> 'entity_role_id');
		v_waf_entity_master_id := (v_item ->> 'waf_entity_master_id');
		v_additional_info := (v_item ->> 'additional_info');
		v_hyperlink := (v_item ->> 'hyperlink');
		v_city := (v_item ->> 'city');
		v_country:= (v_item ->> 'country');
		v_is_lang:= (v_item ->> 'is_lang');
		v_parent_entity_id:= (v_item ->> 'parent_entity_id');
		v_show_content:= (v_item ->> 'show_content');
		v_show_data:= (v_item ->> 'show_data');
		v_entity_url:= (v_item ->> 'entity_url');
		v_client_id:= (v_item ->> 'client_id');
		v_player_image_path := (v_item ->> 'player_image_path');
		v_image_available:= (v_item ->> 'v_image_available');

raise notice 'v_additional_info: %', v_additional_info;

-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'MYinsert_upd_entity_data','logs',uuid_generate_v4(),p_json,current_timestamp,'labgsoc','logs');

if not exists  (
	select 1 from labgsoc.labgsoc_entity_master where
		entity_master_id in ( select entity_master_id from labgsoc.labgsoc_entity_role_map where source_object_id= v_source_object_id and
					entity_role_id=v_entity_role_id ) ) then 

        v_entity_master_id := nextval('labgsoc.seq_labgsoc_entity_master_id');
        v_entity_guid := uuid_generate_v4();
		
        insert into labgsoc.labgsoc_entity_master (
            entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
            priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
            date_info, city, country, known_as, comp_type, waf_series_master_id, waf_tour_master_id,
            entity_guid, wafc_entity_name, wafc_entity_display_name,
			image_available,is_defualt_lang, parent_entity_id,player_image_path,show_content, show_data, entity_url,additional_info
        ) values (
            v_entity_master_id, coalesce(v_waf_entity_master_id, 0), coalesce(v_client_id, 0), v_ent_name, v_ent_disp_name, v_canonical,
            v_priority, v_sysdate, v_sysdate, 0, 0, 1, 0,
            null, v_city, v_country,v_ent_name , null, null, null,
            v_entity_guid, v_ent_name, v_ent_disp_name, 
			v_image_available, v_is_lang,v_parent_entity_id,v_player_image_path, coalesce(v_show_content,0), coalesce(v_show_data,0),
			coalesce(v_canonical::character varying,v_entity_url), v_additional_info
        );

        v_entity_role_map_id := nextval('labgsoc.seq_labgsoc_entity_role_map_id');

        insert into labgsoc.labgsoc_entity_role_map (
            entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
            created_date, updated_date, hyperlink
        ) values (
            v_entity_role_map_id, v_entity_role_id, v_entity_master_id, v_priority, 1, v_source_object_id,
            v_sysdate, v_sysdate, coalesce(v_hyperlink, 0)
        );
		 v_count := v_count + 1;		
		 v_result := 1;
			p_result := v_result;
			p_count = v_count;

elsif exists (
	select 1 from labgsoc.labgsoc_entity_master where
		entity_master_id in ( select entity_master_id from labgsoc.labgsoc_entity_role_map where source_object_id= v_source_object_id and
					entity_role_id=v_entity_role_id ) ) then 
 
		select entity_master_id into v_entity_master_id_ex from labgsoc.labgsoc_entity_master where
		entity_master_id in ( select entity_master_id from labgsoc.labgsoc_entity_role_map where source_object_id= v_source_object_id and
							entity_role_id=v_entity_role_id );

		update labgsoc.labgsoc_entity_master
		set updated_date= v_sysdate,
			priority = v_priority,
			entity_name= v_ent_name,
			additional_info= v_additional_info,
			canonical_url= v_canonical,
			entity_url= v_canonical
		where entity_master_id =v_entity_master_id_ex;

		update labgsoc.labgsoc_entity_role_map
		set updated_date= v_sysdate,
			--source_object_id= v_source_object_id,
			priority= v_priority
		where entity_master_id =v_entity_master_id_ex 
			and source_object_id= v_source_object_id 
			and entity_role_id=v_entity_role_id ;

		 v_count := v_count + 1;		
		 v_result := 2;
			p_result := v_result;
			p_count = v_count;

		else 

		v_result := 0;
			p_result := v_result;

end if;
    end loop;

 --- teams 3 and players 62 ka data delete karne bola h

end;
$$;


--
