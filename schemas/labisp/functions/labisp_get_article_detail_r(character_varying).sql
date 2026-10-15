-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_article_detail_r(character varying)
-- Type: FUNCTION

-- Name: labisp_get_article_detail_r(character varying); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_article_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
	 v_related_entcount numeric;
	 v_related_content  jsonb;
	 v_entityrole_mapid numeric[];
	 v_tagged_entity integer[];
	 v_common_entities integer[];
     v_entity_json jsonb;
begin
     
     select asset_id, published_version_number, updated_date,web_detail_jsn,language_id,asset_type_id,primary_entity_role_map_id,secondary_entity_role_map_id,tagged_entity
     into   v_articleid, v_versionnumber, v_modifieddate,p_articlejson,v_lang_id,v_asset_type_id,v_primary_ent_id,v_secondary_ent_id,v_tagged_entity
     from   labisp.labisp_asset_list
     where  lower(title_alias) = v_titlealias
     and    published_date    <= v_sysdate
	 and    asset_type_id in (1,5)
	 and is_published=1;
	 
	select array[v_lang_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	
	raise notice 'v_tagged_entity : %',v_tagged_entity;
	raise notice 'v_common_entities : %',v_common_entities;
	v_tagged_entity := v_tagged_entity - v_common_entities;
	raise notice 'v_tagged_entity : %',v_tagged_entity;
	--select p_articlejson->'data'->'entitydata'
	--into v_entity_json;
	
	select ('['||string_agg(row_to_json(tab)::text,',')||']')::jsonb into v_entity_json
	  from (
     select  aem.entity_role_map_id, em.entity_name as name,
	         coalesce(em.entity_display_name,'') entity_display_name,
             em.canonical_url as canonical ,er.entity_role_id,et.entity_type_name,erm.source_object_id, 
		  	null as entity_group_type,aem.is_visible,aem.is_linkable,aem.priority,
		  	case  em.entity_name when 'English' then 1 else 0 end as is_lang,et.entity_type_id
     from labisp.labisp_asset_entity_map aem
	 join labisp.labisp_entity_role_map erm
	 on erm.entity_role_map_id = aem.entity_role_map_id
	 join labisp.labisp_entity_master em
	 on em.entity_master_id = erm.entity_master_id
	 join  labisp.labisp_entity_role er 
	 on erm.entity_role_id = er.entity_role_id
	 join  labisp.labisp_entity_type et 
     on et.entity_type_id = er.entity_type_id  
     where aem.asset_id = v_articleid
     and aem.asset_type_id in (1,5) 
     ) tab;
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labisp.labisp_asset_list
		   where tagged_entity::integer[] && v_tagged_entity
		   and is_published = 1
		   and published_date <= v_sysdate
		   and asset_type_id in(1,5)
		   group by unnest(tagged_entity)
		  ) tab
	 where entity_role_map_id =any(v_tagged_entity)
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
     
	 
	 p_articlejson := jsonb_set(p_articlejson, '{data,modified_date}', ('"'||coalesce(v_modifieddate,null)||'"')::text::jsonb, true); 
       
	 
	 select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labisp.labisp_user as u
      join   labisp.labisp_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id in (1,5)
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid
	  ) tab ;
	 
      /*
      select entity_master_id
      into v_lang_master_id
      from labisp.labisp_entity_role_map
      where entity_role_map_id = v_lang_id;
      */
	  
	  /*select ('{ "entities": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb into p_entjson
	  from (
     select  aem.entity_role_map_id, 
	         coalesce(em.entity_display_name,'')ent_display_name,
             em.canonical_url
     from labisp.labisp_asset_entity_map aem
	 join labisp.labisp_entity_role_map erm
	 on erm.entity_role_map_id = aem.entity_role_map_id
	 join labisp.labisp_entity_master em
	 on em.entity_master_id = erm.entity_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id in (1,5) 
     ) tab ;*/
	 
	
--      p_nextprevjson:= '{}'::jsonb;
	    
-- 	 select p_assetcount,p_assetjson
-- 	 from siwaf.siwaf_related_content_r(1,3,3,array[v_primary_ent_id],null,v_articleid,v_asset_type_id,'labisp')
-- 	 into v_related_entcount,v_related_content;	
	 
-- 	 p_nextprevjson := jsonb_set(p_nextprevjson,'{related_content}',v_related_content); 
	 
	
	select array(select entity_role_map_id  from labisp.labisp_entity_role_map
				  where entity_role_map_id in (select unnest(v_tagged_entity) a )
				  and entity_role_id = 10 and exclude_entity = 0
				 ) into v_entityrole_mapid;
				 
			raise notice 'v_entityrole_mapid : %',v_entityrole_mapid;	 
				 
	if v_entityrole_mapid is null or v_entityrole_mapid::text = '{}' then
	
		
	
		select array(select entity_role_map_id  from labisp.labisp_entity_role_map
				  where entity_role_map_id in (select unnest(v_tagged_entity) a)
				  and entity_role_id in (22,16,17) and exclude_entity = 0
				 ) into v_entityrole_mapid ;
		
		raise notice 'v_entityrole_mapid 1 : %',v_entityrole_mapid;	 
		
			if v_entityrole_mapid::text = '{}' then
			 
			 	v_entityrole_mapid	:= array[v_primary_ent_id];
			 
			end if;
	
	end if;
	
	
	--v_entityrole_mapid := coalesce(v_entityrole_mapid,array[v_secondary_ent_id,v_primary_ent_id]);
	
	-- raise notice '%',v_entityrole_mapid;
	
      p_nextprevjson:= '{}'::jsonb;
	  
	v_asset_type_id := case v_asset_type_id when 5 then 1 else v_asset_type_id end ;
	 
	  
	 select p_assetcount,p_assetjson
	 from siwaf.siwaf_related_content_r(1,3,3,v_entityrole_mapid,null,v_articleid,v_asset_type_id,'labisp')
	 into v_related_entcount,v_related_content;	
	 
	 p_nextprevjson := jsonb_set(p_nextprevjson,'{related_content}',v_related_content); 
     
	 --raise notice '%',v_related_content;
     
     p_result := 1;     
     
end;
$$;


--
