-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_video_detail_r_test(character varying)
-- Type: FUNCTION

-- Name: isl_get_video_detail_r_test(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_video_detail_r_test(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     v_author_count numeric;
	 v_other_entity numeric[];
	 v_required_entity  numeric[];
	 v_exclude_entity numeric[];
	 v_count numeric;
	 v_related_data  jsonb;
	 v_topic_title text;
     
begin
	
     /*if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  isl.isl_video
          where  	  video_id = p_videoid;
          
          select version_number
          into strict v_versionnumber
          from isl.isl_asset_draft ad
          where asset_type_id = 4
          and asset_id = p_videoid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;*/
     
     select video_id, published_version_number
     into   strict v_videoid, v_versionnumber
     from   isl.isl_video
     where  upper(title_alias) = v_titlealias
     and is_published = 1 and is_trashed = 0;
     
        
     
     select 	  asset_data
     into strict p_videojson
     from   	  isl.isl_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_videoid
	and    	  version_number = v_versionnumber;
     
	/* select array(select entity_role_map_id from isl.isl_asset_entity_map
				 where asset_type_id  = v_asset_type_id
     					and asset_id  = v_videoid and (is_required = 0 or is_required is null)) into v_other_entity;
	 
	  
	 select array(select entity_role_map_id from isl.isl_asset_entity_map
				 where asset_type_id  = v_asset_type_id
     					and asset_id  = v_videoid and is_required = 1) into v_required_entity;
						
	select array(select entity_role_map_id from isl.isl_asset_entity_map
				 where asset_type_id  = v_asset_type_id
     					and asset_id  = v_videoid and is_required = 2) into v_exclude_entity;*/
                        
       select array(select aem.entity_role_map_id
  from isl.isl_asset_entity_map aem
  join isl.isl_entity_role_map erm
  on erm.entity_role_map_id = aem.entity_role_map_id
  and (erm.entity_role_id in(1,2,7) or aem.priority = 1)
  where aem.asset_id = v_videoid
  and aem.asset_type_id = 4)
into v_required_entity;

select array(select aem.entity_role_map_id
  from isl.isl_asset_entity_map aem
  join isl.isl_entity_role_map erm
  on erm.entity_role_map_id = aem.entity_role_map_id
  and erm.entity_role_id in(222,333)
  where aem.asset_id = v_videoid
  and aem.asset_type_id = 4)
into v_other_entity;                  
						
	select * from isl.isl_get_asset_listing_r(1,3,3,v_required_entity,v_other_entity,array[4],null,null)	
	into v_count,v_related_data ;
    

	
	p_videojson := jsonb_set(p_videojson,'{data,related_data}',v_related_data,true);
	p_videojson := jsonb_set(p_videojson,'{data,count}',('"'||v_count::text||'"')::jsonb,true);
	
	
	select asset_meta->>'title' into v_topic_title from isl.isl_template_component_asset_map
	where (asset_meta->>'asset_id')::numeric = v_videoid and (asset_meta->>'content_type')::numeric = 4;
	
	if v_topic_title is not null then 
	
	p_videojson := jsonb_set(p_videojson,'{data,topic_title}',('"'||v_topic_title::text||'"')::jsonb,true);
	
	end if;
	 
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name user_name
      from   isl.isl_user_role as ur
      join   isl.isl_user as u
      on     u.user_id = ur.user_id
      join   isl.isl_author_action aa
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
     
     SELECT AE.ENTiTY_ROLE_MAP_ID 
      into v_language_id
      FROM isl.isl_ASSET_ENTITY_MAP AE
      JOIN isl.isl_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN isl.isl_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_videoid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from isl.isl_entity_role_map
      where entity_role_map_id = v_language_id;
     
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
     
exception
	
    when no_data_found then
    	p_videojson := '{}'::jsonb;
		p_authorjson := '{"authors":[]}'::jsonb;
		p_entjson = '{"entities":[]}'::jsonb;
    	p_result := -1;
     when others then
     	p_result := -1;
     
end;

     

$$;


--
