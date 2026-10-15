-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_get_video_listing_backup_18022017(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labgmr_get_video_listing_backup_18022017(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labgmr; Owner: -
--

CREATE FUNCTION labgmr.labgmr_get_video_listing_backup_18022017(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_videocount numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    v_createdbyquery varchar(50) := ' ';
    v_searchkeyword varchar(4000) := upper(p_searchkeyword);
    v_searchdraftquery varchar(200) := ' ';
    v_searchvideoquery varchar(200) := ' ';
	  v_drafvideocount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias json;
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_videocount numeric := 0;
	  v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_videojsonarr jsonb[];
    v_videojson jsonb;
    v_json varchar(30000) := '{"items":[';
    v_video_count numeric:=0;
    v_asset_type_id numeric:=4;
begin
    
    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if p_authorid is not null then
    		
          v_createdbyquery := ' and a.created_by = $1 ';
          
    end if;
    
    if p_searchkeyword is not null then
    		
          v_searchdraftquery   := ' and upper(a.asset_data->'||''''||'data'||'''->>'||''''||'title_alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchvideoquery := ' and upper(title_alias) like ''%''||'||'$2'||'||''%'' ';
          
    end if;
    
    create temp table if not exists v_videojsondata
    (
        video_id numeric,
        title_alias jsonb,
        video_guid jsonb,
        status varchar(256),
        entity_id numeric,
        created_date timestamp,
        modified_date timestamp,
        version_number numeric
    );
    
    if  p_status = 0 then                                           
           
             execute '     select count(1)
                 from   labgmr.labgmr_asset_draft as a
                 join	(
                     select * from (
                        select 
                         a1.video_id,published_version_number
                        from labgmr.labgmr_video a1
                        where (is_published=0 and is_trashed=0)
                        or	  exists (select 1 from swa.swa_asset_draft ad1
                                      where ad1.asset_type_id=' || v_asset_type_id ||' and ad1.asset_id=a1.video_id
                                      and	ad1.version_number>a1.published_version_number)) all_ar
                 )		all_a
                 on 	a.asset_id=all_a.video_id
            	 where  a.asset_type_id  = ' || v_asset_type_id ||'
                 and    a.version_number = (select max(a1.version_number)
                 							 from labgmr.labgmr_asset_draft as a1
                        	                 where  a1.asset_id = a.asset_id)  '                              
    			 ||v_createdbyquery
                ||v_searchdraftquery
    			 into   v_drafvideocount
    			 using  p_authorid, v_searchkeyword;

    			 execute 'select array(
                    select asset_draft_id from (
                          select asset_draft_id, row_number() over(order by a.updated_date desc) as slno
                                 from   labgmr.labgmr_asset_draft as a
                                     join	(
                                           select * from (
                                              select  a.updated_date , 
                                               a.video_id,published_version_number
                                              from labgmr.labgmr_video a
                                              where (is_published=0 and is_trashed=0)
                                              or	  exists (select 1 from swa.swa_asset_draft ad
                                                            where ad.asset_type_id= ' || v_asset_type_id ||' 
                                                            and ad.asset_id=a.video_id
                                                            and	ad.version_number>a.published_version_number)) all_ar
                                       )		all_a
                                       on 	a.asset_id=all_a.video_id
                                     where  a.asset_type_id  =  ' || v_asset_type_id ||' 
                                       and    a.version_number = (select max(a1.version_number)
                                                     from labgmr.labgmr_asset_draft as a1
                                                                 where  a1.asset_id = a.asset_id
                                                                 and a1.asset_type_id  =  ' || v_asset_type_id ||' )'
           ||v_createdbyquery
                ||v_searchdraftquery
                ||
                 ' ) top_a
    			where slno between $3 and $4
          )'
    			 into   v_assetdraftidarr
    			 using  p_authorid, v_searchkeyword,v_fromrownumber, v_torownumber;
        
        foreach v_assetdraftid in array v_assetdraftidarr
        loop
        	
          select asset_data->'data'->'title_alias'::varchar(100), asset_data->'data'->>'entitydata'
          into   v_titlealias, v_entityjson
          from   labgmr.labgmr_asset_draft
          where  asset_draft_id = v_assetdraftid;
          
          if v_entityjson is not null then
          	for v_entity in select * from json_array_elements(v_entityjson)
        		loop
					select v_entity->>'entity_role_map_id', v_entity->>'priority'
                		into   v_entitymasterid, v_priority;
                         
					if v_entitymasterid is not null and v_priority = 1 then
                		
                         insert into v_videojsondata
                		select ad.asset_id , v_titlealias, (asset_data->'data'->'guid'), (asset_data->'data'->'status')::varchar, 
                    v_entitymasterid, ad.created_date, ad.updated_date,ad.version_number
                    	from   labgmr.labgmr_asset_draft ad
                      join   labgmr.labgmr_video a
                      on ad.asset_id=a.video_id
                    	where  asset_draft_id = v_assetdraftid;
                         
            		end if;
        		end loop;
            else
            	insert into v_videojsondata
              select ad.asset_id , v_titlealias, (asset_data->'data'->'guid'), ad.is_published, null,
              ad.created_date, ad.updated_date,ad.version_number
            	from   labgmr.labgmr_asset_draft ad
                      join   labgmr.labgmr_video a
                      on ad.asset_id=a.video_id
            	where  asset_draft_id = v_assetdraftid;
            end if;
            
        end loop;
    end if;
    
    if  p_status = 1 then
    	
        execute 'select count(1) 
              from (
                  select a.video_id, asset_data->''data''->''title_alias'' title_alias, asset_data->''data''->''guid'' guid,
                  a.is_published, 
                  entity_role_map_id, a.created_date, a.updated_date,
                  row_number() over(order by a.updated_date desc) as slno
                     from   labgmr.labgmr_video as a
                     join   labgmr.labgmr_asset_entity_map as aem
                     on     aem.asset_id = a.video_id
                     and    aem.asset_type_id  = '||v_asset_type_id||' 
                     and    a.is_published=1 and a.is_trashed=0
                     and    aem.priority = 1
                     join  labgmr.labgmr_asset_draft as ad
                   on  ad.asset_type_id  =  ' || v_asset_type_id ||' 
                   and     ad.asset_id = a.video_id
                     and    ad.version_number = (select max(a1.version_number)
                                   from labgmr.labgmr_asset_draft as a1
                                               where  a1.asset_id = ad.asset_id
                                               and a1.asset_type_id  =  ' || v_asset_type_id ||' )
                 '
        		  ||v_createdbyquery
                 ||v_searchvideoquery
                 ||
                 ' ) top_a '
                 into   v_videocount
                 using  p_authorid, v_searchkeyword;
        
        execute 'insert into v_videojsondata
              select video_id, title_alias, guid, is_published, 
              entity_role_map_id, created_date, updated_date,version_number
              from (
                  select a.video_id, asset_data->''data''->''title_alias'' title_alias, 
                  asset_data->''data''->''guid'' guid, a.is_published, 
                  entity_role_map_id, a.created_date, a.updated_date,
                  row_number() over(order by a.updated_date desc) as slno
                  ,a.published_version_number as version_number
                     from   labgmr.labgmr_video as a
                     join   labgmr.labgmr_asset_entity_map as aem
                     on     aem.asset_id = a.video_id
                     and    aem.asset_type_id  = '||v_asset_type_id||' 
                     and    a.is_published=1 and a.is_trashed=0
                     and    aem.priority = 1
                     join  labgmr.labgmr_asset_draft as ad
                   on  ad.asset_type_id  =  ' || v_asset_type_id ||' 
                   and     ad.asset_id = a.video_id
                     and    ad.version_number = (select max(a1.version_number)
                                   from labgmr.labgmr_asset_draft as a1
                                               where  a1.asset_id = ad.asset_id
                                               and a1.asset_type_id  =  ' || v_asset_type_id ||' )
                 '
        		  ||v_createdbyquery
                 ||v_searchvideoquery
                 ||
                 ' ) top_a
    			where slno between $3 and $4
          '
                 
                 using  p_authorid, v_searchkeyword,v_fromrownumber, v_torownumber;
    
    elsif p_status = 2 then
    	
        execute 'select count(1) 
              from (
                  select a.video_id, asset_data->''data''->''title_alias'' title_alias,
                  asset_data->''data''->''guid'' guid, a.is_published, 
                  entity_role_map_id, a.created_date, a.updated_date,
                  row_number() over(order by a.updated_date desc) as slno
                     from   labgmr.labgmr_video as a
                     join   labgmr.labgmr_asset_entity_map as aem
                     on     aem.asset_id = a.video_id
                     and    aem.asset_type_id  = '||v_asset_type_id||' 
                     and    a.is_trashed=1
                     and    aem.priority = 1
                     join  labgmr.labgmr_asset_draft as ad
                   on  ad.asset_type_id  =  ' || v_asset_type_id ||' 
                   and     ad.asset_id = a.video_id
                     and    ad.version_number = (select max(a1.version_number)
                                   from labgmr.labgmr_asset_draft as a1
                                               where  a1.asset_id = ad.asset_id
                                               and a1.asset_type_id  =  ' || v_asset_type_id ||' )
                 '
        		  ||v_createdbyquery
                 ||v_searchvideoquery
                 ||
                 ' ) top_a '
                 into   v_videocount
                 using  p_authorid, v_searchkeyword;
        
        execute 'insert into v_videojsondata
                 select video_id, title_alias, guid, is_published, 
                 entity_role_map_id, created_date, updated_date,version_number
                  from (
                  select a.video_id, asset_data->''data''->''title_alias'' title_alias,
                  asset_data->''data''->''guid'' guid, a.is_published, 
                  entity_role_map_id, a.created_date, a.updated_date,
                  row_number() over(order by a.updated_date desc) as slno
                  ,ad.version_number
                     from   labgmr.labgmr_video as a
                     join   labgmr.labgmr_asset_entity_map as aem
                     on     aem.asset_id = a.video_id
                     and    aem.asset_type_id  = '||v_asset_type_id||' 
                     and    a.is_trashed=1
                     and    aem.priority = 1
                     join  labgmr.labgmr_asset_draft as ad
                   on  ad.asset_type_id  =  ' || v_asset_type_id ||' 
                   and     ad.asset_id = a.video_id
                     and    ad.version_number = (select max(a1.version_number)
                                   from labgmr.labgmr_asset_draft as a1
                                               where  a1.asset_id = ad.asset_id
                                               and a1.asset_type_id  =  ' || v_asset_type_id ||' )
                 '
        		  ||v_createdbyquery
                 ||v_searchvideoquery
                 ||
                 ' ) top_a
    			where slno between $3 and $4
          '
                 
                 using  p_authorid, v_searchkeyword,v_fromrownumber, v_torownumber;    
    end if;
    
    
    p_videocount := v_drafvideocount + v_videocount;
    
     
    execute 'select array(select row_to_json(row) as jsonrow
     			 		  from (select slno, video_id, title_alias, guid, status, created_date, modified_date,
                          published_date,version_number,created_by,created_by_name,content_source_id,duration,
                          image_caption, image_desc, image_path, image_file_name,
                          		entitydata
                       			from (select     row_number() over(order by tab.created_date desc) as slno, tab.video_id, 
                                tab.title_alias, tab.video_guid as guid,
                                tab.status, tab.created_date, tab.created_date modified_date,a.published_date,
                                tab.version_number,u.user_id created_by,u.user_name created_by_name,a.content_source_id,a.duration,
                                image_caption, image_desc, image_path, image_file_name,
                                em as entitydata
                          
     	   			   		 		  from       v_videojsondata as tab
                          join      swa.labgmr_video a
                          on tab.video_id=a.video_id
                          left join labgmr.labgmr_image i
                          on i.image_id = a.image_id
                          join 		swa.swa_user u
                          on		u.user_id=a.created_by
     	   			   		 		  left join  (select 1 as priority, erm.entity_role_map_id,
                                      emi.entity_name
                       		 	    		      from   labgmr.labgmr_entity_master emi
                                          join   labgmr.labgmr_entity_role_map erm
                                          on     erm.entity_master_id = emi.entity_master_id
                                          ) as em(priority, entity_role_map_id, entity_name)
           			   		 		  on         tab.entity_id = em.entity_role_map_id
           		       		 		  order by a.updated_date desc) as tab1 
                      		   ) row
                		 )'
	 into v_videojsonarr ;
     
     
     
     
     foreach v_videojson in array v_videojsonarr
     loop
     	v_json := v_json||v_videojson||',';
     end loop;
     
     select count(1)
    	into   v_video_count
    	from   unnest(v_videojsonarr) video_id;
      
      if v_video_count > 0 then
      	v_json := substring(v_json,1,(length(v_json)-1));
      else
      	v_json := substring(v_json,1,(length(v_json)));
      end if;
      
     v_json := v_json||']}';
     
     p_videojson := v_json::jsonb;
     
     drop table v_videojsondata;
     
exception
	when others then
     	p_videocount := -1;
          p_videojson := '{"items":[]}';
     
end;

 $_$;


--
