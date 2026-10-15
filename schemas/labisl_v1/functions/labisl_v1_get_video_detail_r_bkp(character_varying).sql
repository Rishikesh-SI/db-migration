-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_get_video_detail_r_bkp(character varying)
-- Type: FUNCTION

-- Name: labisl_v1_get_video_detail_r_bkp(character varying); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_get_video_detail_r_bkp(p_titlealias character varying, OUT p_result numeric, OUT p_videojson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
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
		v_nextprevjson jsonb;
	v_tagged_entitiy numeric[]; 
begin     
	 
	 select sl.asset_id, sl.published_version_number, 
	 sl.updated_date,sl.web_detail_jsn,sl.language_id
     into   v_videoid, v_versionnumber, 
	 v_modifieddate,p_videojson,v_lang_id
     from   labisl_v1.labisl_v1_asset_list sl
     where  lower(title_alias) = lower(p_titlealias)
     and    published_date    <= v_sysdate
	 and    asset_type_id = v_asset_type_id
	 and is_published=1;

	p_videojson := jsonb_set(p_videojson, '{data,modified_date}', ('"'||coalesce(v_modifieddate,null)||'"')::text::jsonb, true); 
       

	 select CP.logo content_provider_logo, CP.link content_provider_link, CP.content_provider_name
		into v_logo, v_link, v_cpname
		from labisl_v1.labisl_v1_asset_list sl
		inner join labisl_v1.labisl_v1_provider_author_map PAM
		on sl.author_id = PAM.author_id
		inner join labisl_v1.labisl_v1_content_provider CP
		on PAM.content_provider_id = CP.content_provider_id
		where sl.asset_id = v_videoid
		and sl.asset_type_id = v_asset_type_id;
       p_videojson := jsonb_set(p_videojson, '{data,content_provider_logo}', ('"'||coalesce(v_logo,'')||'"')::text::jsonb, true); 
       p_videojson := jsonb_set(p_videojson, '{data,content_provider_link}', ('"'||coalesce(v_link,'')||'"')::text::jsonb, true);
       p_videojson := jsonb_set(p_videojson, '{data,content_provider_name}', ('"'||coalesce(v_cpname,'')||'"')::text::jsonb, true);
             
      
	 	 select s.p_assetjson
    from labisl_v1.labisl_v1_get_asset_related_stories_r(v_videoid,v_asset_type_id,v_tagged_entitiy,3) s
    into v_nextprevjson; 
	
	   
	
	
	if v_nextprevjson->'items' is null or (v_nextprevjson->'items')::text = '[]' then
	
	---   raise notice '% v_videoid ',v_nextprevjson->'items';
	
		select s.p_assetjson
    	from labisl_v1.labisl_v1_get_asset_related_stories_r(v_videoid,v_asset_type_id,array[4,1],3) s
    	into v_nextprevjson; 
	
	end if;
	 
	 p_videojson := jsonb_set(p_videojson,'{data,related_data}',v_nextprevjson,true);
	 
     

     
     p_result := 1;
     
-- exception
	
--      when others then
--      	p_result := -1;
     
end;
$$;


--
