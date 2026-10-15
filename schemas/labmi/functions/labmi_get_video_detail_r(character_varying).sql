-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_video_detail_r(character varying)
-- Type: FUNCTION

-- Name: labmi_get_video_detail_r(character varying); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_video_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb, OUT p_nextprevjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_videoid numeric;
     v_titlealias text := upper(p_titlealias);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_asset_type_id numeric := 4;
     v_lang_master_id numeric;
     v_modifieddate timestamp;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     
begin
	
     
     select video_id 
     into   v_videoid 
     from   labmi.labmi_video
     where  upper(title_alias) = v_titlealias
     and    published_date <= v_sysdate
     and    is_deleted=0
     and 	  is_published=1
     and 	  is_active=1
     and    is_trashed=0;
     
     
     select updated_date ,web_detail_jsn
     into v_modifieddate ,p_videojson
     from labmi.labmi_asset_list
     where asset_id = v_videoid
     and asset_type_id = v_asset_type_id
	and is_published=1
	and is_trashed=0
     and is_active=1
     and is_deleted=0;
     
     /*
     select 	  asset_data
     into strict p_videojson
     from   	  labmi.labmi_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_videoid
	and    	  version_number = v_versionnumber;
    */
    
    p_videojson := jsonb_set(p_videojson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
      select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labmi.labmi_user as u
      join   labmi.labmi_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_videoid
	  ) tab ;
       
     
     /*
     select primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     from labmi.labmi_asset_list 
     where asset_type_id=v_asset_type_id
     and asset_id=v_videoid;
     
     select ae.entity_role_map_id 
      into v_language_id
      from labmi.labmi_asset_entity_map ae
      join labmi.labmi_entity_role_map ar
      on ae.entity_role_map_id=ar.entity_role_map_id
      join labmi.labmi_entity_category ec
      on ar.entity_role_id=ec.entity_role_id
      where asset_type_id=v_asset_type_id
      and asset_id=v_videoid
      and ec.category_name='language';
      */
      select entity_master_id
      into v_lang_master_id
      from labmi.labmi_entity_role_map
      where entity_role_map_id = v_language_id;
     /*
     select s.p_assetjson
     from labmi.labmi_get_asset_related_stories_r(v_videoid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
     into p_nextprevjson;
     */
    
     select ('{ "entities": ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb into p_entjson
     from(
     select aem.entity_role_map_id, 
         coalesce(elm.entity_display_name, 
         em.entity_display_name)ent_display_name,
         -- labmi.labmi_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labmi.labmi_asset_entity_map aem
	join labmi.labmi_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labmi.labmi_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labmi.labmi_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_videoid
     and aem.asset_type_id = v_asset_type_id)row
    ;
     
     
     
     p_result := 1;
     
exception
	
     when others then
     	p_result := -1;
     
end;

 

$$;


--
