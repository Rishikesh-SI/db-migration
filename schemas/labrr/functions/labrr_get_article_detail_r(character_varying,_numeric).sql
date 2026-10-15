-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_article_detail_r(character varying, numeric)
-- Type: FUNCTION

-- Name: labrr_get_article_detail_r(character varying, numeric); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_article_detail_r(p_titlealias character varying, p_is_preview numeric, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb, OUT p_entjson jsonb) RETURNS record
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
    v_json1 varchar(30000) ='';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric:=1;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     -- v_json2 varchar(30000) := '{"entities":[';
     v_json2 varchar(30000) ;
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_copyrighttext varchar(4000);
     v_imageid numeric;
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     
     
begin
     
    /* select article_id 
     into   v_articleid
     from   labRR.labRR_article
     where  lower(title_alias) = v_titlealias;
     */
     
     select  asset_id into   v_articleid
     from   labRR.labRR_asset_draft 
     where asset_type_id = 1
     and  lower(asset_data->'data'->>'slug_url') = v_titlealias
     limit 1;
     
     select max(version_number) into v_versionnumber
     from labRR.labRR_asset_draft 
     where asset_id = v_articleid
     and asset_type_id = 1;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labRR.labRR_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = v_articleid
	 and    	  version_number = v_versionnumber;
     
    select  ('['||string_agg((row_to_json(row))::text,',')||']')::json as jsonrow
    from
     (
      select u.user_id, u.full_name ,u.user_name , u.display_name
      from labRR.labRR_user as u     
      join   (select (jsonb_array_elements(a)->>'author_id')::text::numeric author_id , 
              		(jsonb_array_elements(a)->>'action_id')::text::numeric action_id
     		  from (select p_articlejson->'data'->'author_data' as a)c
              ) aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0      
      and    aa.action_id = 4 
     ) as row      
     into v_json1; 
 
     p_authorjson :=  ('{"authors":' || v_json1 || '}' )::jsonb  ;
     
     select p.entity_master_id 
     into v_language_id
     from labRR.labRR_entity_category c 
	 inner join labRR.labRR_entity_role_map p on (c.entity_role_id = p.entity_role_id)      
     where category_name = 'Language'
     and p.entity_role_map_id in (select entity_role_map_id        			
     							from ( select (jsonb_array_elements(a)->>'entity_role_map_id')::text::numeric entity_role_map_id      
            			 				from (select a  from (select p_articlejson->'data'->'entitydata' as a ) b
                  					)c
      							)ab) ;
     
     
     select  ('['||string_agg((row_to_json(row))::text,',')||']')::json as jsonrow     
     from(
     		select aem.entity_role_map_id, 
         			COALESCE(elm.entity_display_name, em.entity_display_name)ent_display_name,
          			em.canonical_url
     		from ( select (jsonb_array_elements(a)->>'entity_role_map_id')::text::numeric entity_role_map_id,      
            			  (jsonb_array_elements(a)->>'is_linkable')::text::numeric is_linkable,
                          (jsonb_array_elements(a)->>'asset_id')::text::numeric asset_id
     			    from (	select a  from (select p_articlejson->'data'->'entitydata' as a ) b
                  )c
          ) aem
	join labRR.labRR_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labRR.labRR_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labRR.labRR_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id 
     and elm.language_master_id =  v_language_id  	
     )row
     into v_json2;
     
     -- raise notice '01 : %' , v_json2;
       
     p_entjson :=  ('{"entities":' || v_json2 || '}' )::jsonb  ;     
    --  raise notice '01 : %' , p_entjson;
      
     p_result := 1 ;
     
end;

$$;


--
