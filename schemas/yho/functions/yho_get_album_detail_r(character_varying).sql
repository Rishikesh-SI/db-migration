-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_album_detail_r(character varying)
-- Type: FUNCTION

-- Name: yho_get_album_detail_r(character varying); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_album_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_albumid numeric;
     v_titlealias text := upper(p_titlealias);
     v_asset_type_id numeric := 2;
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 text := '{"authors":[';
     v_author_count numeric;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_logo text;
     v_link text;
     v_cpname text;
     
begin
	
     select album_id, published_version_number
     into   v_albumid, v_versionnumber
     from   yho.yho_album
     where  upper(title_alias) = v_titlealias;
     
     select 	  asset_data
     into strict p_albumjson
     from   	  yho.yho_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_albumid
	and    	  version_number = v_versionnumber;
         
         select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
      into v_logo,v_link,v_cpname
      from yho.yho_asset_list sl
      inner join yho.yho_provider_author_map PAM
				on ( sl.author_id = PAM.author_id)
			  inner join yho.yho_content_provider CP 
				on (PAM.content_provider_id = CP.content_provider_id)
		where sl.asset_id = v_albumid
        and sl.asset_type_id = v_asset_type_id;
        
        p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
        p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
        p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
        
     
     select ('{"items":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
     from (select asset_order as order_number, image_id, image_file_name, image_path, is_cover,
           		array_to_json(array_agg(em)) entitydata, i.image_caption, i.image_desc,
           		i.title_alias as title_alias, aam.is_active, aam.is_deleted,
           		i.copyright_text
           from yho.yho_album_asset_map aam
           join yho.yho_image i
           on i.image_id = aam.asset_id
           and aam.asset_type_id = 3
           left join yho.yho_asset_entity_map aem
           on aem.asset_id = i.image_id
           and aem.asset_type_id = 3
           left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name, emi.entity_master_id
                      from yho.yho_entity_master emi
                      join yho.yho_entity_role_map erm
                      on erm.entity_master_id = emi.entity_master_id
                      join yho.yho_asset_entity_map aem1
                      on aem1.entity_role_map_id = erm.entity_role_map_id
                      join yho.yho_album_asset_map aam1
                      on aam1.asset_id = aem1.asset_id
                      and aam1.asset_type_id = aem1.asset_type_id
                      and aam1.album_id = v_albumid) as em
           on aem.entity_role_map_id = em.entity_role_map_id
           where album_id = v_albumid
           and aam.is_deleted = 0
		 group by asset_order, image_id, image_file_name, image_path, is_cover, i.image_caption,
           		i.image_desc, i.title_alias, aam.is_active, aam.is_deleted,
           		i.copyright_text
           order by order_number) as row
	into p_imagejson;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.full_name user_name
      from   yho.yho_user_role as ur
      join   yho.yho_user as u
      on     u.user_id = ur.user_id
      join   yho.yho_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 2
      and    aa.action_id = 4
      and    aa.asset_id = v_albumid) as row)
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
      FROM yho.yho_ASSET_ENTITY_MAP AE
      JOIN yho.yho_ENTITY_ROLE_MAP AR
      ON AE.ENTiTY_ROLE_MAP_ID=AR.ENTiTY_ROLE_MAP_ID
      JOIN yho.yho_ENTITY_CATEGORY EC
      ON AR.ENTITY_ROLE_ID=EC.ENTITY_ROLE_ID
      WHERE ASSET_TYPE_ID=v_asset_type_id
      and asset_id=v_albumid
      AND ec.category_name='Language';
      
      select entity_master_id
      into v_lang_master_id
      from yho.yho_entity_role_map
      where entity_role_map_id = v_language_id;
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name,-- yho.yho_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from yho.yho_asset_entity_map aem
	join yho.yho_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join yho.yho_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join yho.yho_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_albumid
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
	when others then
    		p_result := -1;
            p_albumjson := '{"data":null}';
            p_imagejson := '{"items":[]}';
            p_authorjson := '{"authors":[]}';
end;

 

$$;


--
