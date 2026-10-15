-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_video_detail_r(character varying)
-- Type: FUNCTION

-- Name: labpkl_v1_get_video_detail_r(character varying); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_video_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb, OUT p_nextprevjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

	v_versionnumber numeric;
	v_videoid numeric;
	v_titlealias text := lower(p_titlealias);
	v_authorjsonarr jsonb[];
	v_authorjson jsonb;
	v_json1 varchar(30000) := '{"authors":[';
	v_language_id numeric;
	v_entjsonarr jsonb[];
	v_entjson jsonb;
	v_json2 varchar(30000) := '{"entities":[';
	v_ent_count numeric;
	v_asset_type_id numeric := 4;
	v_lang_master_id numeric;
	v_modifieddate timestamp;
	v_primary_ent_id numeric;
	v_secondary_ent_id numeric;
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_tagged_entitiy integer[];
	v_entity_json jsonb;
	v_common_entities integer[];
	v_nextprevjson jsonb;
	
begin
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_videoid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_videojson, v_language_id, v_primary_ent_id, v_secondary_ent_id
	from labpkl_v1.labpkl_v1_asset_list
	where lower(title_alias) = v_titlealias
	and asset_type_id in(4,29)
	and is_published = 1
	and is_trashed = 0
	and published_date <= v_sysdate;
	
	--select array[v_language_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	--into v_common_entities;
	--v_tagged_entitiy := v_tagged_entitiy - v_common_entities;
	
	--raise notice 'v_tagged_entitiy %',v_tagged_entitiy;
	
	p_videojson := jsonb_set(p_videojson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
	
	--raise notice 'p_videojson %',p_videojson;
	
	select p_videojson->'data'->'entitydata'
	into v_entity_json;
	
	
		select jsonb_agg(tab) into v_entity_json from (
		select name,canonical_url as canonical,
		entity_display_name as ent_disp_name,
		x.entity_role_map_id ,
		entity_url,
		c.entity_type_id,
		d.entity_type_name,
		x.priority
		from jsonb_to_recordset(v_entity_json)
		as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric ,"priority" numeric)
		join labpkl_v1.labpkl_v1_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
		join labpkl_v1.labpkl_v1_entity_master b on b.entity_master_id=a.entity_master_id
		join labpkl_v1.labpkl_v1_entity_role c on c.entity_role_id=a.entity_role_id
		join labpkl_v1.labpkl_v1_entity_type d on d.entity_type_id=c.entity_type_id
		)tab;
	raise notice '%',v_entity_json;
	--select 1/0;
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labpkl_v1.labpkl_v1_asset_list
		   where tagged_entity && v_tagged_entitiy
		   and is_published = 1
		   and published_date <= v_sysdate
		   and asset_type_id in(1,2,4,5,29)
		   group by unnest(tagged_entity)
		  ) tab
	 where entity_role_map_id =any(v_tagged_entitiy)
	)
	select json_agg(row_to_json(row)->'data')::jsonb
	from (select jsonb_set(entities,'{content_count}', coalesce(content_count,0)::text::jsonb, true) as data
		  from (select jsonb_array_elements(v_entity_json) as entities
			   ) as tab1
		  left join tab
		  on tab.entity_role_map_id = (tab1.entities->>'entity_role_map_id')::integer
		 ) row
	into v_entity_json;
	
	p_videojson := jsonb_set(p_videojson,'{data,entitydata}',v_entity_json,true);
	
	
	select p_videojson->'data'->'author_data' into p_authorjson;

	with tab as
	(select user_id,full_name,display_name
	 from labpkl_v1.labpkl_v1_user
	a  join (select (obj.values->>'author_id')::numeric as author_id  
			 from jsonb_array_elements(p_authorjson) as obj(values) 
			 where (obj.values->>'action_id')::numeric=4
			) tab on a.user_id=tab.author_id 
	
	)
	select json_agg(row_to_json(row)->'data')::jsonb
		 
	from (select jsonb_set(author,'{author_name}', ('"'||tab.full_name||'"')::text::jsonb, true) as data
		  from (select jsonb_array_elements(p_authorjson) as author)  as tab1
		  left join tab
		  on tab.user_id = (tab1.author->>'author_id')::numeric
		  where (tab1.author->>'action_id')::numeric=4
		 ) row
		 into p_authorjson;

	
	 p_videojson := jsonb_set(p_videojson,'{data,author_data}',p_authorjson,true);
	 p_authorjson:=('{"authors":'||p_authorjson::text||'}')::jsonb;	
	 
	 
	 
	 select s.p_assetjson
    from labpkl_v1.labpkl_v1_get_asset_related_stories_r(v_videoid,v_asset_type_id,v_tagged_entitiy,3) s
    into v_nextprevjson; 
	
	   
	
	
	if v_nextprevjson->'items' is null or (v_nextprevjson->'items')::text = '[]' then
	
	---   raise notice '% v_videoid ',v_nextprevjson->'items';
	
		select s.p_assetjson
    	from labpkl_v1.labpkl_v1_get_asset_related_stories_r(v_videoid,v_asset_type_id,array[4,3],3) s
    	into v_nextprevjson; 
	
	end if;
	 
	 p_videojson := jsonb_set(p_videojson,'{data,related_data}',v_nextprevjson,true);
	 
	 
	 
	 
	 
	--raise notice ' % v_entity_json',v_entity_json; 
	--select 1/0;
	/*
	select ('{"authors":['||row_to_json(row)||']}')::jsonb
	from (select u.user_id, u.full_name, u.user_name, u.display_name
		  from labpkl_v1.labpkl_v1_user_role as ur
		  join labpkl_v1.labpkl_v1_user as u
		  on u.user_id = ur.user_id
		  join labpkl_v1.labpkl_v1_author_action aa
		  on aa.author_id = u.user_id
		  where u.is_active = 1
		  and u.is_deleted = 0
		  and aa.asset_type_id in(4,29)
		  and aa.action_id = 4
		  and aa.asset_id = v_videoid
		 ) as row
	into p_authorjson;
	*/
	--select s.p_assetjson
	--from labpkl_v1.labpkl_v1_get_asset_related_stories_r(v_videoid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
	--into p_nextprevjson;
	/*
	select ('{"entities":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select tab.entity_role_map_id, coalesce(em.entity_display_name,'') as ent_display_name, em.canonical_url, content_count
		  from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
				from labpkl_v1.labpkl_v1_asset_list
				where tagged_entity && v_tagged_entitiy
				and is_published = 1
				and published_date <= v_sysdate
				and asset_type_id in(1,2,4,5,29)
				group by unnest(tagged_entity)
			   ) tab
		  join labpkl_v1.labpkl_v1_entity_role_map erm
		  on tab.entity_role_map_id = erm.entity_role_map_id
		  join labpkl_v1.labpkl_v1_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  left join labpkl_v1.labpkl_v1_language_entity_map lem
		  on lem.entity_master_id = em.entity_master_id
		  and lem.language_entity_role_map_id = v_language_id
		  where tab.entity_role_map_id =any(v_tagged_entitiy)
		 ) row
	into p_entjson;
     */
	p_result := 1;

/*exception
	when others then
	p_result := 1;
	p_videojson:=null;*/
	
end;
$$;


--
