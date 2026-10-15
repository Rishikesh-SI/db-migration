-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_article_detail_r(character varying)
-- Type: FUNCTION

-- Name: labstmp_get_article_detail_r(character varying); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_article_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_versionnumber numeric;
	v_articleid numeric;
	v_titlealias text := lower(p_titlealias);
	v_image_caption varchar(4000);
	v_authorjsonarr jsonb[];
	v_authorjson jsonb;
	-- v_json1 varchar(30000) := '{"authors":[';
	v_author_count numeric;
	v_primary_ent_id numeric;
	v_secondary_ent_id numeric;
	v_asset_type_id numeric:=1;
	v_language_id numeric;
	v_entjsonarr jsonb[];
	v_entjson jsonb;
	--  v_json2 varchar(30000) := '{"entities":[';
	v_ent_count numeric;
	v_lang_master_id numeric;
	v_copyrighttext varchar(4000);
	v_imageid numeric;
	v_modifieddate timestamp;
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_lang_id numeric;
	v_logo text;
	v_link text;
	v_cpname text;
	v_tagged_entitiy integer[];
	v_entity_json jsonb;
	v_common_entities integer[];
	
begin
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_articleid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_articlejson, v_language_id, v_primary_ent_id,
			v_secondary_ent_id
	from labstmp.labstmp_asset_list
	where lower(title_alias) = v_titlealias
	and published_date <= v_sysdate
	and asset_type_id = 1
	and is_published = 1;
	
	select array[v_language_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	
	v_tagged_entitiy := v_tagged_entitiy - v_common_entities;
	
	select p_articlejson->'data'->'entitydata'
	into v_entity_json;
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labstmp.labstmp_asset_list
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
	
	p_articlejson := jsonb_set(p_articlejson,'{data,entitydata}',v_entity_json,true);
	
	select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
	into v_logo, v_link, v_cpname
	from labstmp.labstmp_asset_list sl
	inner join labstmp.labstmp_provider_author_map PAM
	on sl.author_id = PAM.author_id
	inner join labstmp.labstmp_content_provider CP
	on PAM.content_provider_id = CP.content_provider_id
	where sl.asset_id = v_articleid
	and sl.asset_type_id = v_asset_type_id;
	
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);
	
	select ('{"authors":['||row_to_json(row)||']}')::jsonb
	from (select u.user_id, u.full_name, u.user_name, u.display_name
		  from labstmp.labstmp_user_role as ur
		  join labstmp.labstmp_user as u
		  on u.user_id = ur.user_id
		  join labstmp.labstmp_author_action aa
		  on aa.author_id = u.user_id
		  where u.is_active = 1
		  and u.is_deleted = 0
		  and aa.asset_type_id = 1
		  and aa.action_id = 4
		  and aa.asset_id = v_articleid
		 ) as row
	into p_authorjson;
	
	select ('{"entities":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select tab.entity_role_map_id, coalesce(em.entity_display_name,'') as ent_display_name, em.canonical_url, content_count
		  from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
				from labstmp.labstmp_asset_list
				where tagged_entity && v_tagged_entitiy
				and is_published = 1
				and published_date <= v_sysdate
				and asset_type_id in(1,2,4,5,29)
				group by unnest(tagged_entity)
			   ) tab
		  join labstmp.labstmp_entity_role_map erm
		  on tab.entity_role_map_id = erm.entity_role_map_id
		  join labstmp.labstmp_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  left join labstmp.labstmp_language_entity_map lem
		  on lem.entity_master_id = em.entity_master_id
		  and lem.language_entity_role_map_id = v_language_id
		  where tab.entity_role_map_id =any(v_tagged_entitiy)
		 ) row
	into p_entjson;
	
	p_result := 1;
	
	/*select s.p_assetjson
	from labstmp.labstmp_get_album_related_stories_r(v_articleid,v_asset_type_id,ARRAY[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
	into p_nextprevjson;

*/
exception when others 
then 
p_result := -1;
p_articlejson :=null;

end;

$$;


--
