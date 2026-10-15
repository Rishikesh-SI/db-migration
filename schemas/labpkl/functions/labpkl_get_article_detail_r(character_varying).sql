-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_get_article_detail_r(character varying)
-- Type: FUNCTION

-- Name: labpkl_get_article_detail_r(character varying); Type: FUNCTION; Schema: labpkl; Owner: -
--

CREATE FUNCTION labpkl.labpkl_get_article_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

  
declare
	
     v_versionnumber numeric;
     v_articleid numeric;
     v_titlealias text := lower(p_titlealias);
     v_image_caption varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric:=1;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_copyrighttext varchar(4000);
     v_imageid numeric;
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     
     
begin
     
     select article_id, published_version_number, updated_date
     into   v_articleid, v_versionnumber, v_modifieddate
     from   labpkl.labpkl_article
     where  lower(title_alias) = v_titlealias
     and    published_date <= v_sysdate;
     
     select updated_date
     into v_modifieddate
     from labpkl.labpkl_asset_list
     where asset_id = v_articleid
     and asset_type_id = 1;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labpkl.labpkl_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = v_articleid
	and    	  version_number = v_versionnumber;
     
      with coverimage(t_json)
     as(
         values ((p_articlejson->'data'->>'asset_map')::json)
     )
     select (obj->>'asset_id')
     into   v_imageid
	from   coverimage ci, json_array_elements(ci.t_json#>'{}') obj
	where  (obj->>'is_cover')::numeric = 1;
                                              
                                              begin
     select image_caption
     into strict v_image_caption
     from 	labpkl.labpkl_image
     where image_id = v_imageid;
                                              
     v_image_caption:=replace(v_image_caption,'"','\"');
                                              
     exception
     	when no_data_found then
          	v_image_caption := ' ';
     end;
     
     begin
     select copyright_text
     into   strict v_copyrighttext
     from   labpkl.labpkl_image
     where     image_id = v_imageid;
     exception
     when no_data_found then
          	v_copyrighttext := ' ';
     end;
    
     v_copyrighttext:=replace(v_copyrighttext,'\','\\');                                          
     p_articlejson := jsonb_set(p_articlejson, '{data,image_caption}', ('"'||v_image_caption||'"')::text::jsonb, true);
     p_articlejson := jsonb_set(p_articlejson, '{data,copyright_text}', ('"'||v_copyrighttext||'"')::text::jsonb, true);
     p_articlejson := jsonb_set(p_articlejson,'{data,modified_date}',('"'||v_modifieddate||'"')::text::jsonb);
      -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::text::jsonb);
     select array(
     select row_to_json(row) jsonrow
     from
     (
         select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from  
         -- labpkl.labpkl_user_role as ur
     -- join   
         labpkl.labpkl_user as u
     -- on     u.user_id = ur.user_id
      join   labpkl.labpkl_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 1
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid) as row)
     into v_authorjsonarr;
     
     select primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     from labpkl.labpkl_asset_list 
     where asset_type_id=v_asset_type_id
     and asset_id=v_articleid;
     
     select ae.entity_role_map_id 
      into v_language_id
      from labpkl.labpkl_asset_entity_map ae
      join labpkl.labpkl_entity_role_map ar
      on ae.entity_role_map_id=ar.entity_role_map_id
      join labpkl.labpkl_entity_category ec
      on ar.entity_role_id=ec.entity_role_id
      where asset_type_id=v_asset_type_id
      and asset_id=v_articleid
      and ec.category_name='language';
      
      select entity_master_id
      into v_lang_master_id
      from labpkl.labpkl_entity_role_map
      where entity_role_map_id = v_language_id;
      
     select s.p_assetjson
     from labpkl.labpkl_get_album_related_stories_r(v_articleid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
     into p_nextprevjson;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     select count(1)
     into    v_author_count
     from    unnest(v_authorjsonarr) author_id;
     
     if v_author_count > 0 then
     	v_json1 := substring(v_json1,1,(length(v_json1)-1));
     else
     	v_json1:= substring(v_json1,1,(length(v_json1)));
     end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, coalesce(elm.entity_display_name, em.entity_display_name)ent_display_name,-- labpkl.labpkl_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labpkl.labpkl_asset_entity_map aem
	join labpkl.labpkl_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labpkl.labpkl_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labpkl.labpkl_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id = v_asset_type_id)row)
     into v_entjsonarr;
     
     foreach v_entjson in array v_entjsonarr
     loop
     	v_json2 := v_json2||v_entjson||',';
     end loop;
     
     select count(1)
     into    v_ent_count
     from    unnest(v_entjsonarr) author_id;
     
     if v_ent_count > 0 then
     	v_json2 := substring(v_json2,1,(length(v_json2)-1));
     else
     	v_json2:= substring(v_json2,1,(length(v_json2)));
     end if;
     
     v_json2 := v_json2||']}';
     
     p_entjson := v_json2::jsonb;
     
     
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;

 $$;


--
