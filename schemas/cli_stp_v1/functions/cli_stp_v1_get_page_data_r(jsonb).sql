-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_get_page_data_r(jsonb)
-- Type: FUNCTION

-- Name: cli_stp_v1_get_page_data_r(jsonb); Type: FUNCTION; Schema: cli_stp_v1; Owner: -
--

CREATE FUNCTION cli_stp_v1.cli_stp_v1_get_page_data_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
    v_page_id numeric;
    v_page_asset_type_id numeric:=11;
    v_tc_asset_type_id numeric:=13;
    v_template_id numeric;
    v_mast_template_id numeric;
    v_count int;
    v_loop_count int;
    v_url VARCHAR(10000);
    v_is_detail numeric:=0;
    v_asset_alias varchar(10000);
    v_asset_id numeric;
    v_asset_type_id numeric;
    v_published_version_number numeric;
    -- variables for details
    v_par_page_id numeric;
    v_new_asset_alias varchar(10000);
    v_content_filter_exists numeric;
	-- Declare a cursor variable
    v_show_ads numeric:=1;
    -- changes by rakesh 230317--
    v_split char(1);
    v_slashcount numeric; 
    v_texttobereplaced varchar(4000);
    -- changes by rakesh 230317--3
    v_c_asset_alias varchar(10000);
    v_old_entity_path varchar(1000);
    v_new_entity_path varchar(1000);
    v_is_redirect numeric;
    v_org_count int;
	  v_lang_canonical_url varchar(4000) := '';
      
      v_lang_canonical_url_1 varchar(4000) := '';
      
      v_lang_canonical_url_actual  varchar(4000);
    v_lang_check varchar(2000);
    v_lang_check_1 varchar(2000);
    v_lang_entity_role_map_id numeric;
    v_length numeric;
    v_json jsonb;
	v_template_name text;
	v_html text;
	v_module jsonb;
	v_master_module jsonb;
	v_tem_html text;
	p_url text;
	v_search_json jsonb;
	v_new_asset_alias1 text;
	v_is_redirect1 numeric;
	v_new_ent_path text;
	v_is_mobile numeric;
	v_page_required_entity numeric[];
	v_page_required_entity_arr numeric[];
	v_page_required_ent numeric[];
	v_listing_page_no numeric;
	v_is_amp numeric;
	v_topic_entity numeric;
	v_asset_type_id_1 numeric;
	v_source_object_id text;
	v_entity_role_map_id numeric;
	v_show_content numeric;
	v_show_data numeric;
	v_source_object_details jsonb;
    v_is_regex_page numeric;
	v_asset_type_id_2 character varying;
	
BEGIN
	
	/*
	{
  "inputs": {
    "p_url": "search",
    "is_mobile": null,
    "asset_type_id": null,
    "player_series_id": null,
    "listing_page_no": null,
    "is_amp": 0,
    "search_key": {
      "search_text": "sachin",
      "entity_id": 4,
      "page_number": 1,
	  "is_all":1
    }
  }
}
*/

 -- select 1/0;
  select p_in_json->'inputs'->>'p_url',
  		 p_in_json->'inputs'->>'is_mobile',
         p_in_json->'inputs'->'search_key',
		 p_in_json->'inputs'->>'listing_page_no',
		 p_in_json->'inputs'->>'is_amp',
		 p_in_json->'inputs'->>'topic_entity',
		 p_in_json->'inputs'->>'asset_type_id',
		 p_in_json->'inputs'->>'source_object_id',
         p_in_json->'inputs'->>'is_regex_page'
		 
  into p_url,v_is_mobile,v_search_json,v_listing_page_no,v_is_amp,v_topic_entity,
  	   v_asset_type_id_2 ,v_source_object_id,v_is_regex_page ;
	   
	IF v_asset_type_id_2 = '' OR v_asset_type_id_2 is null then
		v_asset_type_id_1 := null;
	ELSE
		v_asset_type_id_1:=v_asset_type_id_2;
	end if;
  
   if v_asset_type_id_1 is not null and v_source_object_id is not null then
   	
		select a.entity_role_map_id,b.show_content,b.show_data into v_entity_role_map_id,v_show_content,v_show_data  from cli_stp_v1.cli_stp_v1_entity_role_map a
		left join cli_stp_v1.cli_stp_v1_entity_master b on a.entity_master_id = b.entity_master_id
		where a.entity_role_id in (SELECT entity_role_id from cli_stp_v1.cli_stp_v1_asset_type
		where asset_type_id = v_asset_type_id_1) and source_object_id = v_source_object_id ;
		
		
		select row_to_json(row) into v_source_object_details from (select a.entity_role_map_id as source_object_entity_role_map_id,
									  b.entity_display_name as source_object_entity_display_name,
									  b.canonical_url as source_object_entity_canonical_url,
									  b.entity_url as source_object_entity_url
									  from cli_stp_v1.cli_stp_v1_entity_role_map a
									  left join cli_stp_v1.cli_stp_v1_entity_master b on a.entity_master_id = b.entity_master_id
									  where a.entity_role_id in (SELECT entity_role_id from cli_stp_v1.cli_stp_v1_asset_type
																 where asset_type_id = v_asset_type_id_1) and source_object_id = v_source_object_id) row;
		
   
   end if;
   

  
   v_url := p_url;
    raise notice 'url -- %',v_url;
	select page_id into v_page_id 
	from cli_stp_v1.cli_stp_v1_page 
	where alias = v_url
 	and is_deleted=0
  	and coalesce(is_amp,0)=v_is_amp
	and is_published=1 and is_active=1;
	
	
     IF  v_page_id IS NULL THEN
              select page_id ,asset_type_id
              into v_page_id ,v_asset_type_id
              from cli_stp_v1.cli_stp_v1_page where  v_url   ~ concat('^',alias,'$')
              and alias<>''
			  and is_deleted=0
  			  and coalesce(is_amp,0)=v_is_amp
	          and is_published=1 and is_active=1;
     END IF;
	 
	 	    raise notice 'v_count--- % ',v_count;

	
     select * into v_count from cli_stp_v1.REGEXP_COUNT(p_url, '/');
	
	    raise notice 'v_count--- % ',v_count;

	v_org_count := v_count;
	
				IF v_page_id IS NULL OR v_asset_type_id=1 OR v_asset_type_id=2 OR v_asset_type_id=4 THEN 
					
					 
					v_asset_alias := lower(split_part(p_url, '/', (v_count+1)));
						    raise notice 'v_asset_alias--- % ',v_asset_alias;

					SELECT ASSET_ID, ASSET_TYPE_ID, published_version_number
					INTO   v_asset_id, v_asset_type_id, v_published_version_number
					FROM   cli_stp_v1.cli_stp_v1_asset_list a
					where  lower(title_alias) = v_asset_alias
					and    asset_type_id not in (14)
					and    is_published = 1;
					
					if v_asset_id is null then 
					   v_page_id:=null;
					   
					end if;
				   
				END IF;
            
           
           IF v_page_id IS NULL  THEN
              
              		v_is_detail := 1;
                     
                     select char_length(p_url)-char_length(split_part(p_url, '/', (v_count+1)) || '/') 
                     into v_length;

					/*SELECT SUBSTRING(p_url
                 	FROM '^.{'||char_length(p_url)-
                 	char_length(split_part(p_url, '/', (v_count+1)) || '/')||'}')into v_url;*/
                 
               
                 
                 	 select SUBSTRING(p_url from '^.{'||v_length||'}') into v_url; 

					 
					 v_url := split_part(v_url, '/',v_count);
				   raise notice 'v_url--- % ',v_url;

            		 if v_url is not null then 
              		   select * into v_count from cli_stp_v1.REGEXP_COUNT(v_url, '/');
              		 end if;
               
			   				   raise notice 'v_count--- % ',v_count;

			   
			         v_count:=v_count+1;
					 
					   select page_id into v_par_page_id 
					   from cli_stp_v1.cli_stp_v1_page
					   where alias=v_url
					   and is_deleted=0
					   and is_published=1 
					   and is_active=1;
					      
					   
					    SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   cli_stp_v1.cli_stp_v1_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and    is_deleted=0
  					  and    coalesce(is_amp,0)=v_is_amp
	                  and   is_published=1 and is_active=1;
					  
					  
					  
				if  v_page_id is null then	   
                     v_loop_count:=v_count;
               		FOR I IN 1..v_count
               		LOOP
               
                		SELECT SUBSTRING(v_url		
                 		FROM '^.{'||char_length(v_url)-		
                 		char_length(split_part(v_url, '/', (v_loop_count)) || '/')||'}')into v_url;
						
					   select page_id into v_par_page_id 
					   from cli_stp_v1.cli_stp_v1_page
					   where alias = v_url
					   and is_deleted=0
					   and is_published=1 
					   and is_active=1;
					   select rtrim(v_url,split_part(v_url, '/', v_loop_count) || '/') into v_url; 
                   
				   raise notice 'v_url nw--- % ',v_url;
				   
				      if v_par_page_id is not null then
                      
                      SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   cli_stp_v1.cli_stp_v1_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and    is_deleted=0
  					  and    coalesce(is_amp,0)=v_is_amp
	                  and   is_published=1 and is_active=1;
                      
                       exit;
                       end if;           
                     v_loop_count:=v_loop_count-1;
               
                 END LOOP;
             
			 end if; 
           END IF;
           
		  
		   
		   
		  -- raise notice 'v_asset_id % ',v_asset_id;
		   
		  --   raise notice 'v_asset_type_id % ',v_asset_type_id;
		   
		    -- raise notice 'step fin_v_page_id % ',v_page_id;
			
			 
			 
           IF v_page_id IS NULL AND v_asset_id IS NOT NULL THEN
         
              		select page_id into v_par_page_id
			  		from cli_stp_v1.cli_stp_v1_page
                     where alias=''
					 and    is_deleted=0
  					 and   is_published=1 
					 and is_active=1;
                     
					  
          
                      SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   cli_stp_v1.cli_stp_v1_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and  is_active = 1 
      				  and is_deleted = 0
					  and    coalesce(is_amp,0)=v_is_amp;
                      
					
           ELSIF  v_page_id IS NULL AND v_asset_id IS  NULL THEN
		   
                SELECT cli_stp_v1.cli_stp_v1_get_new_url(v_asset_alias) INTO v_new_asset_alias;
                
                SELECT ASSET_ID,ASSET_TYPE_ID ,published_version_number
                INTO v_asset_id,v_asset_type_id,v_published_version_number
                
                FROM cli_stp_v1.cli_stp_v1_asset_list a
                where title_alias=v_new_asset_alias
                and is_published=1;
                
           END IF;
           
           IF v_asset_id IS NOT NULL AND v_asset_type_id IS NOT NULL THEN
		   
            SELECT cli_stp_v1.cli_stp_v1_check_asset_ent_by_cat('Content Filters',v_asset_id,v_asset_type_id)
            into v_content_filter_exists;
            
              if v_content_filter_exists= 1 then
                  v_show_ads:=0;
              else
                  v_show_ads:=1;
              end if;
             
             select replace(p_url, '/'||split_part(p_url, '/', (v_org_count+1)), '')
             into   v_old_entity_path;
             
            
			 select split_part(p_url, '/', (1))
             into v_lang_check;
            
             
             select canonical_url
              into  v_lang_canonical_url
              from   cli_stp_v1.cli_stp_v1_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   cli_stp_v1.cli_stp_v1_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   cli_stp_v1.cli_stp_v1_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check;
             
             if v_lang_canonical_url is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
              	
             end if;
             
             select canonical_url
             into  v_lang_canonical_url_actual
             from   cli_stp_v1.cli_stp_v1_entity_master
             where  entity_master_id in(select entity_master_id
                                        from   cli_stp_v1.cli_stp_v1_entity_role_map erm
                                        join   cli_stp_v1.cli_stp_v1_asset_entity_map aem
                                        on     aem.entity_role_map_id = erm.entity_role_map_id
                                        and    aem.asset_id = v_asset_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        where  entity_role_id = (select entity_role_id
                                                                 from   cli_stp_v1.cli_stp_v1_entity_category
                                                                 where  category_name = 'Language'));
             
             select em.canonical_url into v_new_entity_path
             from   cli_stp_v1.cli_stp_v1_asset_list al
             join   cli_stp_v1.cli_stp_v1_entity_role_map erm
             on     erm.entity_role_map_id = secondary_entity_role_map_id
             join   cli_stp_v1.cli_stp_v1_entity_master em
             on     em.entity_master_id = erm.entity_master_id
             join   cli_stp_v1.cli_stp_v1_entity_role_map erm1
             on     erm1.entity_role_map_id = primary_entity_role_map_id
             join   cli_stp_v1.cli_stp_v1_entity_master em1
             on     em1.entity_master_id = erm1.entity_master_id
             where  lower(title_alias) = coalesce(v_new_asset_alias, v_asset_alias);
         
            if ((v_old_entity_path <> v_new_entity_path)
               or (coalesce(v_lang_canonical_url_actual,' ')  <> coalesce(v_lang_canonical_url,' ') )
					) then
            	
				--raise notice 'v_old_entity_path=%',v_old_entity_path;
				--raise notice 'v_new_entity_path=%',v_new_entity_path;
				--raise notice 'v_lang_canonical_url_actual=%',v_lang_canonical_url_actual;
				--raise notice 'v_lang_canonical_url=%',v_lang_canonical_url;
				
            	v_lang_canonical_url = v_lang_canonical_url_actual;
                
                
            	v_is_redirect := 1;
				
				
            end if;
            
              
           END IF;
           
             select '/'||split_part(lower(p_url), '/', (1))
             into v_lang_check_1;
                          
             
             select canonical_url
              into  v_lang_canonical_url_1
              from   cli_stp_v1.cli_stp_v1_entity_master
              where  entity_master_id in(select entity_master_id
                                           from   cli_stp_v1.cli_stp_v1_entity_role_map
                                           where  entity_role_id = (select entity_role_id
                                                                    from   cli_stp_v1.cli_stp_v1_entity_category
                                                                    where  category_name = 'Language'))
              and canonical_url=v_lang_check_1;
             
             if v_lang_canonical_url_1 is not null then
                   
				 
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
             	
                select erm.entity_role_map_id, em.canonical_url
              	into  v_lang_entity_role_map_id
              	from   cli_stp_v1.cli_stp_v1_entity_master em
              	join   cli_stp_v1.cli_stp_v1_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  cli_stp_v1.cli_stp_v1_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url=v_lang_canonical_url_1;
              	
             else
             	
                select erm.entity_role_map_id 
              	into  v_lang_entity_role_map_id
              	from   cli_stp_v1.cli_stp_v1_entity_master em
              	join   cli_stp_v1.cli_stp_v1_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
              	join  cli_stp_v1.cli_stp_v1_entity_category ec
              	on ec.entity_role_id = erm.entity_role_id
              	and  ec.category_name = 'Language'
              	and canonical_url is null;
             	
             end if;
         
           raise notice '% page_id -- ',v_page_id;
           select t.parent_id into v_template_id
           from cli_stp_v1.cli_stp_v1_template t where page_id=v_page_id;
           
		  
		          
           select  t.layout_id
           into v_mast_template_id
           from cli_stp_v1.cli_stp_v1_template t 
           where t.template_id=v_template_id;
		   
		    
		   
		   select template_html into v_tem_html from cli_stp_v1.cli_stp_v1_template
		   where template_id=v_template_id;
           
		   select template_html into v_html from cli_stp_v1.cli_stp_v1_template
		   where template_id=v_mast_template_id;
           
			select array_agg(entity_role_map_id) into v_page_required_entity
					from cli_stp_v1.cli_stp_v1_asset_entity_map
               		where asset_id = v_page_id
               		and asset_type_id = 11
               		and is_required = 1 ;
					
					select array_agg(entity_role_map_id)  into v_page_required_ent
					from cli_stp_v1.cli_stp_v1_asset_entity_map
               		where asset_id = v_page_id
               		and asset_type_id = 11;
		
			
			
			
			 
	   	select row_to_json(row)::jsonb into v_json
     			from (select p.page_id, p.title_app as title,
					  		p.asset_type_id, 
					  		v_lang_entity_role_map_id as language_id, 
					          v_page_required_ent as page_entity,
                    			sd.meta_info,
					          (case when b.is_responsive =  1 then b.template_html
							   when v_is_mobile=1 then b.mobile_html else b.template_html end ) as html,
					           b.template_id,
					          c.template_html as Masterhtml,
					  		  c.template_id as master_template_id,
					          p.title_app,p.title as title_web,p.title_mobile,
					  (select cli_stp_v1.cli_stp_v1_get_entity_name(v_lang_entity_role_map_id)) as language_name,
					  p.meta_info as custom_meta_info,
					  (select jsonb_agg(tab) from (
						select entity_name,a.entity_role_map_id as entity_id,is_required,null as entity_ordering_id,
 					source_object_id,tour_id,canonical_url,entity_url,
					e.entity_type_id,entity_type_name
					from cli_stp_v1.cli_stp_v1_asset_entity_map a
					join cli_stp_v1.cli_stp_v1_entity_role_map b on  b.entity_role_map_id=a.entity_role_map_id
					join cli_stp_v1.cli_stp_v1_entity_master c on b.entity_master_id=c.entity_master_id
					join cli_stp_v1.cli_stp_v1_entity_role d on b.entity_role_id=d.entity_role_id
					join cli_stp_v1.cli_stp_v1_entity_type e on e.entity_type_id=d.entity_type_id	  
               		where asset_id = v_page_id
               		and asset_type_id = 11)tab) as required_entities
               	 
						from cli_stp_v1.cli_stp_v1_page p
     				left outer join cli_stp_v1.cli_stp_v1_seo_data sd on sd.asset_id = p.page_id
					     join cli_stp_v1.cli_stp_v1_template a on a.page_id=p.page_id
					     join cli_stp_v1.cli_stp_v1_template b on b.template_id=a.parent_id
     					 join cli_stp_v1.cli_stp_v1_template c on c.template_id=b.layout_id
     					and sd.asset_type_id = 11
     					where p.page_id = v_page_id
					) row
					;
					
		raise notice '%',v_page_id;			
								
 select jsonb_agg(tab) from (
 				select  template_component_map_id,
	 					template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 					parent_tcmap_id,fetch_from,
	 					 required_entities,
	 					 other_entities,
	 					 exclude_entities,
	 					dependency,
	 					
	 					(case when component_id=7 and v_is_regex_page = 1 then  
	  					(
						  
						select p_assetjson from cli_stp_v1.cli_stp_v1_get_asset_listing_r(coalesce(v_listing_page_no,1), web_item_number,web_item_number,case when v_entity_role_map_id is not null
																				  	and fetch_from_source_object_id = 1
																				  then array_append(required_entities,v_entity_role_map_id) 
		else required_entities end, other_entities, null, null, exclude_entities)
						) 
						 when component_id=432 then  
	  					(
						
						select p_press_release_json from cli_stp_v1.cli_stp_v1_get_press_realease_listing_r(coalesce(v_listing_page_no,1),10,10, required_entities, null, null, null)
						) 
						 when (component_id=4 or component_id=506 )then
			      				(select p_articlejson from cli_stp_v1.cli_stp_v1_get_article_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			    		 when (component_id=11 or component_id=507) then
								(select p_videojson  from cli_stp_v1.cli_stp_v1_get_video_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			     		 when (component_id=5 or component_id=508) then
				 				(select p_albumjson from cli_stp_v1.cli_stp_v1_get_album_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) ) 
			   			when component_id=91 then
						(select * from cli_stp_v1.cli_stp_v1_get_asset_listing_by_cat_r(v_search_json,web_item_number)) 
			
	  					when component_id=512 then
						(select p_content_json from siwaf._get_cont_listing_by_entity_r('cli_stp_v1',coalesce(v_listing_page_no,1),web_item_number,web_item_number,v_topic_entity,4,null)) 
						/*
						when component_id=1 then
						(select p_ad_json from cli_stp_v1.cli_stp_v1_get_ad_detail(,null))
						 */
						 when component_id = 9 and v_is_regex_page = 1 then
						 (
						SELECT p_showcase_json from cli_stp_v1.cli_stp_v1_get_showcase_det_r('cli_stp_v1' ,template_component_map_id, 
																					 case when v_entity_role_map_id is not null
																					 and fetch_from_source_object_id = 1 then required_entities||array_append(required_entities_1,v_entity_role_map_id) 
																					 else required_entities end, 
																					 other_entities, exclude_entities, coalesce(v_listing_page_no,1), 
																					 web_item_number, web_item_number, is_fall_back))
						 else
	 					 widget_data end ) as widget_data,
	 						
	 		coalesce (show_in_mobile,1) as show_in_mobile,
			coalesce(show_in_app,1) as show_in_app,
			coalesce(show_in_web,1) as show_in_web,
	        v_entity_role_map_id as entity_id_of_source_object,
	        required_entities_1
	 
		   from (
 				select 	tcm.template_component_map_id,
						 tcm.template_id,tcm.component_id,
						 tcm.title,
						 tcm.display_title,
 					   	 tcm.tcmap_guid as selector,
						 coalesce(tcm.meta_info,'{}') as meta_info,
						 coalesce(tcm.layout_info,'{}')as layout_info ,
						 tcm.parent_tcmap_id,
						 tcm.fetch_from,
			   			case when tcm.fetch_from = 1 then ARRAY(SELECT DISTINCT UNNEST(tcd.page_req_entity)) end as required_entities_1,  
					   req_entity as required_entities,
						-- req_entity as required_entities,
						 other_entity as other_entities,
						 exclude_entity as exclude_entities,
 						 (tcm.meta_info->>'fb')::numeric as is_fall_back, 
	   					 (tcm.meta_info->>'lg_row')::numeric as web_item_number ,
	   					 (tcm.meta_info->>'sm_row')::numeric as mobile_item_number,
						 (tcm.meta_info->>'loadmore_type')::text as loadmore_type,
			   			 (tcm.meta_info->>'fetch_from_source_object_id')::numeric as fetch_from_source_object_id,
							tcm.show_in_mobile,
							tcm.show_in_app,
							tcm.show_in_web	,																   
 							tcd.widget_data,															   
 										coalesce(  (select array_to_json(array_agg(b)) from (select 
	 													template_component_map_id,
														template_id,component_id,title,display_title,
														selector, 
														coalesce(meta_info,'{}') as meta_info,
														 coalesce(layout_info,'{}')as layout_info ,
															 parent_tcmap_id,fetch_from,
															  required_entities,
	 																	other_entities,
	 					 									exclude_entities,
															 string_to_array('',',')::numeric[] as dependency, 
																  widget_data,
																							 
													coalesce (show_in_mobile,1) as show_in_mobile,
													coalesce(show_in_app,1) as show_in_app,
													coalesce(show_in_web,1) as show_in_web
                                   	   from (select ctcm.template_component_map_id ,
											ctcm.display_title as title, ctcm.component_id,
											ctcm.tcmap_guid as selector, ctcm.fetch_from, 
										    show_in_mobile,
											show_in_app,
											show_in_web,
											req_entity as required_entities,
	 										other_entity as other_entities,
	 					                    exclude_entity as exclude_entities, 
										  	coalesce(ctcm.meta_info,'{}') as meta_info,
 										  	coalesce(ctcm.layout_info,'{}')as layout_info ,
                                             tcd.widget_data         
                                        		from cli_stp_v1.cli_stp_v1_template_component_map ctcm
											 inner join (select template_component_map_id,
														 req_entity,other_entity,exclude_entity ,
														 widget_data,
														 component_id
											 from cli_stp_v1.cli_stp_v1_template_component_data tcd 
											 where tcd.template_id=v_template_id and page_id=v_page_id
												and  tcd.parent_tcmap_id is not null) tcd
 											on tcd.template_component_map_id=ctcm.template_component_map_id	
											and tcd.component_id=ctcm.component_id   
											 where ctcm.parent_tcmap_id = tcm.template_component_map_id
                                             and ctcm.is_active = 1
                              				and ctcm.is_deleted = 0
										  and is_published=1
									) a
													  )b
							    )::jsonb,'[]') as dependency
			   
 from cli_stp_v1.cli_stp_v1_template_component_map tcm
 inner join (select template_component_map_id,req_entity,other_entity,exclude_entity ,widget_data,component_id,page_req_entity
			 from cli_stp_v1.cli_stp_v1_template_component_data tcd 
			 where tcd.template_id=v_template_id and page_id=v_page_id
			and  tcd.parent_tcmap_id is null) tcd
 on tcd.template_component_map_id=tcm.template_component_map_id	
	and tcd.component_id=tcm.component_id	
 /*left join (select a[1] as guid, row_number() over() as slno
 from (select regexp_matches(v_tem_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
      ) as b ) tab
			 on tab.guid = tcm.tcmap_guid*/
      where  tcm.template_id=v_template_id
	  and tcm.is_deleted=0 and tcm.is_active=1 and  tcm.is_published=1
	  and tcm.parent_tcmap_id is null
	  and (case when v_is_mobile = 1 then tcm.show_in_mobile = 1
	   when (v_is_mobile is null or v_is_mobile = 0) then tcm.show_in_web = 1 end)		   
	  --and tcm.show_in_mobile=v_is_mobile		   
      order by tcm.template_component_map_id
	 )tab1
	 )tab into v_module;
	
	
	
	raise notice 'v_page_required_entity=%',v_page_required_entity;
	
	 select jsonb_agg(tab) from (
 select template_component_map_id,
		 template_id,component_id,
		 title,display_title,selector,
		 meta_info,
		 layout_info,
	 parent_tcmap_id,fetch_from,
	 required_entities,
	 other_entities,
	 exclude_entities,
	 dependency, 
	(case when component_id=41 then
				 (SELECT * from cli_stp_v1.cli_stp_v1_get_navigation_r(0, array[template_component_map_id], v_page_required_entity) )
				when component_id=232 then 
	                 (select ('{"items":'||jsonb_agg(tab1 order by level)::text||'}')::jsonb from (	
						with hirarchy_cte (branch1) as(	
						SELECT string_to_array(branch,',')::numeric[] as branch1
						FROM connectby('cli_stp_v1.cli_stp_v1_page', 'page_id', 'parent_id', 'page_id', '0', 0,',') 
						AS t(page_id numeric, parent_id numeric, level int, branch text, ord int)
						where page_id=v_page_id	
					  ) select tab.*,p.title,p.alias from (SELECT page_id,level
						FROM connectby('cli_stp_v1.cli_stp_v1_page', 'page_id', 'parent_id', 'page_id', '0', 0,',') 
						AS t(page_id numeric, parent_id numeric, level int, branch text, ord int))tab 
						join hirarchy_cte on tab.page_id = any(branch1)
						join cli_stp_v1.cli_stp_v1_page p on p.page_id=tab.page_id
						 and is_active=1 and is_deleted=0 
						)tab1) 
					when component_id=1 then  
				 (select p_ad_json from cli_stp_v1.cli_stp_v1_get_ad_r(null, 1,required_entities, 1,fetch_from,v_page_required_entity)) 
	               else widget_data 
			      end ) as widget_data,
		 coalesce (show_in_mobile,1) as show_in_mobile,
			coalesce(show_in_app,1) as show_in_app,
			coalesce(show_in_web,1) as show_in_web
		   from (
 select tcm.template_component_map_id,tcm.template_id,tcm.component_id,title,display_title,
 tcm.tcmap_guid as selector,
 tcm.fetch_from,
 coalesce(tcm.meta_info,'{}') as meta_info,
 coalesce(layout_info,'{}')as layout_info ,		   
 tcm.parent_tcmap_id,
 req_entity as required_entities,
 other_entity as other_entities,
 exclude_entity as exclude_entities,			   
		show_in_mobile,
		show_in_app,
		show_in_web,
			   tcd.widget_data,
 coalesce(  (select array_to_json(array_agg(b)) from ( select 
	template_component_map_id,template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 parent_tcmap_id,tcm.fetch_from,
	 required_entities,
	 other_entities,
	 exclude_entities,
	 string_to_array('',',')::numeric[] as dependency,
	    coalesce (show_in_mobile,1) as show_in_mobile,
			coalesce(show_in_app,1) as show_in_app,
			coalesce(show_in_web,1) as show_in_web,												  
	        widget_data
          from (select ctcm.template_component_map_id ,
											ctcm.display_title as title, ctcm.component_id,
											ctcm.tcmap_guid as selector, ctcm.fetch_from, 
										   coalesce (show_in_mobile,1) as show_in_mobile,
										coalesce(show_in_app,1) as show_in_app,
										coalesce(show_in_web,1) as show_in_web,
										  coalesce(ctcm.meta_info,'{}') as meta_info,
 										  coalesce(ctcm.layout_info,'{}')as layout_info ,	
                                               tcd.req_entity as required_entities,
	 										   tcd.other_entity as other_entities,
	 					                       tcd.exclude_entity  as exclude_entities,
												'[]'as dependency,
												tcd.widget_data
                                        		from cli_stp_v1.cli_stp_v1_template_component_map ctcm
												inner join (select template_component_map_id,req_entity,
															other_entity,exclude_entity ,widget_data,component_id
															from cli_stp_v1.cli_stp_v1_template_component_data tcd 
			 									where tcd.template_id=v_mast_template_id ) tcd 
												on tcd.template_component_map_id=ctcm.template_component_map_id 
											and tcd.component_id=ctcm.component_id	
                                                  where ctcm.parent_tcmap_id = tcm.template_component_map_id
                                                  and ctcm.is_active = 1
                              				and ctcm.is_deleted = 0
									) a
													  )b
							)::jsonb,'[]') as dependency
 from cli_stp_v1.cli_stp_v1_template_component_map tcm
 inner join (select template_component_map_id,req_entity,other_entity,exclude_entity ,widget_data,component_id
			 from cli_stp_v1.cli_stp_v1_template_component_data tcd 
			 where tcd.template_id=v_mast_template_id) tcd
 on tcd.template_component_map_id=tcm.template_component_map_id	
	and tcd.component_id=tcm.component_id			   
 /* left join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches(v_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
										) as b
			 ) tab
			 on tab.guid = tcm.tcmap_guid*/
      where  template_id=v_mast_template_id
	  and is_deleted=0 and is_active=1
	  and tcm.parent_tcmap_id is null
      order by tcm.template_component_map_id
	 )tab1
	 )tab into v_master_module;
	
	
	
	
	
	v_split := '/';
    
	select cli_stp_v1.REGEXP_COUNT(lower(p_url), v_split)
    into v_slashcount;
	
	    select split_part(lower(p_url::text),v_split::text,(v_slashcount+1)::int)
      into v_texttobereplaced;
	  
	   v_new_asset_alias := replace(lower(p_url),v_texttobereplaced,v_new_asset_alias);
	  
	  
	  
	   SELECT  case when (v_is_redirect = 1 and v_new_asset_alias is null)
	        then v_asset_alias else v_new_asset_alias end AS new_asset_alias,
      		 case when v_new_asset_alias is not null then 1
      	   	 	  when v_is_redirect = 1 then 1
      		 	  else 0
			 end as is_redirect,
            v_show_ads as show_ads,
            
             case when v_is_redirect = 1 then
             	  	
                 case when(v_lang_canonical_url is null) then v_new_entity_path
                 else replace(v_lang_canonical_url,'/','')||'/'||v_new_entity_path
                 end
             	  else null
			 end as new_ent_path
			 into v_new_asset_alias,v_is_redirect,v_show_ads,v_new_ent_path
			 ;
			 
		if v_json is null then
		v_json:='{}';
		end if;
			 
           
		v_json:=jsonb_set(v_json,'{redirecturl}',('"'||coalesce(v_new_asset_alias,'')||'"')::text::jsonb, true); 
		v_json:=jsonb_set(v_json,'{redirectparent}',('"'||coalesce(v_new_ent_path,'')||'"')::text::jsonb, true); 
		v_json:=jsonb_set(v_json,'{isredirect}',('"'||v_is_redirect||'"')::text::jsonb, true); 
		v_json:=jsonb_set(v_json,'{show_content}',coalesce(v_show_content,0)::text::jsonb, true); 
		v_json:=jsonb_set(v_json,'{show_data}',coalesce(v_show_data,0)::text::jsonb, true); 
		
		v_json:=jsonb_set(v_json,'{source_object_details}',coalesce(v_source_object_details,'{}')::text::jsonb, true); 
	
		v_json:=jsonb_set(v_json,'{module}',coalesce(v_module::jsonb,'[]'), true);
		
		v_json:=jsonb_set(v_json,'{master_module}',coalesce(v_master_module::jsonb,'[]'), true);
		
		
		p_out_json:=v_json;
		
		/* if v_asset_type_id_1 is not null and v_source_object_id is not null and v_entity_role_map_id is null then
   	p_out_json :=  null;
       
   end if;
		  */
		                                                  
    END;
$_$;


--
