-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_article_detail_test(character varying)
-- Type: FUNCTION

-- Name: labisp_get_article_detail_test(character varying); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_article_detail_test(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
     v_versionnumber numeric;
     v_articleid numeric;
     v_titlealias text := lower(p_titlealias);
     v_image_caption varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
    -- v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric:=1;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
   --  v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_copyrighttext varchar(4000);
     v_imageid numeric;
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     v_lang_id numeric;
	 v_related_entcount numeric;
	 v_related_content  jsonb;
	 v_entityrole_mapid numeric[];
     
begin
     
   select asset_id, published_version_number,
	updated_date,web_detail_jsn,language_id,asset_type_id,primary_entity_role_map_id
	into   v_articleid, v_versionnumber, v_modifieddate,p_articlejson,v_lang_id,v_asset_type_id,v_primary_ent_id
     from   labisp.labisp_asset_list
     where  title_alias = v_titlealias 
	 and    asset_type_id in (1,5)
	 and   is_published=1
	    ;
    
	  p_articlejson := jsonb_set(p_articlejson, '{data,modified_date}', ('"'||coalesce(v_modifieddate,null)||'"')::text::jsonb, true); 
       
	 
	select ('{ "authors": ['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb 
	 
	  from (
	   select u.user_id,
        u.full_name ,
         u.user_name ,
         u.display_name
      from   labisp.labisp_user as u
	  where u.user_id in (select  aa.author_id
	  from labisp.labisp_author_action aa
	  where aa.asset_id = v_articleid
	  and    aa.action_id = 4
	   and    aa.asset_type_id in (1,5))
      and  u.is_active = 1
      and    u.is_deleted = 0
      ) tab 
	  into p_authorjson;
	  --using v_articleid;
	 
      
	 
	
      p_nextprevjson:= '{}'::jsonb;
	  

	--execute 
	  select  '['||string_agg(web_listing_json::text,',')||']'
	            from (select web_listing_json 
				from labisp.labisp_asset_list sl
    			where   
				    sl.is_active=1	  
				 and    sl.is_deleted=0
			     and    sl.is_published=1 
				  and  sl.primary_entity_role_map_id= v_primary_ent_id
				  and sl.asset_type_id in (1,5) 
				 and   sl.asset_id <>  v_articleid
			 	  order by sl.published_date desc
				 limit 3) as tab
                       
		into v_related_content; 
		---using v_articleid,v_primary_ent_id; 	   
	 
	  v_related_entcount:=3;
	 /*select p_assetcount,p_assetjson
	 from siwaf.siwaf_related_content_r(1,3,3,array[v_primary_ent_id],null,v_articleid,v_asset_type_id,'labisp')
	 into v_related_entcount,v_related_content;	*/
	 
	 p_nextprevjson := jsonb_set(p_nextprevjson,'{related_content}',v_related_content);
     
     
     p_result := 1;     
     
end;
$$;


--
