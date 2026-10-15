-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_article_detail_rbk(character varying)
-- Type: FUNCTION

-- Name: yho_get_article_detail_rbk(character varying); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_article_detail_rbk(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_articleid numeric;
     v_titlealias text := lower(p_titlealias);
     v_image_caption text;
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric := 1;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_copyrighttext text;
     v_id_array numeric[];
	 v_logo text;
     v_link text;
     v_cpname text;
     v_assettype numeric;
	v_full_text text;
     
begin
	
    select article_id, published_version_number into v_articleid, v_versionnumber
	from yho.yho_article where lower(title_alias) = v_titlealias
	and is_published=1;
    
	
      select (case is_live_blog when 1 then 5 else 1 end )  into v_assettype 
	  from yho.yho_article
	  where article_id=v_articleid;
	
	
    select asset_data into strict p_articlejson from yho.yho_asset_draft
    where asset_type_id = v_assettype and asset_id = v_articleid 
    and version_number = v_versionnumber
    limit 1;
    
    select p_articlejson->'data'->>'full_text' into v_full_text;
	
	v_full_text := regexp_replace(v_full_text,
							'<script[^>]*src=\"https:\/\/platform\.twitter\.com\/widgets\.js\"[^>]*\/[^>]*>',
						    '<script async="true" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
						    'g');
	
	p_articlejson := jsonb_set(p_articlejson,
						  '{data,full_text}',
						  ('"'||regexp_replace(regexp_replace(regexp_replace(v_full_text,'\\','\\\\','g'),'"','\"','g'),'[\r\n\t]+','','g')||'"')::jsonb,
						  false);
    
	select image_caption into v_image_caption from yho.yho_image
    where image_id = (select asset_id from yho.yho_article_asset_map where article_id = v_articleid and is_cover = 1);
	v_image_caption := replace(v_image_caption,'"','\"');
    p_articlejson := jsonb_set(p_articlejson, '{data,image_caption}', ('"'||coalesce(v_image_caption,'')||'"')::text::jsonb, true);
    
    select copyright_text into v_copyrighttext
    from yho.yho_article_asset_map aam join yho.yho_image i on i.image_id = aam.asset_id
    where article_id = v_articleid and asset_type_id = 3;
    v_copyrighttext:=replace(v_copyrighttext,'"','\"');
    p_articlejson := jsonb_set(p_articlejson, '{data,copyright_text}', ('"'||coalesce(v_copyrighttext,'')||'"')::text::jsonb, true);
    
    select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name into v_logo, v_link, v_cpname
    from yho.yho_asset_list sl
    join yho.yho_provider_author_map PAM
    on sl.author_id = PAM.author_id
    join yho.yho_content_provider CP
    on PAM.content_provider_id = CP.content_provider_id
    where sl.asset_id = v_articleid
    and sl.asset_type_id = v_assettype;
    
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true); 
    p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true); 
    
    select ('{"authors":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb jsonrow
    from (select u.user_id, u.full_name user_name
          from yho.yho_user as u join yho.yho_author_action aa on aa.author_id = u.user_id
          where u.is_active = 1 and u.is_deleted = 0 and aa.asset_type_id = v_assettype and aa.action_id = 4 and aa.asset_id = v_articleid) as row
	into p_authorjson;
    
    SELECT primary_entity_role_map_id, secondary_entity_role_map_id into v_primary_ent_id, v_secondary_ent_id
    FROM yho.yho_ASSET_LIST WHERE ASSET_TYPE_ID = v_asset_type_id and asset_id = v_articleid;
    
    SELECT AE.ENTiTY_ROLE_MAP_ID, em.entity_master_id into v_language_id, v_lang_master_id
    FROM yho.yho_ASSET_ENTITY_MAP AE
    JOIN yho.yho_ENTITY_ROLE_MAP AR
    ON AE.ENTiTY_ROLE_MAP_ID = AR.ENTiTY_ROLE_MAP_ID
    join yho.yho_entity_master em
    on em.entity_master_id = ar.entity_master_id
    JOIN yho.yho_ENTITY_CATEGORY EC
    ON AR.ENTITY_ROLE_ID = EC.ENTITY_ROLE_ID
    WHERE ASSET_TYPE_ID = v_asset_type_id
    and asset_id = v_articleid
    AND ec.category_name = 'Language';
    
    select array(select distinct id from unnest(array[v_primary_ent_id,v_secondary_ent_id,v_language_id])id) into v_id_array;
    
    -- select s.p_assetjson from yho.yho_get_asset_related_stories_r(v_articleid,v_asset_type_id,v_id_array,3) s into p_nextprevjson;
    p_nextprevjson := '{}'::jsonb;
    
     select ('{"entities":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb jsonrow
     from (select aem.entity_role_map_id, COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name, em.canonical_url
           from yho.yho_asset_entity_map aem
           join yho.yho_entity_role_map erm
           on erm.entity_role_map_id = aem.entity_role_map_id
           join yho.yho_entity_master em
           on em.entity_master_id = erm.entity_master_id
           left join yho.yho_entity_language_map elm
           on elm.entity_master_id = em.entity_master_id
           and elm.language_master_id = v_lang_master_id
           where aem.asset_id = v_articleid
           and aem.asset_type_id = v_asset_type_id)row
     into p_entjson;
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;

 

$$;


--
