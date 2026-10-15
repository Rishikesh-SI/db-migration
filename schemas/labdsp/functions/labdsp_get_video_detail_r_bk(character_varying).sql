-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_video_detail_r_bk(character varying)
-- Type: FUNCTION

-- Name: labdsp_get_video_detail_r_bk(character varying); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_video_detail_r_bk(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
          from   	  labdsp.labdsp_video
          where  	  video_id = p_videoid;
          
          select version_number
          into strict v_versionnumber
          from labdsp.labdsp_asset_draft ad
          where asset_type_id = 4
          and asset_id = p_videoid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;*/
     
     select video_id, published_version_number
     into   v_videoid, v_versionnumber
     from   labdsp.labdsp_video
     where  upper(title_alias) = v_titlealias;
     
     select 	  asset_data
     into strict p_videojson
     from   	  labdsp.labdsp_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_videoid
	and    	  version_number = v_versionnumber;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name user_name
      from   labdsp.labdsp_user_role as ur
      join   labdsp.labdsp_user as u
      on     u.user_id = ur.user_id
      join   labdsp.labdsp_author_action aa
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
     
     select ae.entity_role_map_id 
      into v_language_id
      from swa.swa_asset_entity_map ae
      join swa.swa_entity_role_map ar
      on ae.entity_role_map_id=ar.entity_role_map_id
      join swa.swa_entity_category ec
      on ar.entity_role_id=ec.entity_role_id
      where asset_type_id=v_asset_type_id
      and asset_id=v_videoid
      and ec.category_name='language';
      
      select entity_master_id
      into v_lang_master_id
      from labdsp.labdsp_entity_role_map
      where entity_role_map_id = v_language_id;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, coalesce(elm.entity_display_name, em.entity_display_name)ent_display_name,-- labdsp.labdsp_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labdsp.labdsp_asset_entity_map aem
	join labdsp.labdsp_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labdsp.labdsp_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labdsp.labdsp_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_videoid
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
