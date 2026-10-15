-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_article_detail_r(character varying)
-- Type: FUNCTION

-- Name: labirao_get_article_detail_r(character varying); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_article_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     
begin
     
     select asset_id, published_version_number, updated_date,web_detail_jsn,language_id
     into   v_articleid, v_versionnumber, v_modifieddate,p_articlejson,v_lang_id
     from   labirao.labirao_asset_list
     where  lower(title_alias) = v_titlealias
     and    published_date    <= v_sysdate
	 and    asset_type_id = 1
	 and is_published=1;
     
	 
	 p_articlejson := jsonb_set(p_articlejson, '{data,modified_date}', ('"'||coalesce(v_modifieddate,null)||'"')::text::jsonb, true); 
       
	 
	 select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labirao.labirao_user as u
      join   labirao.labirao_author_action aa
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
      from labirao.labirao_entity_role_map
      where entity_role_map_id = v_lang_id;
      */
	  
	  select ('{ "entities": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb into p_entjson
	  from (
     select  aem.entity_role_map_id, 
	         coalesce(em.entity_display_name,'')ent_display_name,
             em.canonical_url
     from labirao.labirao_asset_entity_map aem
	 join labirao.labirao_entity_role_map erm
	 on erm.entity_role_map_id = aem.entity_role_map_id
	 join labirao.labirao_entity_master em
	 on em.entity_master_id = erm.entity_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id = v_asset_type_id 
     ) tab ;
     
     
     p_result := 1;     
     
end;

 

$$;


--
