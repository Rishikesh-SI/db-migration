-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_article_detail_r(character varying)
-- Type: FUNCTION

-- Name: labuww_get_article_detail_r(character varying); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_article_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
	v_article_array jsonb;
	v_article_data jsonb;
	v_ref_guid character varying;
	v_drupal_internal__nid numeric;
	v_listing_json jsonb;
	v_listing_json1 jsonb[];
	v_additional_info jsonb;
	v_json text := '{"items":[';
	v_assetjson jsonb;
	 v_asset_count numeric:=0;
begin
	
	select asset_id, published_version_number, updated_date, tagged_entity, web_detail_jsn, language_id, primary_entity_role_map_id,
			secondary_entity_role_map_id
	into strict v_articleid, v_versionnumber, v_modifieddate, v_tagged_entitiy, p_articlejson, v_language_id, v_primary_ent_id,
			v_secondary_ent_id
	from labuww.labuww_asset_list
	where lower(title_alias) = v_titlealias
	and published_date <= v_sysdate
	and asset_type_id = 1
	and is_published = 1;
	
	select web_detail_jsn->'data'->>'AdditonalInfo' into v_additional_info
	from labuww.labuww_asset_list
	where asset_id=v_articleid
	and asset_type_id = 1;
	
			raise notice 'v_additional_info - 1 %',v_additional_info ;

	
	select v_additional_info->>'field_related_article' into v_article_array;
	
	if v_article_array is not null then
	
	for v_article_data in select * from jsonb_array_elements(v_article_array)
      loop
        select v_article_data->>'guid',
       		   v_article_data->>'drupal_internal__nid'
			   into
			   v_ref_guid,
			   v_drupal_internal__nid;
			

			
			   
			   select web_listing_json
			   into v_listing_json
			   from labuww.labuww_asset_list a
			   join labuww.labuww_article b
			   on a.asset_id=b.article_id
			   where b.article_guid=v_ref_guid and
			   a.asset_type_id=1;
			   
			--raise notice 'v_listing_json - 1 %',v_listing_json ;
			   
		v_listing_json1:= v_listing_json1 || v_listing_json;
			
	   --v_listing_json1:= v_listing_json1 || v_listing_json::jsonb;
			

	  end loop;		   
	
	--raise notice 'v_listing_json1 %',v_listing_json1;
	
	 foreach v_assetjson in array v_listing_json1
     loop
	 	--raise notice 'v_assetjson %',v_assetjson ;
		
     	v_json := v_json||v_assetjson||',';
     end loop;
	--raise notice 'v_json %',v_json ;
	
	     select count(1)
    	into    v_asset_count
    	from    unnest(v_listing_json1);
      
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_asset_count>0 then
        v_json:= substring(v_json,1,(length(v_json)-1));
     else 
        v_json:= substring(v_json,1,(length(v_json)));
     end if;
	
	
	v_json := v_json||']}';
	raise notice 'v_json - final %',v_json ;
	
	--v_json:= '{"items":'|| to_jsonb(v_listing_json1)||'}';
	
	
    p_articlejson:=jsonb_set(p_articlejson,'{data,related_data}',coalesce(v_json::jsonb,'null'), true);		

end if;

raise notice '%',v_tagged_entitiy;
	--select 1/0;
	select array[v_language_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	
	v_tagged_entitiy := v_tagged_entitiy - v_common_entities;
	
	
	select p_articlejson->'data'->'entitydata'
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
as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric,"priority" numeric )
join labuww.labuww_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
join labuww.labuww_entity_master b on b.entity_master_id=a.entity_master_id
join labuww.labuww_entity_role c on c.entity_role_id=a.entity_role_id
join labuww.labuww_entity_type d on d.entity_type_id=c.entity_type_id
	)tab;
		--raise notice '%',v_tagged_entitiy;
		--p_articlejson := jsonb_set(p_articlejson,'{data,entitydata}',v_entity_json,true);
	--select 1/0;
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labuww.labuww_asset_list
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
	from labuww.labuww_asset_list sl
	inner join labuww.labuww_provider_author_map PAM
	on sl.author_id = PAM.author_id
	inner join labuww.labuww_content_provider CP
	on PAM.content_provider_id = CP.content_provider_id
	where sl.asset_id = v_articleid
	and sl.asset_type_id = v_asset_type_id;
	
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);
	
	
	select p_articlejson->'data'->'author_data' into p_authorjson;
	raise notice 'p_authorjson %',p_authorjson;

	with tab as
	(select user_id,full_name,bio,display_name
	 from labuww.labuww_user
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
		 
		 with tab as
	(select user_id,full_name,bio,display_name
	 from labuww.labuww_user
	a  join (select (obj.values->>'author_id')::numeric as author_id  
			 from jsonb_array_elements(p_authorjson) as obj(values) 
			 where (obj.values->>'action_id')::numeric=4
			) tab on a.user_id=tab.author_id 
	
	)
	select json_agg(row_to_json(row)->'data')::jsonb
		 
	from (select jsonb_set(author,'{author_bio}', ('"'||tab.bio||'"')::text::jsonb, true) as data
		  from (select jsonb_array_elements(p_authorjson) as author)  as tab1
		  left join tab
		  on tab.user_id = (tab1.author->>'author_id')::numeric
		  where (tab1.author->>'action_id')::numeric=4
		 ) row
		 into p_authorjson;
		 
		 raise notice 'p_authorjson-n %',p_authorjson;

	
	 --p_articlejson := jsonb_set(p_articlejson,'{data,author_data}',p_authorjson,true);
	 
	 p_authorjson:=('{"authors":'||p_authorjson::text||'}')::jsonb;
	
	/*select ('{"authors":['||row_to_json(row)||']}')::jsonb
	from (select u.user_id, u.full_name, u.user_name, u.display_name
		  from labuww.labuww_user_role as ur
		  join labuww.labuww_user as u
		  on u.user_id = ur.user_id
		  join labuww.labuww_author_action aa
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
				from labuww.labuww_asset_list
				where tagged_entity && v_tagged_entitiy
				and is_published = 1
				and published_date <= v_sysdate
				and asset_type_id in(1,2,4,5,29)
				group by unnest(tagged_entity)
			   ) tab
		  join labuww.labuww_entity_role_map erm
		  on tab.entity_role_map_id = erm.entity_role_map_id
		  join labuww.labuww_entity_master em
		  on em.entity_master_id = erm.entity_master_id
		  left join labuww.labuww_language_entity_map lem
		  on lem.entity_master_id = em.entity_master_id
		  and lem.language_entity_role_map_id = v_language_id
		  where tab.entity_role_map_id =any(v_tagged_entitiy)
		 ) row
	into p_entjson;
	*/
	p_result := 1;
	
	/*select s.p_assetjson
	from labuww.labuww_get_album_related_stories_r(v_articleid,v_asset_type_id,ARRAY[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
	into p_nextprevjson;
*/
exception when others 
then 
p_result := -1;
p_articlejson :='{"Error":"Some error found"}';

end;
$$;


--
