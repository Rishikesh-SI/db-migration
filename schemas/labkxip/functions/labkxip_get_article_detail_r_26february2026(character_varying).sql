-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_article_detail_r_26february2026(character varying)
-- Type: FUNCTION

-- Name: labkxip_get_article_detail_r_26february2026(character varying); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_article_detail_r_26february2026(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
	v_pri_ent_url text;
	v_pri_entity_url_type numeric;
	v_sec_ent_url text;
	v_sec_entity_url_type numeric;
	v_pri_canonical_url text;
	v_sec_canonical_url text;
	
begin
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_entity_role_map_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_articleid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_articlejson, v_language_id, v_primary_ent_id,
			v_secondary_ent_id
	from labkxip.labkxip_asset_list
	where lower(title_alias) = v_titlealias
	and published_date <= v_sysdate
	and asset_type_id = 1
	and is_published = 1;
	
	
	
	select array[v_language_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	
	raise notice '%',v_common_entities;
	
	v_tagged_entitiy := v_tagged_entitiy - v_common_entities;
	
		p_articlejson := jsonb_set(p_articlejson, '{data,article_id}', ('"'||coalesce(v_articleid,0)||'"')::text::jsonb, true); 

	
	select p_articlejson->'data'->'entitydata'
	into v_entity_json;
	
	
	
	
	
	
	select jsonb_agg(tab) into v_entity_json from (
select name,canonical_url as canonical,
entity_display_name as ent_disp_name,
x.entity_role_map_id ,
entity_url,
c.entity_type_id,
d.entity_type_name,
d.entity_url_type,
x.priority
from jsonb_to_recordset(v_entity_json)
as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric,"priority" numeric )
join labkxip.labkxip_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
join labkxip.labkxip_entity_master b on b.entity_master_id=a.entity_master_id
join labkxip.labkxip_entity_role c on c.entity_role_id=a.entity_role_id
join labkxip.labkxip_entity_type d on d.entity_type_id=c.entity_type_id
	)tab;
		
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labkxip.labkxip_asset_list
		   where tagged_entity::integer[] && v_tagged_entitiy
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
	from labkxip.labkxip_asset_list sl
	inner join labkxip.labkxip_provider_author_map PAM
	on sl.author_id = PAM.author_id
	inner join labkxip.labkxip_content_provider CP
	on PAM.content_provider_id = CP.content_provider_id
	where sl.asset_id = v_articleid
	and sl.asset_type_id = v_asset_type_id;
	
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	
	p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);

	
	select p_articlejson->'data'->'author_data' into p_authorjson;

	with tab as
	(select user_id,full_name,bio,display_name
	 from labkxip.labkxip_user
	a  join (select (obj.values->>'author_id')::numeric as author_id  
			 from jsonb_array_elements(p_authorjson) as obj(values) 
			 where (obj.values->>'action_id')::numeric=4
			) tab on a.user_id=tab.author_id 
	
	)
	select json_agg(row_to_json(row)->'data')::jsonb
		 
	from (select 
	jsonb_set(author,'{author_name}', ('"'||tab.full_name||'"')::text::jsonb, true) as data
		  from (select jsonb_array_elements(p_authorjson) as author)  as tab1
		  left join tab
		  on tab.user_id = (tab1.author->>'author_id')::numeric
		  where (tab1.author->>'action_id')::numeric=4
		 ) row
		 into p_authorjson;
		 
		 with tab as
	(select user_id,full_name,bio,display_name
	 from labkxip.labkxip_user
	a  join (select (obj.values->>'author_id')::numeric as author_id  
			 from jsonb_array_elements(p_authorjson) as obj(values) 
			 where (obj.values->>'action_id')::numeric=4
			) tab on a.user_id=tab.author_id 
	
	)
	select json_agg(row_to_json(row)->'data')::jsonb
		 
	from (select jsonb_set(author,'{author_bio}', to_json(tab.bio)::text::jsonb, true) as data
		  from (select jsonb_array_elements(p_authorjson) as author)  as tab1
		  left join tab
		  on tab.user_id = (tab1.author->>'author_id')::numeric
		  where (tab1.author->>'action_id')::numeric=4
		 ) row
		 into p_authorjson;
		 
		 

	
	 p_articlejson := jsonb_set(p_articlejson,'{data,author_data}',p_authorjson,true);
	 
	 p_authorjson:=('{"authors":'||p_authorjson::text||'}')::jsonb;
	 
	 /*
	select b.entity_url as pri_ent_url,d.entity_url_type as pri_entity_url_type,
			b1.entity_url as sec_ent_url,d1.entity_url_type as sec_entity_url_type,
			b.canonical_url as pri_canonical_url ,b1.canonical_url as sec_canonical_url
	into   v_pri_ent_url,v_pri_entity_url_type,	v_sec_ent_url,v_sec_entity_url_type,
		   v_pri_canonical_url,v_sec_canonical_url
	from  labkxip.labkxip_asset_list sl
	left join labkxip.labkxip_entity_role_map a on sl.primary_entity_role_map_id = a.entity_role_map_id  
	left join labkxip.labkxip_entity_master b on a.entity_master_id = b.entity_master_id
	left join labkxip.labkxip_entity_role c on a.entity_role_id = c.entity_role_id
	left join labkxip.labkxip_entity_type d on c.entity_type_id = d.entity_type_id
	left join labkxip.labkxip_entity_role_map a1 on sl.secondary_entity_role_map_id = a1.entity_role_map_id  
	left join labkxip.labkxip_entity_master b1 on a1.entity_master_id = b1.entity_master_id
	left join labkxip.labkxip_entity_role c1 on a1.entity_role_id = c1.entity_role_id
	left join labkxip.labkxip_entity_type d1 on c1.entity_type_id = d1.entity_type_id
	where sl.asset_id = v_articleid and sl.asset_type_id = v_asset_type_id ;
	
	
	p_articlejson := jsonb_set(p_articlejson, '{data,pri_ent_url}', ('"'||coalesce(v_pri_ent_url,'')||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,pri_entity_url_type}', ('"'||coalesce(v_pri_entity_url_type,0)||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,sec_ent_url}', ('"'||coalesce(v_sec_ent_url,'')||'"')::text::jsonb, true);
	
	p_articlejson := jsonb_set(p_articlejson, '{data,sec_entity_url_type}', ('"'||coalesce(v_sec_entity_url_type,0)||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,pri_canonical_url}', ('"'||coalesce(v_pri_canonical_url,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,sec_canonical_url}', ('"'||coalesce(v_sec_canonical_url,'')||'"')::text::jsonb, true);
	
	*/
	p_result := 1;
	
	
exception when others 
then 
p_result := -1;
p_articlejson :='{"Error":"Some error found"}';

end;
$$;


--
