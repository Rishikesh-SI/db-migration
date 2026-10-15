-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_get_album_detail_r(character varying, numeric)
-- Type: FUNCTION

-- Name: cli_stp_v1_get_album_detail_r(character varying, numeric); Type: FUNCTION; Schema: cli_stp_v1; Owner: -
--

CREATE FUNCTION cli_stp_v1.cli_stp_v1_get_album_detail_r(p_titlealias character varying, p_is_preview numeric, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_albumid numeric;
     v_titlealias text := lower(p_titlealias);
     v_asset_type_id numeric := 2;    
     v_imagejson jsonb;    
     v_json text ;     
     v_authorjson jsonb;
     v_json1 text ;
     v_author_count numeric;
     v_language_id numeric;  
     v_entjson jsonb;
     v_json2 varchar(30000); 
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';         
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     p_nextprevjson jsonb;
begin

    /* select album_id
     into   strict v_albumid 
     from   cli_stp_v1.cli_stp_v1_album
     where  upper(title_alias) = v_titlealias;
     */
     
     select  asset_id into   v_albumid
     from   cli_stp_v1.cli_stp_v1_asset_draft 
     where asset_type_id = v_asset_type_id
     and  lower(asset_data->'data'->>'slug_url') = v_titlealias
     limit 1;
     
  	 select 	max(version_number)
     into  v_versionnumber
     from   	  cli_stp_v1.cli_stp_v1_asset_draft 
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_albumid ;
     
     select updated_date
     into v_modifieddate
     from cli_stp_v1.cli_stp_v1_asset_list
     where asset_id = v_albumid
     and asset_type_id = 2;
     
     select 	  asset_data
     into strict p_albumjson
     from   	  cli_stp_v1.cli_stp_v1_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = v_albumid
	and    	  version_number = v_versionnumber;
     
     p_albumjson := jsonb_set(p_albumjson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
    
     p_albumjson:=jsonb_set(p_albumjson,'{nextprev}','null',true);
     
   
     	select  ('['||string_agg((row_to_json(row))::text,',')||']')::json as jsonrow
     	from
     	( select order_number, image_id, image_file_name, image_path ,is_cover, entitydata,
         	    image_caption,  coalesce(image_desc,'')image_desc 
         		, title_alias, is_active , 
              	is_deleted,  coalesce(copyright_text,'')  		copyright_text
		  from (
				 select aam.order_number, image_id, image_file_name, image_path ,is_cover, array_to_json(array_agg(em)) entitydata,
         				i.image_caption, 
              			-- i.image_desc,
              				aam.image_desc image_desc , 
              				i.title_alias, coalesce(aam.is_active,0)is_active , 
              			 coalesce(aam.is_deleted,0)is_deleted
              		     -- , i.copyright_text
              				, aam.copyright_text 
     			from   (select (jsonb_array_elements(a)->'data'->>'image_id')::numeric  asset_id , 
              					(jsonb_array_elements(a)->'data'->>'is_cover')::numeric is_cover,
  		 						(jsonb_array_elements(a)->'data'->>'title') title,
  								(jsonb_array_elements(a)->'data'->>'image_desc')image_desc,
                        		(jsonb_array_elements(a)->'data'->>'is_active')::numeric is_active,
                        		(jsonb_array_elements(a)->'data'->>'is_delete')::numeric is_deleted,
                        		(jsonb_array_elements(a)->'data'->>'order_number')::numeric order_number,
                        		(jsonb_array_elements(a)->'data'->>'image_copyright')	copyright_text
     					 from (select p_albumjson->'data'->'images' as a)c
                       ) aam
     			join   cli_stp_v1.cli_stp_v1_image i
     			on     i.image_id = aam.asset_id -- and  aam.asset_type_id = 3
				left join   cli_stp_v1.cli_stp_v1_asset_entity_map aem
         		on aem.asset_id = i.image_id  and aem.asset_type_id = 3
				left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 			from   cli_stp_v1.cli_stp_v1_entity_master emi
							join   cli_stp_v1.cli_stp_v1_entity_role_map erm
               				on     erm.entity_master_id = emi.entity_master_id
                			join  cli_stp_v1.cli_stp_v1_asset_entity_map aem1
                			on    aem1.entity_role_map_id = erm.entity_role_map_id
                 			join cli_stp_v1.cli_stp_v1_album_asset_map aam1
                 			on  aam1.asset_id = aem1.asset_id
                 			and  aam1.asset_type_id = aem1.asset_type_id
                 			and aam1.album_id =  v_albumid
                			) as em
               on         aem.entity_role_map_id = em.entity_role_map_id
     		 
		 	   group by aam.order_number, image_id, image_file_name, image_path ,is_cover, i.image_caption, 
              		-- i.image_desc
              		aam.image_desc
         		, i.title_alias, aam.is_active, aam.is_deleted -- , i.copyright_text
              , aam.copyright_text
         		order by order_number     
              )A
  			 order by case when is_cover =1 then 0 else 1 end,order_number
             ) as row
         into v_json;
         
          p_imagejson := ('{"items": '|| v_json || '}' )::jsonb  ;          
        
        select  ('['||string_agg((row_to_json(row))::text,',')||']')::json as jsonrow
        from
         (
          select u.user_id, u.full_name ,u.user_name , u.display_name
          from cli_stp_v1.cli_stp_v1_user as u     
          join   (select (jsonb_array_elements(a)->>'author_id')::text::numeric author_id , 
                        (jsonb_array_elements(a)->>'action_id')::text::numeric action_id
                  from (select p_albumjson->'data'->'author_data' as a)c
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
     from cli_stp_v1.cli_stp_v1_entity_category c 
	 inner join cli_stp_v1.cli_stp_v1_entity_role_map p on (c.entity_role_id = p.entity_role_id)      
     where category_name = 'Language'
     and p.entity_role_map_id in (select entity_role_map_id        			
     							  from ( select (jsonb_array_elements(a)->>'entity_role_map_id')::text::numeric entity_role_map_id      
            			 				from (select a  from (select p_albumjson->'data'->'entitydata' as a ) b
                  							  )c
      									)ab
                                  ) ;  
                                
                                 
 	
     select  ('['||string_agg((row_to_json(row))::text,',')||']')::json as jsonrow  
     from(
     select aem.entity_role_map_id, 
         COALESCE(elm.entity_display_name,
                  em.entity_display_name)ent_display_name,         
         em.canonical_url
     from ( select (jsonb_array_elements(a)->>'entity_role_map_id')::text::numeric entity_role_map_id,      
            			  (jsonb_array_elements(a)->>'is_linkable')::text::numeric is_linkable,
                          (jsonb_array_elements(a)->>'asset_id')::text::numeric asset_id
     			    from (select a from (select p_albumjson->'data'->'entitydata' as a ) b
                  )c
          ) aem
	join cli_stp_v1.cli_stp_v1_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join cli_stp_v1.cli_stp_v1_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join cli_stp_v1.cli_stp_v1_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_language_id
     )row
     into v_json2;
     	 
     p_entjson :=  ('{"entities":' || v_json2 || '}' )::jsonb  ;     
         
     p_result := 1;    
  
exception
	when others then
    		p_result := -1;
            p_imagejson := '{"items":[]}';
            p_authorjson := '{"authors":[]}';
          
end;

$$;


--
