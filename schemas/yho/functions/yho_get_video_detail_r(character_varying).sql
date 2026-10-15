-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_video_detail_r(character varying)
-- Type: FUNCTION

-- Name: yho_get_video_detail_r(character varying); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_video_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     
     v_logo text;
     v_link text;
     v_cpname text;
     
begin     
     
	 select video_id, published_version_number
     into   v_videoid, v_versionnumber
     from   yho.yho_video
     where  upper(title_alias) = v_titlealias;
     
	 raise notice '%, %',v_videoid, v_versionnumber;
	 --select 1/0;
	 
     select 	  asset_data
     into strict p_videojson
     from   	  yho.yho_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_videoid
	and    	  version_number = v_versionnumber;
     
	 select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
      into v_logo,v_link,v_cpname
      from yho.yho_asset_list sl
      inner join yho.yho_provider_author_map PAM
      on ( sl.author_id = PAM.author_id)
      inner join yho.yho_content_provider CP 
      on (PAM.content_provider_id = CP.content_provider_id)
      where sl.asset_id = v_videoid
      and sl.asset_type_id = v_asset_type_id;
        
        p_videojson := jsonb_set(p_videojson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
        p_videojson := jsonb_set(p_videojson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
        p_videojson := jsonb_set(p_videojson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
         
		 
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name user_name
      from   yho.yho_user_role as ur
      join   yho.yho_user as u
      on     u.user_id = ur.user_id
      join   yho.yho_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_videoid) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     v_json1 := substring(v_json1,1,(length(v_json1)-1));
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     SELECT AE.ENTiTY_ROLE_MAP_ID 
      into v_language_id
      FROM yho.yho_ASSET_ENTITY_MAP AE
      JOIN yho.yho_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN yho.yho_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_videoid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from yho.yho_entity_role_map
      where entity_role_map_id = v_language_id;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name,-- 

yho.yho_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from yho.yho_asset_entity_map aem
	join yho.yho_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join yho.yho_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join yho.yho_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_videoid
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
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;

 
$$;


--
