-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_get_album_detail_r(character varying)
-- Type: FUNCTION

-- Name: labrg_get_album_detail_r(character varying); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_get_album_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_albumid numeric;
     v_titlealias text := upper(p_titlealias);
     v_asset_type_id numeric := 2;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
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
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';     
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     p_nextprevjson jsonb;
	 
	  v_logo text;
     v_link text;
     v_cpname text;
     v_entity_json jsonb;
begin

     select album_id, published_version_number, updated_date
     into   strict v_albumid, v_versionnumber, v_modifieddate
     from   labrg.labrg_album
     where  upper(title_alias) = v_titlealias
     and    published_date <= v_sysdate
     and is_deleted=0 and is_published=1 and is_trashed=0 and is_active=1;
     
     select sl.updated_date ,sl.web_detail_jsn,sl.language_id,CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
      
     into v_modifieddate ,p_albumjson,v_language_id, v_logo,v_link,v_cpname
     from labrg.labrg_asset_list sl
	 left join labrg.labrg_provider_author_map PAM
				on ( sl.author_id = PAM.author_id)
			  left join labrg.labrg_content_provider CP 
				on (PAM.content_provider_id = CP.content_provider_id)
     where asset_id = v_albumid
     and asset_type_id = v_asset_type_id
	 and sl.is_published=1
	 and sl.is_trashed=0
      and sl.is_active=1
      and sl.is_deleted=0;    
    
    p_albumjson := jsonb_set(p_albumjson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
	p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
    p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
    p_albumjson := jsonb_set(p_albumjson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
        
     select '{"items":['||string_agg(row_to_json(row)::text,',')||']}'  into p_imagejson
     from
     ( select 
      a.*
     from (
		select asset_order as order_number, image_id, image_file_name, image_path ,is_cover, array_to_json(array_agg(em)) entitydata,
                 i.image_caption, i.image_desc,
	            i.title_alias, aam.is_active,
	    aam.is_deleted, i.copyright_text,
	aam.phototypeid,
	null phototypename
     from   labrg.labrg_album_asset_map aam
     join   labrg.labrg_image i
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	left join   labrg.labrg_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
	left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 from   labrg.labrg_entity_master emi
			join   labrg.labrg_entity_role_map erm
               on     erm.entity_master_id = emi.entity_master_id
                join  labrg.labrg_asset_entity_map aem1
                on    aem1.entity_role_map_id = erm.entity_role_map_id
                 join labrg.labrg_album_asset_map aam1
                 on  aam1.asset_id = aem1.asset_id
                 and  aam1.asset_type_id = aem1.asset_type_id
                 and aam1.album_id =  v_albumid
                ) as em
               on         aem.entity_role_map_id = em.entity_role_map_id
	
     where  album_id = v_albumid
         and aam.is_deleted = 0
		 group by asset_order, image_id, image_file_name, image_path ,is_cover, i.image_caption, i.image_desc
         , i.title_alias, aam.is_active, aam.is_deleted, i.copyright_text,aam.phototypeid
         order by order_number
     
              )a
   order by case when is_cover=1 then 0 else 1 end,order_number
             )
             
             as row
             ;
       select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labrg.labrg_user as u
      join   labrg.labrg_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_albumid
	  ) tab ;
  
      
      select entity_master_id
      into v_lang_master_id
      from labrg.labrg_entity_role_map
      where entity_role_map_id = v_language_id;
      /*
      select primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     from labrg.labrg_asset_list 
     where asset_type_id=v_asset_type_id
     and asset_id=v_albumid;
     
     ------------- changes done by rakesh bhatkar date:-11062017
     
     

     
       select s.p_assetjson
     from labrg.labrg_get_album_related_stories_r(v_albumid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],6) s
    into p_nextprevjson;
     
     
    p_albumjson:=jsonb_set(p_albumjson,'{nextprev}',p_nextprevjson,true);
   ---------------- changes done by rakesh bhatkar date:-11062017
     */
	 
	 
	 select p_albumjson->'data'->'entitydata'
	 into v_entity_json;
	 
	 select jsonb_agg(tab) into v_entity_json from (
		select name,canonical_url as canonical,
		entity_display_name as ent_disp_name,
		x.entity_role_map_id ,
		entity_url,
		c.entity_type_id,
		d.entity_type_name,
		d.entity_url_type,
		x.priority
		from jsonb_to_recordset(v_entity_json)
		as x("name" text, "canonical" text,"ent_disp_name" text,"entity_role_map_id" numeric,"priority" numeric )
		join labrg.labrg_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
		join labrg.labrg_entity_master b on b.entity_master_id=a.entity_master_id
		join labrg.labrg_entity_role c on c.entity_role_id=a.entity_role_id
		join labrg.labrg_entity_type d on d.entity_type_id=c.entity_type_id
			)tab;
			
	  p_albumjson := jsonb_set(p_albumjson,'{data,entitydata}',v_entity_json,true);
    
     select ('{ "entities": ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb  into p_entjson
     from(
     select aem.entity_role_map_id, 
         coalesce(elm.entity_display_name,
                  em.entity_display_name)ent_display_name,
         -- labrg.labrg_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labrg.labrg_asset_entity_map aem
	join labrg.labrg_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labrg.labrg_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labrg.labrg_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_albumid
     and aem.asset_type_id = v_asset_type_id
     )row;

     p_result := 1;
     
exception
	when others then
    		p_result := -1;
            p_imagejson := '{"items":[]}';
            p_authorjson := '{"authors":[]}';
			
end;

 

$$;


--
