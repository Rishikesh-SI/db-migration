-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_video_detail_r(character varying)
-- Type: FUNCTION

-- Name: labuww_get_video_detail_r(character varying); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_video_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
     v_sysdate timestamp := current_timestamp at time zone 'utc';  
     v_logo text;
     v_link text;
     v_cpname text;
     v_lang_id numeric;
	 v_modifieddate timestamp;
	 v_pri_ent_url text;
	v_pri_entity_url_type numeric;
	v_sec_ent_url text;
	v_sec_entity_url_type numeric;
	v_pri_canonical_url text;
	v_sec_canonical_url text;
	v_entity_json jsonb;
	 
begin     
	 
	 select sl.asset_id, sl.published_version_number, 
	 sl.updated_date,sl.web_detail_jsn,sl.language_id
	      /* CP.logo content_provider_logo, 
	 		CP.link content_provider_link,
			CP.content_provider_name
			*/
     into   v_videoid, v_versionnumber, 
	 v_modifieddate,p_videojson,v_lang_id
     from   labuww.labuww_asset_list sl
	 /*left join labuww.labuww_provider_author_map PAM
				on ( sl.author_id = PAM.author_id)
	 left join labuww.labuww_content_provider CP 
				on (PAM.content_provider_id = CP.content_provider_id)
				*/
     where  lower(title_alias) = lower(p_titlealias)
     and    published_date    <= v_sysdate
	 and    asset_type_id = v_asset_type_id
	 and is_published=1;

	p_videojson := jsonb_set(p_videojson, '{data,modified_date}', ('"'||coalesce(v_modifieddate,null)||'"')::text::jsonb, true); 
       
	 select p_videojson->'data'->'entitydata'
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
	join labuww.labuww_entity_role_map a on a.entity_role_map_id=x.entity_role_map_id
	join labuww.labuww_entity_master b on b.entity_master_id=a.entity_master_id
	join labuww.labuww_entity_role c on c.entity_role_id=a.entity_role_id
	join labuww.labuww_entity_type d on d.entity_type_id=c.entity_type_id
		)tab;
		
		
	p_videojson := jsonb_set(p_videojson,'{data,entitydata}',v_entity_json,true);	

 -- raise notice '%',v_videoid;
 -- select 1/0;
       -- p_videojson := jsonb_set(p_videojson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
       -- p_videojson := jsonb_set(p_videojson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
       -- p_videojson := jsonb_set(p_videojson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
         
		 
     select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 into p_authorjson
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labuww.labuww_user as u
      join   labuww.labuww_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = v_asset_type_id
      and    aa.action_id = 4
      and    aa.asset_id = v_videoid
	  ) tab ;
     
      
      select entity_master_id
      into v_lang_master_id
      from labuww.labuww_entity_role_map
      where entity_role_map_id = v_lang_id;
     
     select ('{ "entities": ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb  into p_entjson
     from(
     select aem.entity_role_map_id, 
         coalesce(elm.entity_display_name,
                  em.entity_display_name)ent_display_name,
         -- labuww.labuww_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labuww.labuww_asset_entity_map aem
	join labuww.labuww_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labuww.labuww_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labuww.labuww_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id	 
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_videoid
     and aem.asset_type_id = v_asset_type_id
     )row;
	 
	 /*
	 select b.entity_url as pri_ent_url,d.entity_url_type as pri_entity_url_type,
			b1.entity_url as sec_ent_url,d1.entity_url_type as sec_entity_url_type,
			b.canonical_url as pri_canonical_url ,b1.canonical_url as sec_canonical_url
	into   v_pri_ent_url,v_pri_entity_url_type,	v_sec_ent_url,v_sec_entity_url_type,
		   v_pri_canonical_url,v_sec_canonical_url
	from  labuww.labuww_asset_list sl
	left join labuww.labuww_entity_role_map a on sl.primary_entity_role_map_id = a.entity_role_map_id  
	left join labuww.labuww_entity_master b on a.entity_master_id = b.entity_master_id
	left join labuww.labuww_entity_role c on a.entity_role_id = c.entity_role_id
	left join labuww.labuww_entity_type d on c.entity_type_id = d.entity_type_id
	left join labuww.labuww_entity_role_map a1 on sl.secondary_entity_role_map_id = a1.entity_role_map_id  
	left join labuww.labuww_entity_master b1 on a1.entity_master_id = b1.entity_master_id
	left join labuww.labuww_entity_role c1 on a1.entity_role_id = c1.entity_role_id
	left join labuww.labuww_entity_type d1 on c1.entity_type_id = d1.entity_type_id
	where sl.asset_id = v_videoid and sl.asset_type_id = v_asset_type_id ;
	
	
	p_videojson := jsonb_set(p_videojson, '{data,pri_ent_url}', ('"'||coalesce(v_pri_ent_url,'')||'"')::text::jsonb, true); 
	p_videojson := jsonb_set(p_videojson, '{data,pri_entity_url_type}', ('"'||coalesce(v_pri_entity_url_type,0)||'"')::text::jsonb, true);
	p_videojson := jsonb_set(p_videojson, '{data,sec_ent_url}', ('"'||coalesce(v_sec_ent_url,'')||'"')::text::jsonb, true);
	
	p_videojson := jsonb_set(p_videojson, '{data,sec_entity_url_type}', ('"'||coalesce(v_sec_entity_url_type,0)||'"')::text::jsonb, true); 
	p_videojson := jsonb_set(p_videojson, '{data,pri_canonical_url}', ('"'||coalesce(v_pri_canonical_url,'')||'"')::text::jsonb, true);
	p_videojson := jsonb_set(p_videojson, '{data,sec_canonical_url}', ('"'||coalesce(v_sec_canonical_url,'')||'"')::text::jsonb, true);
	
	 */
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;
$$;


--
