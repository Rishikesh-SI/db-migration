-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_album_detail_r(character varying)
-- Type: FUNCTION

-- Name: labsaw_get_album_detail_r(character varying); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_album_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_versionnumber numeric;
	v_albumid numeric;
	v_titlealias text := upper(p_titlealias);
	v_asset_type_id numeric := 2;
	v_imagejsonarr jsonb[];
	v_imagejson jsonb;
	v_json text := '{"items":[';
	v_authorjsonarr jsonb[];
	v_authorjson jsonb;
	v_json1 text := '{"authors":[';
	v_author_count numeric;
	v_language_id numeric;
	v_entjsonarr jsonb[];
	v_entjson jsonb;
	v_json2 varchar(30000) := '{"entities":[';
	v_ent_count numeric;
	v_lang_master_id numeric;
	v_modifieddate timestamp;
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_primary_ent_id numeric;
	v_secondary_ent_id numeric;
	p_nextprevjson jsonb;
	v_logo text;
	v_link text;
	v_cpname text;
	v_tagged_entitiy integer[];
	v_entity_json jsonb;
	v_common_entities integer[];
	
begin
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_albumid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_albumjson, v_language_id, v_primary_ent_id, v_secondary_ent_id
	from labsaw.labsaw_asset_list
	where upper(title_alias) = v_titlealias
	and asset_type_id = 2
	and is_published = 1
	and is_trashed = 0
	and published_date <= v_sysdate;
	
	select array[v_language_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	
	raise notice 'v_tagged_entitiy : %',v_tagged_entitiy;
	
	v_tagged_entitiy := v_tagged_entitiy - v_common_entities;
	--raise notice 'v_tagged_entitiy : %',v_tagged_entitiy;
	--raise notice 'v_common_entities : %',v_common_entities;
	
	select p_albumjson->'data'->'entitydata'
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
as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric ,"priority" numeric )
join labsaw.labsaw_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
join labsaw.labsaw_entity_master b on b.entity_master_id=a.entity_master_id
join labsaw.labsaw_entity_role c on c.entity_role_id=a.entity_role_id
join labsaw.labsaw_entity_type d on d.entity_type_id=c.entity_type_id
	)tab;
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labsaw.labsaw_asset_list
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
	
	p_albumjson := jsonb_set(p_albumjson,'{data,entitydata}',v_entity_json,true);
	p_albumjson := jsonb_set(p_albumjson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
	
	select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
	into v_logo, v_link, v_cpname
	from labsaw.labsaw_asset_list sl
	inner join labsaw.labsaw_provider_author_map PAM
	on sl.author_id = PAM.author_id
	inner join labsaw.labsaw_content_provider CP
	on PAM.content_provider_id = CP.content_provider_id
	where sl.asset_id = v_albumid
	and sl.asset_type_id = v_asset_type_id;
	
	p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true);
	p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
	p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	
	
	
	select p_albumjson->'data'->'author_data' into p_authorjson;

	with tab as
	(select user_id,full_name,display_name
	 from labsaw.labsaw_user
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

	
	 p_albumjson := jsonb_set(p_albumjson,'{data,author_data}',p_authorjson,true);
	 
	 p_authorjson:=('{"authors":'||p_authorjson::text||'}')::jsonb;	
	 
	/*select ('{"items":['||row_to_json(row)||']}')::jsonb
	from (select a.*
		  from (select asset_order as order_number, image_id, image_file_name, image_path, is_cover, i.image_caption, i.image_desc,
						array_to_json(array_agg(em)) entitydata, i.title_alias, aam.is_active, aam.is_deleted, i.copyright_text, aam.phototypeid
				from labsaw.labsaw_album_asset_map aam
				join labsaw.labsaw_image i
				on i.image_id = aam.asset_id
				and aam.asset_type_id = 3
				left join labsaw.labsaw_asset_entity_map aem
				on aem.asset_id = i.image_id
				and aem.asset_type_id = 3
				left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name, emi.entity_master_id
						   from labsaw.labsaw_entity_master emi
						   join labsaw.labsaw_entity_role_map erm
						   on erm.entity_master_id = emi.entity_master_id
						   join labsaw.labsaw_asset_entity_map aem1
						   on aem1.entity_role_map_id = erm.entity_role_map_id
						   join labsaw.labsaw_album_asset_map aam1
						   on aam1.asset_id = aem1.asset_id
						   and aam1.asset_type_id = aem1.asset_type_id
						   and aam1.album_id = v_albumid
						  ) as em
				on aem.entity_role_map_id = em.entity_role_map_id
				where album_id = v_albumid
				and aam.is_deleted = 0
				group by asset_order, image_id, image_file_name, image_path, is_cover, i.image_caption, i.image_desc, i.title_alias,
							aam.is_active, aam.is_deleted, i.copyright_text, aam.phototypeid
				order by order_number
			   ) a
		  order by case when is_cover = 1 then 0 else 1 end, order_number
		 ) row
	into p_imagejson;
	
	select ('{"authors":['||row_to_json(row)||']}')::jsonb
	from (select u.user_id, u.full_name, u.user_name, u.display_name
		  from labsaw.labsaw_user_role as ur
		  join labsaw.labsaw_user as u
		  on u.user_id = ur.user_id
		  join labsaw.labsaw_author_action aa
		  on aa.author_id = u.user_id
		  where u.is_active = 1
		  and u.is_deleted = 0
		  and aa.asset_type_id = 2
		  and aa.action_id = 4
		  and aa.asset_id = v_albumid
		 ) as row
	into p_authorjson;
	
	select s.p_assetjson
	from labsaw.labsaw_get_album_related_stories_r(v_albumid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id], 6) s
	into p_nextprevjson;
	
	p_albumjson := jsonb_set(p_albumjson,'{nextprev}',p_nextprevjson,true);
	*/
-- 	select ('{"entities":['||row_to_json(row)||']}')::jsonb
-- 	from (select aem.entity_role_map_id, coalesce(elm.entity_display_name, em.entity_display_name) ent_display_name, em.canonical_url
-- 		  from labsaw.labsaw_asset_entity_map aem
-- 		  join labsaw.labsaw_entity_role_map erm
-- 		  on erm.entity_role_map_id = aem.entity_role_map_id
-- 		  join labsaw.labsaw_entity_master em
-- 		  on em.entity_master_id = erm.entity_master_id
-- 		  left join labsaw.labsaw_entity_language_map elm
-- 		  on elm.entity_master_id = em.entity_master_id
-- 		  and elm.language_master_id = v_lang_master_id
-- 		  where aem.asset_id = v_albumid
-- 		  and aem.asset_type_id = v_asset_type_id
-- 		 ) row
-- 	into p_entjson;
	
	/*select ('{"entities":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select tab.entity_role_map_id, coalesce(em.entity_display_name,'') as ent_display_name, em.canonical_url, content_count
		  from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
				from labsaw.labsaw_asset_list
				where tagged_entity && v_tagged_entitiy
				and is_published = 1
				and published_date <= v_sysdate
				and asset_type_id in(1,2,4,5,29)
				group by unnest(tagged_entity)
			   ) tab
		  join labsaw.labsaw_entity_role_map erm
		  on tab.entity_role_map_id = erm.entity_role_map_id
		  join labsaw.labsaw_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  left join labsaw.labsaw_language_entity_map lem
		  on lem.entity_master_id = em.entity_master_id
		  and lem.language_entity_role_map_id = v_language_id
		  where tab.entity_role_map_id =any(v_tagged_entitiy)
		 ) row
	into p_entjson;
	*/
	p_result := 1;
     
exception
	when others then
    		p_result := -1;
          p_albumjson:='{"error":"Some error found"}';
end;
$$;


--
