-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_article_detail_r_test(character varying)
-- Type: FUNCTION

-- Name: labyho_get_article_detail_r_test(character varying); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_article_detail_r_test(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

  
declare
	v_full_text text;
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
     v_assettype numeric;
	 v_logo varchar(1000);
	 v_link varchar(1000);
	 v_cpname varchar(1000);
	 
	 v_common_entities integer[];
	 v_entity_json jsonb;
	 v_tagged_entity integer[];
	 
begin
     
	  select article_id, published_version_number into v_articleid, v_versionnumber
	  from labyho.labyho_article where lower(title_alias) = v_titlealias
	  and is_published=1;
	 
	 
      select (case is_live_blog when 1 then 5 else 1 end )  into v_assettype 
	  from labyho.labyho_article
	  where article_id=v_articleid;
	  
	  
     select  sl.published_version_number, sl.updated_date,sl.web_detail_jsn,sl.language_id, CP.logo content_provider_logo,
	 			CP.link content_provider_link, CP.content_provider_name, primary_entity_role_map_id, secondary_entity_role_map_id,
				sl.tagged_entity
     into v_versionnumber, v_modifieddate,p_articlejson,v_lang_id,v_logo, v_link, v_cpname, v_primary_ent_id,
			v_secondary_ent_id, v_tagged_entity
     from   labyho.labyho_asset_list sl
	 left join labyho.labyho_provider_author_map PAM
     on sl.author_id = PAM.author_id
     left join labyho.labyho_content_provider CP
     on PAM.content_provider_id = CP.content_provider_id
     where  sl.asset_id=v_articleid
     and    sl.published_date    <= v_sysdate
	 and    sl.asset_type_id = v_assettype;
     
	 select array[v_lang_id, v_primary_ent_id, v_secondary_ent_id]::integer[]
	into v_common_entities;
	 
	 v_tagged_entity := v_tagged_entity - v_common_entities;
	raise notice 'v_tagged_entitiy : %',v_tagged_entity;
	select p_articlejson->'data'->'entitydata'
	into v_entity_json;
	
	with tab as
	(select entity_role_map_id, content_count
	 from (select unnest(tagged_entity) entity_role_map_id, count(1) content_count
		   from labyho.labyho_asset_list
		   where tagged_entity && v_tagged_entity
		   and is_published = 1
		   and published_date <= v_sysdate
		   and asset_type_id in(1,2,4,5,29)
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
	 
	 
	  select p_articlejson->'data'->>'full_text' into v_full_text;
	
	v_full_text := regexp_replace(v_full_text,
							'<script[^>]*src=\"https:\/\/platform\.twitter\.com\/widgets\.js\"[^>]*\/[^>]*>',
						    '<script async="true" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
						    'g');
	 
	 p_articlejson := jsonb_set(p_articlejson,
						  '{data,full_text}',
						  ('"'||regexp_replace(regexp_replace(regexp_replace(v_full_text,'\\','\\\\','g'),'"','\"','g'),'[\r\n\t]+','','g')||'"')::jsonb,
						  false);
						  
		select image_caption into v_image_caption
		from labyho.labyho_image
	
    where image_id = (select asset_id from labyho.labyho_article_asset_map 
					  where article_id = v_articleid and is_cover = 1);
	
	v_image_caption := replace(v_image_caption,'"','\"');
    p_articlejson := jsonb_set(p_articlejson, '{data,image_caption}', ('"'||coalesce(v_image_caption,'')||'"')::text::jsonb, true);
   
    select copyright_text into v_copyrighttext
    from labyho.labyho_article_asset_map aam 
	join labyho.labyho_image i on i.image_id = aam.asset_id
    where article_id = v_articleid and i.asset_type_id = 3;
    v_copyrighttext:=replace(v_copyrighttext,'"','\"');
    p_articlejson := jsonb_set(p_articlejson, '{data,copyright_text}', ('"'||coalesce(v_copyrighttext,'')||'"')::text::jsonb, true);
    
   
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true); 
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true); 
    
	 select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labyho.labyho_user as u
      join   labyho.labyho_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_assettype
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid
	  ) tab ;
	 
      /*
      select entity_master_id
      into v_lang_master_id
      from labyho.labyho_entity_role_map
      where entity_role_map_id = v_lang_id;
      */
	  
	  select ('{ "entities": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb into p_entjson
	  from (
     select  aem.entity_role_map_id, 
	         coalesce(em.entity_display_name,'')ent_display_name,
             em.canonical_url
     from labyho.labyho_asset_entity_map aem
	 join labyho.labyho_entity_role_map erm
	 on erm.entity_role_map_id = aem.entity_role_map_id
	 join labyho.labyho_entity_master em
	 on em.entity_master_id = erm.entity_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id = v_assettype
     ) tab ;
     
     
     p_result := 1;     
     
end;

 

$$;


--
