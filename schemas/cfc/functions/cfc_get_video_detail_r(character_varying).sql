-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_get_video_detail_r(character varying)
-- Type: FUNCTION

-- Name: cfc_get_video_detail_r(character varying); Type: FUNCTION; Schema: cfc; Owner: -
--

CREATE FUNCTION cfc.cfc_get_video_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     
begin
	
     /*if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  cfc.cfc_video
          where  	  video_id = p_videoid;
          
          select version_number
          into strict v_versionnumber
          from cfc.cfc_asset_draft ad
          where asset_type_id = 4
          and asset_id = p_videoid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;*/
     
     select video_id, published_version_number
     into   v_videoid, v_versionnumber
     from   cfc.cfc_video
     where  upper(title_alias) = v_titlealias;
     
     select 	  asset_data
     into strict p_videojson
     from   	  cfc.cfc_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_videoid
	and    	  version_number = v_versionnumber;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name user_name
      from   cfc.cfc_user_role as ur
      join   cfc.cfc_user as u
      on     u.user_id = ur.user_id
      join   cfc.cfc_author_action aa
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
      FROM cfc.cfc_ASSET_ENTITY_MAP AE
      JOIN cfc.cfc_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN cfc.cfc_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_videoid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from cfc.cfc_entity_role_map
      where entity_role_map_id = v_language_id;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name,-- cfc.cfc_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from cfc.cfc_asset_entity_map aem
	join cfc.cfc_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join cfc.cfc_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join cfc.cfc_entity_language_map elm
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
