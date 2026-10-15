-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_web_stories_detail_r(character varying)
-- Type: FUNCTION

-- Name: labmi_v1_get_web_stories_detail_r(character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_web_stories_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_wbjson jsonb, OUT p_mediajson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_webstory_id numeric;
     v_titlealias text := upper(p_titlealias);
     v_asset_type_id numeric := 142;
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
     v_entity_json jsonb;
	 v_author_id numeric;
	 v_author_slug character varying;
begin

     select webstory_id, published_version_number, updated_date
     into   strict v_webstory_id, v_versionnumber, v_modifieddate
     from   labmi_v1.labmi_v1_webstory
     where  upper(title_alias) = v_titlealias
     and    published_date <= v_sysdate
     and is_deleted=0 and is_published=1 and is_trashed=0 and is_active=1;
     
	 raise notice 'v_webstory_id:%',v_webstory_id;
	 raise notice 'v_asset_type_id:%',v_asset_type_id;
	 					
			---------------------------
      UPDATE labmi_v1.labmi_v1_asset_list
SET web_detail_jsn = jsonb_set(
    web_detail_jsn, 
    '{data,webstory_id}',  
    to_jsonb(v_webstory_id::text),  
    true  -- Create the key if it doesn't exist
)
WHERE asset_id = v_webstory_id 
  AND asset_type_id = v_asset_type_id ;

--------------------------------

     select sl.updated_date ,sl.web_detail_jsn,sl.language_id,CP.logo content_provider_logo, 
	 CP.link content_provider_link, CP.content_provider_name,sl.author_id 
     into v_modifieddate ,p_wbjson,v_language_id, v_logo,v_link,v_cpname,v_author_id
     from labmi_v1.labmi_v1_asset_list sl
	 left join labmi_v1.labmi_v1_provider_author_map PAM
				on ( sl.author_id = PAM.author_id)
			  left join labmi_v1.labmi_v1_content_provider CP 
				on (PAM.content_provider_id = CP.content_provider_id)
     where asset_id = v_webstory_id
     and asset_type_id = v_asset_type_id
	-- and sl.is_published=1
-- 	 and sl.is_trashed=0
      and sl.is_active=1
      and sl.is_deleted=0
	  ;    
    
    p_wbjson := jsonb_set(p_wbjson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
	p_wbjson := jsonb_set(p_wbjson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
    p_wbjson := jsonb_set(p_wbjson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
    p_wbjson := jsonb_set(p_wbjson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
	
	 select 'wisden-contributors/'||replace(lower(user_name),'_','-')||'-'||user_id from labmi_v1.labmi_v1_user where user_id=v_author_id into v_author_slug;
	 
    p_wbjson := jsonb_set(p_wbjson, '{data,author_data,0,author_slug}', ('"'||coalesce(v_author_slug,'')||'"')::text::jsonb, true);
        
 --     select '{"items":['||string_agg(row_to_json(row)::text,',')||']}'  into p_mediajson
 --     from
 --     ( select 
 --      a.*
 --     from (
	-- 	select webstory_slide_id as order_number, image_id, image_file_name, image_path ,is_cover, array_to_json(array_agg(em)) entitydata,
 --                 image_caption, image_desc,
	--             title_alias, aam.is_active,
	--     aam.is_deleted, copyright_text,
	-- aam.phototypeid,
	-- null phototypename,
	-- case when asset_type_id=3 then 1 else 0 end as is_image,
	-- aam.cta_text,
	-- aam.cta_link,
	-- aam.media_url,
	-- aam.thumbnail_url,
	-- aam.webstory_slide_id
 --     from   labmi_v1.labmi_v1_webstory_asset_map aam
 -- --     left join   labmi_v1.labmi_v1_image i
 -- --     on     i.image_id = aam.webstory_id
 -- --     and    aam.asset_type_id = 3
	-- -- left join   labmi_v1.labmi_v1_webstory_asset_map aem
 -- --         on aem.asset_id = i.image_id
 -- --         and aem.asset_type_id = 3
	-- -- left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
 -- --                 from   labmi_v1.labmi_v1_entity_master emi
	-- -- 		join   labmi_v1.labmi_v1_entity_role_map erm
 -- --               on     erm.entity_master_id = emi.entity_master_id
 -- --                join  labmi_v1.labmi_v1_asset_entity_map aem1
 -- --                on    aem1.entity_role_map_id = erm.entity_role_map_id
 -- --                 join labmi_v1.labmi_v1_webstory_asset_map aam1
 -- --                 on  aam1.asset_id = aem1.asset_id
 -- --                 and  aam1.asset_type_id = aem1.asset_type_id
 -- --                 and aam1.album_id =  v_webstory_id
 -- --                ) as em
 -- --               on         aem.entity_role_map_id = em.entity_role_map_id
	
 --     where  album_id = v_webstory_id
 --         and aam.is_deleted = 0
	-- 	 group by webstory_slide_id, image_id, image_file_name, image_path ,is_cover, image_caption, image_desc
 --         , title_alias, aam.is_active, aam.is_deleted, copyright_text,aam.phototypeid
 --         order by order_number
     
 --              )a
 --   order by case when is_cover=1 then 0 else 1 end,order_number
 --             )
             
 --             as row
 --             ;

		p_mediajson:='{}';
 
       select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labmi_v1.labmi_v1_user as u
      join   labmi_v1.labmi_v1_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_webstory_id
	  ) tab ;
  
      
      select entity_master_id
      into v_lang_master_id
      from labmi_v1.labmi_v1_entity_role_map
      where entity_role_map_id = v_language_id;
      /*
      select primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     from labmi_v1.labmi_v1_asset_list 
     where asset_type_id=v_asset_type_id
     and asset_id=v_webstory_id;
     
     ------------- changes done by rakesh bhatkar date:-11062017
     
     

     
       select s.p_assetjson
     from labmi_v1.labmi_v1_get_album_related_stories_r(v_webstory_id,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],6) s
    into p_nextprevjson;
     
     
    p_wbjson:=jsonb_set(p_wbjson,'{nextprev}',p_nextprevjson,true);
   ---------------- changes done by rakesh bhatkar date:-11062017
     */
	 
	 
	 select p_wbjson->'data'->'entitydata'
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
		join labmi_v1.labmi_v1_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
		join labmi_v1.labmi_v1_entity_master b on b.entity_master_id=a.entity_master_id
		join labmi_v1.labmi_v1_entity_role c on c.entity_role_id=a.entity_role_id
		join labmi_v1.labmi_v1_entity_type d on d.entity_type_id=c.entity_type_id
			)tab;
			
	  p_wbjson := jsonb_set(p_wbjson,'{data,entitydata}',v_entity_json,true);
    
     select ('{ "entities": ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb  into p_entjson
     from(
     select aem.entity_role_map_id, 
         coalesce(elm.entity_display_name,
                  em.entity_display_name)ent_display_name,
         -- labmi_v1.labmi_v1_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labmi_v1.labmi_v1_asset_entity_map aem
	join labmi_v1.labmi_v1_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labmi_v1.labmi_v1_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labmi_v1.labmi_v1_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_webstory_id
     and aem.asset_type_id = v_asset_type_id
     )row;

     p_result := 1;
     
-- exception
-- 	when others then
--     		p_result := -1;
--             p_mediajson := '{"items":[]}';
--             p_authorjson := '{"authors":[]}';

			
end;

 

$$;


--
