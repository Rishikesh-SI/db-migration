-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_page_data_new_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_get_page_data_new_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_page_data_new_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
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
	v_page_required_entity text;
	v_page_required_entity_arr numeric[];
	v_lang_mast_id numeric;
	v_lang_mast_url varchar(4000);
	v_lang_entity_role_id numeric;
	v_page_id_new numeric;
	v_is_amp numeric;
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
      "page_number": 1
    }
  }
}
*/

  
  select p_in_json->'inputs'->>'page_id',
  		 p_in_json->'inputs'->>'is_mobile',
		 p_in_json->'inputs'->>'is_amp',
         p_in_json->'inputs'->'search_key'
  into v_page_id,v_is_mobile,v_is_amp,v_search_json;

    
	select alias,page_id into v_url ,v_page_id_new
	from labsaw.labsaw_page 
	where page_id = v_page_id
		and is_deleted=0
 	and coalesce(is_amp,0)=v_is_amp
	and is_published=1 and is_active=1
  ;
	  p_url := v_url;
	--raise notice '%',v_page_id;
	--select 1/0;
	
     IF  v_page_id_new IS NULL THEN
              select page_id 
                into v_page_id 
              from labsaw.labsaw_page where  v_url   ~ concat('^',alias,'$')
              and alias<>'';
           END IF;
           
    select * into v_count from labsaw.REGEXP_COUNT(p_url, '/');
	 
	v_org_count := v_count;
	
	 ---raise notice '%',v_page_id;
	---select 1/0;
	---raise notice 'v_page_id0 % ' ,  v_page_id;
    IF v_page_id IS NULL THEN
    	
        --- raise notice 'v_page_id1 % ' ,  v_page_id;
         
        v_asset_alias := lower(split_part(p_url, '/', (v_count+1)));
        
        SELECT ASSET_ID, ASSET_TYPE_ID, published_version_number
        INTO   v_asset_id, v_asset_type_id, v_published_version_number
		FROM   labsaw.labsaw_asset_list a
        where  lower(title_alias) = v_asset_alias
        and    asset_type_id not in (14)
		and    is_published = 1;
       
	END IF;
           
         select   entity_role_id
                    from   labsaw.labsaw_entity_category
                  where  category_name = 'Language'
				  into  v_lang_entity_role_id;
           
           
           IF v_page_id IS NULL THEN
              
              v_is_detail:=1;
             ---- RAISE NOTICE 't1 %',v_length;
             
                     select char_length(p_url)-char_length(split_part(p_url, '/', (v_count+1)) || '/') 
                     into v_length;
                     
		       
              ---   RAISE NOTICE 't1 %',v_length;
                 
                 select SUBSTRING(p_url from '^.{'||v_length||'}') into v_url; 
                                              
                 
             if v_url is not null
                 then 
              select * into v_count from labsaw.REGEXP_COUNT(v_url, '/');
              end if;
               v_count:=v_count+1;
               
               v_loop_count:=v_count;
			 
   
               FOR I IN 1..v_count
               LOOP
               
              
						SELECT SUBSTRING(v_url		
                 FROM '^.{'||char_length(v_url)-		
                 char_length(split_part(v_url, '/', (v_loop_count)) || '/')||'}')into v_url;
						
                   select page_id into v_par_page_id from labsaw.labsaw_page
                     where alias=v_url
                     and is_deleted=0
					and is_amp=0;
                     
                  
                 SELECT SUBSTRING(v_url
                 FROM '^.{'||char_length(v_url)-
                 char_length(split_part(v_url, '/', (v_loop_count)) || '/')||'}')into v_url;
                    
                   RAISE NOTICE '%',v_url;
                   RAISE NOTICE '%',v_page_id;
            
                   
                   if v_par_page_id is not null then
                      
                      SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   labsaw.labsaw_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and is_active = 1 
                      and is_deleted = 0
					   and is_amp=0 ;
                      
                      exit;
                   end if;           
                   v_loop_count:=v_loop_count-1;
               
               END LOOP;
              -- end if ;
           END IF;
           
           IF v_page_id IS NULL AND v_asset_id IS NOT NULL THEN
           	raise notice 't3 : % ' ,v_asset_type_id;
              select page_id into v_par_page_id from labsaw.labsaw_page
                     where alias='';
                     
              SELECT PAGE_ID
                      INTO   v_page_id
                      FROM   labsaw.labsaw_PAGE
                      WHERE  PARENT_ID=v_par_page_id
                      AND    ASSET_TYPE_ID=v_asset_type_id
                      and  is_active = 1 
      					and is_deleted = 0
						and is_amp=0;
                      
           ELSIF  v_page_id IS NULL AND v_asset_id IS  NULL THEN
                SELECT labsaw.labsaw_get_new_url(v_asset_alias) INTO v_new_asset_alias;
                
                SELECT ASSET_ID,ASSET_TYPE_ID ,published_version_number
                INTO v_asset_id,v_asset_type_id,v_published_version_number
                
                FROM labsaw.labsaw_asset_list a
                where title_alias=v_new_asset_alias
                and is_published=1;
                
           END IF;
           
           IF v_asset_id IS NOT NULL AND v_asset_type_id IS NOT NULL THEN
            SELECT labsaw.labsaw_check_asset_ent_by_cat('Content Filters',v_asset_id,v_asset_type_id)
            into v_content_filter_exists;
            
              if v_content_filter_exists= 1 then
                  v_show_ads:=0;
              else
                  v_show_ads:=1;
              end if;
             
             select replace(p_url, '/'||split_part(p_url, '/', (v_org_count+1)), '')
             into   v_old_entity_path;
             
             select '/'||split_part(p_url, '/', (1))
             into v_lang_check;
            
             
             select canonical_url
              into  v_lang_canonical_url
              from   labsaw.labsaw_entity_master em
                join   labsaw.labsaw_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
                where erm.entity_role_id = v_lang_entity_role_id
              and canonical_url=v_lang_check;
			  
			   
             if v_lang_canonical_url is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
              	
             end if;
             
             select canonical_url
             into  v_lang_canonical_url_actual
             from   labsaw.labsaw_entity_master
             where  entity_master_id in(select entity_master_id
                                        from   labsaw.labsaw_entity_role_map erm
                                        join   labsaw.labsaw_asset_entity_map aem
                                        on     aem.entity_role_map_id = erm.entity_role_map_id
                                        and    aem.asset_id = v_asset_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        where  entity_role_id = v_lang_entity_role_id );
             
             select  -- replace(lower(em.entity_name),' ','')
           replace(lower(em1.entity_name||'/'||em.entity_name),' ','-')  -- ppp added 
             into   v_new_entity_path
             from   labsaw.labsaw_asset_list al
             join   labsaw.labsaw_entity_role_map erm
             on     erm.entity_role_map_id = secondary_entity_role_map_id
             join   labsaw.labsaw_entity_master em
             on     em.entity_master_id = erm.entity_master_id
             join   labsaw.labsaw_entity_role_map erm1
             on     erm1.entity_role_map_id = primary_entity_role_map_id
             join   labsaw.labsaw_entity_master em1
             on     em1.entity_master_id = erm1.entity_master_id
             where  lower(title_alias) = coalesce(v_new_asset_alias, v_asset_alias);
             
            if ((v_old_entity_path <> v_new_entity_path)
                or (coalesce(v_lang_canonical_url_actual,' ') 
                    <> coalesce(v_lang_canonical_url,' ') )) then
            	
            	v_lang_canonical_url = v_lang_canonical_url_actual;
                
                
            	v_is_redirect := 1;
            end if;
            
              
           END IF;
           
           -- =============================
           select '/'||split_part(lower(p_url), '/', (1))
             into v_lang_check_1;
                          
             
             
			  select erm.entity_role_map_id, em.canonical_url
              	into  v_lang_entity_role_map_id, v_lang_canonical_url_1
                from   labsaw.labsaw_entity_master em
              	join   labsaw.labsaw_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
                where erm.entity_role_id = v_lang_entity_role_id
              	 and canonical_url=v_lang_check_1;
			  
			  
             
             if v_lang_canonical_url_1 is not null then
             
                select replace(v_old_entity_path, split_part(v_old_entity_path, '/', (1))||'/', '')
             	into   v_old_entity_path;
             	
             else
             	
                select erm.entity_role_map_id 
              	into  v_lang_entity_role_map_id
              	from   labsaw.labsaw_entity_master em
              	join   labsaw.labsaw_entity_role_map erm
              	on    erm.entity_master_id = em.entity_master_id
                where erm.entity_role_id = v_lang_entity_role_id
                and canonical_url is null;
             	
             end if;
           -- =============================
           
          -- raise notice '% test11',v_page_id;
            raise notice '% language id ',v_lang_entity_role_map_id;
           --select 1/0;
           
           select t.parent_id into v_template_id
           from labsaw.labsaw_template t where page_id=v_page_id;
           
		          
           select  t.layout_id
           into v_mast_template_id
           from labsaw.labsaw_template t 
           -- join labsaw.labsaw_template tl
           -- on t.template_id=tl.template_id
           where t.template_id=v_template_id;
		   
		   select template_html into v_tem_html from labsaw.labsaw_template
		   where template_id=v_template_id;
           
		   select template_html into v_html from labsaw.labsaw_template
		   where template_id=v_mast_template_id;
           	 
		   raise notice '% tem id % page id % url',v_template_id,v_page_id,coalesce(v_new_asset_alias, v_asset_alias);
            --select 1/0;	
			
			select string_agg(entity_role_map_id::text,',') into v_page_required_entity
					from labsaw.labsaw_asset_entity_map
               		where asset_id = v_page_id
               		and asset_type_id = 11
               		and is_required = 1 ;
			v_page_required_entity_arr:= (string_to_array(v_page_required_entity, ',')::numeric[]);
			 
			 
	   	select row_to_json(row)::jsonb into v_json
     			from (select p.page_id, p.title_app as title,
					  		p.asset_type_id, 
					  		v_lang_entity_role_map_id as language_id, 
                    			sd.meta_info,
					          (case when v_is_mobile=1 then b.mobile_html else b.template_html end ) as html,
					           b.template_id,
					          c.template_html as Masterhtml,
					  		  c.template_id as master_template_id,
					          p.title_app,p.title as title_web,p.title_mobile,
					  (select labsaw.labsaw_get_entity_name(v_lang_entity_role_map_id)) as language_name,
					  p.meta_info as custom_meta_info
						from labsaw.labsaw_page p
     					left join labsaw.labsaw_seo_data sd on sd.asset_id = p.page_id
					     join labsaw.labsaw_template a on a.page_id=p.page_id
					     join labsaw.labsaw_template b on b.template_id=a.parent_id
     					 join labsaw.labsaw_template c on c.template_id=b.layout_id
     					and sd.asset_type_id = 11
     					where p.page_id = v_page_id
					) row
					; 
					
					
 select jsonb_agg(tab) from (
 select  template_component_map_id,template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 parent_tcmap_id,fetch_from,
	 required_entities  ,
	 other_entities  ,
	 exclude_entities ,
	 dependency,
	 (case when component_id=7 then 
 						(select p_assetjson 
						 from labsaw.labsaw_get_asset_listing_r(1, 10,10, 
array_cat(required_entities,v_page_required_entity_arr), null, null, null, exclude_entities))
 		  		 when component_id=1 then
			         (SELECT p_ad_json 
					  from labsaw.labsaw_get_ad_r(null, 1, required_entities, 1))
				 when component_id=4 then
			    (select p_articlejson 
				 from labsaw.labsaw_get_article_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			    when component_id=11 then
				 (select p_videojson 
				  from labsaw.labsaw_get_video_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			     when component_id=5 then
				 (select p_albumjson 
				  from labsaw.labsaw_get_album_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) ) 
			   	when component_id=9 then
	           coalesce(
				   (SELECT p_showcase_json from siwaf._get_showcase_det_r('labsaw', 10702, array[4], null, null, 1, 10, 10, 1)),'[]')
  			when component_id=91 then
			(select * from labsaw.labsaw_get_search_listing_cat_r(v_search_json)) 
			
				end ) as widget_data
	 
	 
		   from (
 select template_component_map_id,template_id,component_id,title,display_title,
 tcmap_guid as selector,
 coalesce(meta_info,'{}') as meta_info,
 coalesce(layout_info,'{}')as layout_info ,
 parent_tcmap_id,fetch_from,
 required_entities,
 other_entities,
 exclude_entities,

 coalesce(  (select array_to_json(array_agg(b)) from (select 
	 template_component_map_id,template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 parent_tcmap_id,fetch_from,
     a.required_entities,
	 a.other_entities,
	 a.exclude_entities,
	 string_to_array('',',')::numeric[] as dependency, 
													  (case when component_id=7 then 
 						(select p_assetjson from labsaw.labsaw_get_asset_listing_r(1, 10,10, required_entities, null, null, null, null))
 		  		 when component_id=1 then
			         (SELECT p_ad_json from labsaw.labsaw_get_ad_r(null, 1, required_entities, 1))
				 when component_id=4 then
			    (select p_articlejson from labsaw.labsaw_get_article_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			    when component_id=11 then
				 (select p_videojson from labsaw.labsaw_get_video_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			     when component_id=5 then
				 (select p_albumjson from labsaw.labsaw_get_album_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) ) 
			   	when component_id=9 then
	            coalesce(
				   (SELECT p_showcase_json from siwaf._get_showcase_det_r('labsaw', 10702, array[4], null, null, 1, 10, 10, 1)),'[]')
  			when component_id=91 then
			(select * from labsaw.labsaw_get_search_listing_cat_r(v_search_json)) 
			
				end ) as widget_data
	 
                                   	from (select ctcm.template_component_map_id ,
											ctcm.display_title as title, ctcm.component_id,
											ctcm.tcmap_guid as selector, ctcm.fetch_from, 
										  coalesce(ctcm.meta_info,'{}') as meta_info,
 										  coalesce(ctcm.layout_info,'{}')as layout_info ,
                                           ctcm.required_entities,
                              				  ctcm.other_entities,
											 ctcm.exclude_entities
                                        		from labsaw.labsaw_template_component_map ctcm
                                                  where ctcm.parent_tcmap_id = tcm.template_component_map_id
                                                  and ctcm.is_active = 1
                              				and ctcm.is_deleted = 0
										  and is_published=1
									) a
													  )b
							)::jsonb,'[]') as dependency
 from labsaw.labsaw_template_component_map tcm
  left join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches(v_tem_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
										) as b
			 
			 ) tab
			 on tab.guid = tcm.tcmap_guid
      where  template_id=v_template_id 
	  and is_deleted=0 and is_active=1 and  is_published=1
	  and tcm.parent_tcmap_id is null
      order by tcm.template_component_map_id
	 )tab1
	 )tab into v_module;
	
	
	
	 select jsonb_agg(tab) from (
 select template_component_map_id,template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 parent_tcmap_id,fetch_from,
	  required_entities,
	  other_entities,
	  exclude_entities,
	 dependency, 
	(case when component_id=7 then 
 						(select p_assetjson from labsaw.labsaw_get_asset_listing_r(1, 10,10, required_entities, null, null, null, null))
 		  		 when component_id=1 then
			         (SELECT p_ad_json from labsaw.labsaw_get_ad_r(null, 1, required_entities, 1))
				 when component_id=4 then
			    (select p_articlejson from labsaw.labsaw_get_article_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			    when component_id=11 then
				 (select p_videojson from labsaw.labsaw_get_video_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			     when component_id=5 then
				 (select p_albumjson from labsaw.labsaw_get_album_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) ) 
			    when component_id=41 then
				 (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], array[4]) )

			      end ) as widget_data
	 
	 
		   from (
 select template_component_map_id,template_id,component_id,title,display_title,
 tcmap_guid as selector,
 fetch_from,
 coalesce(meta_info,'{}') as meta_info,
 coalesce(layout_info,'{}')as layout_info ,		   
 parent_tcmap_id,
 required_entities,
 other_entities,
exclude_entities,

 coalesce(  (select array_to_json(array_agg(b)) from ( select 
	template_component_map_id,template_id,component_id,title,display_title,selector,meta_info,layout_info,
	 parent_tcmap_id,tcm.fetch_from,
	  a.required_entities,
	 a.other_entities,
	 a.exclude_entities,
	 string_to_array('',',')::numeric[] as dependency,
	(case when component_id=7 then 
 						(select p_assetjson from labsaw.labsaw_get_asset_listing_r(1, 10,10, required_entities, null, null, null, null))
 		  		 when component_id=1 then
			         (SELECT p_ad_json from labsaw.labsaw_get_ad_r(null, 1, required_entities, 1))
				 when component_id=4 then
			    (select p_articlejson from labsaw.labsaw_get_article_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			    when component_id=11 then
				 (select p_videojson from labsaw.labsaw_get_video_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) )
			     when component_id=5 then
				 (select p_albumjson from labsaw.labsaw_get_album_detail_r(coalesce(v_new_asset_alias, v_asset_alias)) ) 
			    when component_id=41 then
				 (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], array[4]) )

			      end ) as widget_data
                                   	from (select ctcm.template_component_map_id ,
											ctcm.display_title as title, ctcm.component_id,
											ctcm.tcmap_guid as selector, ctcm.fetch_from, 
										  
										  coalesce(ctcm.meta_info,'{}') as meta_info,
 										  coalesce(ctcm.layout_info,'{}')as layout_info ,	
                                                     ctcm.required_entities,
                              				ctcm.other_entities,
											 ctcm.exclude_entities
                                        		from labsaw.labsaw_template_component_map ctcm
                                                  where ctcm.parent_tcmap_id = tcm.template_component_map_id
                                                  and ctcm.is_active = 1
                              				and ctcm.is_deleted = 0
									) a
													  )b
							)::jsonb,'[]') as dependency
 from labsaw.labsaw_template_component_map tcm
  left join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches(v_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
										) as b
			 ) tab
			 on tab.guid = tcm.tcmap_guid
      where  template_id=v_mast_template_id 
	  and is_deleted=0 and is_active=1
	  and tcm.parent_tcmap_id is null
      order by tcm.template_component_map_id
	 )tab1
	 )tab into v_master_module;
	
	
	
	v_split := '/';
    
	select labsaw.REGEXP_COUNT(lower(p_url), v_split)
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
		
		--raise notice '% % % %  %',v_new_asset_alias,v_is_redirect,v_show_ads,v_new_ent_path,v_json;
		--select 1/0;	 
		v_json:=jsonb_set(v_json,'{module}',coalesce(v_module::jsonb,'[]'), true);
		
		v_json:=jsonb_set(v_json,'{master_module}',coalesce(v_master_module::jsonb,'[]'), true);
		
		
		p_out_json:=v_json;
		 
                                                          
    END;
$_$;


--
