-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_article_detail_r_niu(character varying)
-- Type: FUNCTION

-- Name: labstmp_get_article_detail_r_niu(character varying); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_article_detail_r_niu(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     
begin
     
     select asset_id, published_version_number, updated_date,web_detail_jsn,language_id
     into   v_articleid, v_versionnumber, v_modifieddate,p_articlejson,v_lang_id
     from   labstmp.labstmp_asset_list
     where  lower(title_alias) = v_titlealias
     and    published_date    <= v_sysdate
	 and    asset_type_id = 1
	 and    is_published= 1;
     
	 
	 select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
      into v_logo,v_link,v_cpname
      from labstmp.labstmp_asset_list sl
      inner join labstmp.labstmp_provider_author_map PAM
				on ( sl.author_id = PAM.author_id)
			  inner join labstmp.labstmp_content_provider CP 
				on (PAM.content_provider_id = CP.content_provider_id)
		where sl.asset_id = v_articleid
        and sl.asset_type_id = v_asset_type_id;
        
        p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
        p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
        p_articlejson := jsonb_set(p_articlejson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
  		p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);
	 
	 select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labstmp.labstmp_user as u
      join   labstmp.labstmp_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid
	  ) tab ;
	 
      /*
      select entity_master_id
      into v_lang_master_id
      from labstmp.labstmp_entity_role_map
      where entity_role_map_id = v_lang_id;
      */
	  
	  select ('{ "entities": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb into p_entjson
	  from (
     select  aem.entity_role_map_id, 
	         coalesce(em.entity_display_name,'')ent_display_name,
             em.canonical_url
     from labstmp.labstmp_asset_entity_map aem
	 join labstmp.labstmp_entity_role_map erm
	 on erm.entity_role_map_id = aem.entity_role_map_id
	 join labstmp.labstmp_entity_master em
	 on em.entity_master_id = erm.entity_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id = v_asset_type_id 
     ) tab ;
     
     
     p_result := 1;   
	 
	 
	 
	  SELECT primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     FROM labstmp.labstmp_ASSET_LIST 
     WHERE ASSET_TYPE_ID=v_asset_type_id
     and asset_id=v_articleid;
     
      SELECT AE.ENTiTY_ROLE_MAP_ID 
      into v_language_id
      FROM labstmp.labstmp_ASSET_ENTITY_MAP AE
      JOIN labstmp.labstmp_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN labstmp.labstmp_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_articleid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from labstmp.labstmp_entity_role_map
      where entity_role_map_id = v_language_id;
      
     select s.p_assetjson
     from labstmp.labstmp_get_album_related_stories_r(v_articleid,v_asset_type_id,ARRAY[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
     into p_nextprevjson;
     
end;

 

$$;


--
