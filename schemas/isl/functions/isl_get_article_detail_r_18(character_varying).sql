-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_article_detail_r_18(character varying)
-- Type: FUNCTION

-- Name: isl_get_article_detail_r_18(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_article_detail_r_18(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb, OUT p_inotherlanguages jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

     

  
declare
	
     v_versionnumber numeric;
     v_articleid numeric;
     v_titlealias text := upper(p_titlealias);
     v_image_caption varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 text := '{"authors":[';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric:=1;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 text := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_copyrighttext varchar(4000);
     v_inotherlanguagesjsonarr jsonb[];
     v_inotherlanguagesjson jsonb;
     v_json3 text := '{"other_languages":[';
     v_asset_count numeric;
     v_asset_id numeric;
     
begin
     
     select article_id, published_version_number
     into   v_articleid, v_versionnumber
     from   isl.isl_article
     where  upper(title_alias) = v_titlealias;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  isl.isl_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = v_articleid
	and    	  version_number = v_versionnumber;
     
     begin
     select image_caption
     into strict v_image_caption
     from 	isl.isl_image
     where image_id = (
     select asset_id
     from   isl.isl_article_asset_map
     where  article_id = v_articleid
     and is_cover = 1);
     v_image_caption:=replace(v_image_caption,'"','\"');
     exception
     	when no_data_found then
          	v_image_caption := ' ';
     end;
     
     begin
     select copyright_text
     into   v_copyrighttext
     from   isl.isl_article_asset_map aam
     join   isl.isl_image i
     on     i.image_id = aam.asset_id
     where  article_id = v_articleid
     and    asset_type_id = 3;
     exception
     when no_data_found then
          	v_copyrighttext := ' ';
     end;
     
     p_articlejson := jsonb_set(p_articlejson, '{data,image_caption}', ('"'||v_image_caption||'"')::text::jsonb, true);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (
         select u.user_id, u.full_name user_name
      from  
         isl.isl_user as u
      join   isl.isl_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 1
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid) as row)
     into v_authorjsonarr;
     
     SELECT primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     FROM isl.isl_ASSET_LIST 
     WHERE ASSET_TYPE_ID=v_asset_type_id
     and asset_id=v_articleid;
     
     SELECT AE.ENTiTY_ROLE_MAP_ID 
      into v_language_id
      FROM isl.isl_ASSET_ENTITY_MAP AE
      JOIN isl.isl_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN isl.isl_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_articleid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from isl.isl_entity_role_map
      where entity_role_map_id = v_language_id;
      
     select s.p_assetjson
     from isl.isl_get_asset_related_stories_r(v_articleid,v_asset_type_id,ARRAY[v_primary_ent_id,v_secondary_ent_id,v_language_id],3) s
     into p_nextprevjson;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     SELECT COUNT(1)
     INTO    v_author_count
     FROM    UNNEST(v_authorjsonarr) author_id;
     
     IF v_author_count > 0 THEN
     	v_json1 := substring(v_json1,1,(length(v_json1)-1));
     else
     	V_JSON1:= substring(v_json1,1,(length(v_json1)));
     end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name,-- isl.isl_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from isl.isl_asset_entity_map aem
	join isl.isl_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join isl.isl_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join isl.isl_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_articleid
     and aem.asset_type_id = v_asset_type_id)row)
     into v_entjsonarr;
     
     foreach v_entjson in array v_entjsonarr
     loop
     	v_json2 := v_json2||v_entjson||',';
     end loop;
     
     SELECT COUNT(1)
     INTO    v_ent_count
     FROM    UNNEST(v_entjsonarr) author_id;
     
     IF v_ent_count > 0 THEN
     	v_json2 := substring(v_json2,1,(length(v_json2)-1));
     else
     	V_JSON2:= substring(v_json2,1,(length(v_json2)));
     end if;
     
     v_json2 := v_json2||']}';
     
     p_entjson := v_json2::jsonb;
     
     begin
     	
        select parent_asset_id into v_asset_id from isl.isl_asset_list where asset_id = v_articleid and asset_type_id = v_asset_type_id;
        
        if v_asset_id is null then
        	v_asset_id := v_articleid;
        end if;
        
        select array(
     select row_to_json(row)
     from
     (
         select al1.asset_id, al1.asset_title, al1.title_alias, em.canonical_url lang_url
         from
         (
             select asset_id, asset_type_id
             from isl.isl_asset_list
             where parent_asset_id = v_asset_id
             and asset_type_id = v_asset_type_id
             and asset_id <> v_asset_id
             and is_published = 1
             union
             select asset_id, asset_type_id
             from isl.isl_asset_list
             where asset_id = v_asset_id
             and asset_type_id = v_asset_type_id
             and parent_asset_id is null
             and is_published = 1
         ) al
         join isl.isl_asset_list al1
         on al1.asset_id = al.asset_id
         and al1.asset_type_id = al.asset_type_id
         join isl.isl_asset_entity_map aem
         on aem.asset_id = al1.asset_id
         and aem.asset_type_id = al1.asset_type_id
         join isl.isl_entity_role_map erm
         on aem.entity_role_map_id = erm.entity_role_map_id
         join isl.isl_entity_category ec
         on ec.entity_role_id = erm.entity_role_id
         join isl.isl_entity_master em
         on em.entity_master_id = erm.entity_master_id
         and ec.category_name = 'Language'
     ) row)
    into v_inotherlanguagesjsonarr;
    
    foreach v_inotherlanguagesjson in array v_inotherlanguagesjsonarr
     loop
     	v_json3 := v_json3||v_inotherlanguagesjson||',';
     end loop;
     
     SELECT COUNT(1)
     INTO    v_asset_count
     FROM    UNNEST(v_inotherlanguagesjsonarr) asset_id;
     
     IF v_asset_count > 0 THEN
     	v_json3 := substring(v_json3,1,(length(v_json3)-1));
     else
     	V_JSON3:= substring(v_json3,1,(length(v_json3)));
     end if;
     
     v_json3 := v_json3||']}';
     
     p_inotherlanguages := v_json3::jsonb;
        
     exception
     	when no_data_found then
        	
     end;
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;

     

$$;


--
