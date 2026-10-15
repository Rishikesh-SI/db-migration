-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_video_listing(numeric, numeric, numeric, numeric, character varying, numeric[])
-- Type: FUNCTION

-- Name: swa_get_video_listing(numeric, numeric, numeric, numeric, character varying, numeric[]); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_video_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], OUT p_videocount numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_draftcreatedbyquery   varchar(500) := ' ';
     v_videocreatedbyquery varchar(500) := ' ';
     v_searchkeyword 	    varchar(4000) := upper(p_searchkeyword);
     v_searchdraftquery 	    varchar(200) := ' ';
     v_searchvideoquery    varchar(200) := ' ';
	v_draftvideocount     numeric := 0;
     v_assetdraftidarr       numeric[];
     v_assetdraftid          numeric;
     v_titlealias            swa.swa_video.title_alias%type;
     v_entityjson            json;
     v_entity                json;
     v_entitymasterid        numeric;
     v_priority              numeric;
     v_videocount          numeric := 0;
	v_fromrownumber         numeric;
     v_torownumber           numeric;
     v_count                 numeric;
     v_videojsonarr        jsonb[];
     v_videojson           jsonb;
     v_json                  text := '{"items":[';
     v_video_count         numeric:=0;
     v_asset_type_id         numeric:=4;
     v_priority1 numeric := 2;
     v_assetidarr numeric[];
     v_assetfilterquery varchar(4000) := ' ';
     v_entitycount numeric;
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from swa.swa_author_action
                                                           where action_id = 4
                                                           and asset_type_id = 4
                                                           and author_id = $1) ';
		
     	v_videocreatedbyquery := ' and adv.video_id in(select asset_id
          										 from swa.swa_author_action
                                                             where action_id = 4
                                                             and asset_type_id = 4
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchvideoquery := ' and upper(title) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     select count(1)
    into   v_entitycount
    from   (select entityid from unnest(p_entityrolemapid) U(entityid)) a;
    
    if v_entitycount > 0 then
      
      if p_status = 0 then
      
      with entitydata(t_json)
      as(select (asset_data->'data'->>'entitydata')::json,asset_id,ASSET_TYPE_ID
          from SWA.SWA_ASSET_DRAFT AD
          WHERE ASSET_TYPE_ID = v_asset_type_id
          and version_number=(SELECT MAX(VERSION_NUMBER)
                              FROM SWA.SWA_ASSET_DRAFT ADI
                              WHERE ADI.ASSET_ID=AD.ASSET_ID
                              AND   ADI.ASSET_TYPE_ID=AD.ASSET_TYPE_ID)
        )
        select array(
     select asset_id
     from (
     select  obj->>'entity_role_map_id' , asset_id, ASSET_TYPE_ID
     from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
     where  (obj->>'entity_role_map_id')::numeric in (select entityid from unnest(p_entityrolemapid) U(entityid))) jd
     group by asset_id,ASSET_TYPE_ID
     having count(1) = v_entitycount)
     into  v_assetidarr;
     
            raise notice '%',v_assetidarr;
            
     if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.asset_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
            end if;
     
     else
        
        select array(
        select asset_id
        from   swa.swa_asset_entity_map eam
        where  eam.asset_type_id = v_asset_type_id 
        and    eam.entity_role_map_id in (SELECT entityid
							 FROM UNNEST(p_entityrolemapid) U(entityid))
                        GROUP BY eam.asset_id,ASSET_TYPE_ID
                        HAVING COUNT(1)=v_entitycount)
        into  v_assetidarr;
        
		if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.video_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
            end if;
     
     end if;
      
    end if;
     
     create temp table if not exists v_videojsondata
     (
         video_id     numeric,
         title    varchar(4000),
         video_guid   varchar(256),
         status         varchar(256),
         entity_id      numeric,
         created_date   timestamp,
         updated_date  timestamp,
         version_number numeric
  	);
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   swa.swa_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and    adv.version_number = (select max(ad1.version_number)
                                     						 from   swa.swa_asset_draft as ad1
                                                                  where  ad1.asset_id = adv.asset_id
                                                                 and ad1.asset_type_id = adv.asset_type_id)
							  and    ((exists (select video_id
                                     						 from   swa.swa_video a
                                                                  where 
                                                          a.video_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from swa.swa_video
                                                                      where video_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
                   ||v_assetfilterquery
    		into    v_draftvideocount
     	using   p_authorid, v_searchkeyword,null,null,v_assetidarr;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   swa.swa_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                     and    adv.version_number = (select max(ad1.version_number)
                                     						 from   swa.swa_asset_draft as ad1
                                                                  where  ad1.asset_id = adv.asset_id
                                                                 and ad1.asset_type_id = adv.asset_type_id)
							  and    ((exists (select video_id
                                     						 from   swa.swa_video a
                                                                  where 
                                                          a.video_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from swa.swa_video
                                                                      where video_id = adv.asset_id)))'
                                     ||v_draftcreatedbyquery
                                     ||v_searchdraftquery
                                     ||v_assetfilterquery
                                     ||')tab
                                where  slno between '||'$3'||' and '||'$4'||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr;
          
          foreach v_assetdraftid in array v_assetdraftidarr
          loop
          	
               select asset_data->'data'->>'title',
               	  asset_data->'data'->>'entitydata'
			into   v_titlealias,
               	  v_entityjson
      		from   swa.swa_asset_draft
      		where  asset_draft_id = v_assetdraftid;
               
      		if v_entityjson is not null then
               	
                    for v_entity in select * from json_array_elements(v_entityjson)
                    loop
                    	
                         select v_entity->>'entity_role_map_id',
                 			  v_entity->>'priority'
                         into   v_entitymasterid,
                         	  v_priority;
					
                         if v_entitymasterid is not null and v_priority = v_priority1 then
                         	
                              insert into v_videojsondata
                              select ad.asset_id, v_titlealias, (asset_data->'data'->'guid'), (asset_data->'data'->'status')::varchar
                              , v_entitymasterid, ad.created_date, ad.updated_date, ad.version_number
                              from   swa.swa_asset_draft ad
                              join   swa.swa_video v
                              on     ad.asset_id    = v.video_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_videojsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->'guid'), v.is_published, null, ad.created_date, ad.updated_date, ad.version_number
                    from   swa.swa_asset_draft ad
                    join   swa.swa_video v
                    on     ad.asset_id    = v.video_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   swa.swa_video as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_videocreatedbyquery
                   ||v_searchvideoquery
                   ||v_assetfilterquery
          into    v_videocount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr;
          
          execute 'insert into v_videojsondata
          	    select video_id, title, video_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, video_id, title, video_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   swa.swa_video as adv
                        join   swa.swa_asset_entity_map aem
                        on     aem.asset_id = adv.video_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   swa.swa_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = '||v_priority1
                        ||v_videocreatedbyquery
                        ||v_searchvideoquery
                        ||v_assetfilterquery
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr;
          
  	else
     	
          execute 'select count(1)
          	    from   swa.swa_video adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_videocreatedbyquery
                   ||v_searchvideoquery
                   ||v_assetfilterquery
          into    v_videocount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr;
          
    		execute 'insert into v_videojsondata
          	    select video_id, title, video_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, video_id, title, video_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   swa.swa_video as adv
                        join   swa.swa_asset_entity_map aem
                        on     aem.asset_id = adv.video_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   swa.swa_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                        and    aem.priority           = '||v_priority1
                        ||v_videocreatedbyquery
                        ||v_searchvideoquery
                        ||v_assetfilterquery
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr;
          
  	end if;
     
  	p_videocount := v_draftvideocount + v_videocount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select     row_number() over(order by tab.created_date desc) as slno, tab.video_id, 
                                tab.title, tab.video_guid as guid,
                                tab.status, tab.created_date, tab.updated_date modified_date,adv.published_date,
                                tab.version_number,u.user_id created_by,u.display_name created_by_name,adv.content_source_id,adv.duration,
                                image_caption, image_desc, image_path, image_file_name,
                                em as entitydata, adv.title_alias
                           	   from       v_videojsondata as tab
                          JOIN      SWA.swa_video Adv
                          ON TAB.video_id=Adv.video_id
                          left join swa.swa_image i
                          on i.image_id = adv.image_id
                          join 		SWA.SWA_USER u
                          on		u.user_id=adv.created_by
     	   			   		 		  left join  (select 1 as priority, erm.entity_role_map_id,
                                      emi.entity_name
                       		 	    		      from   swa.swa_entity_master emi
                                          join   swa.swa_entity_role_map erm
                                          on     erm.entity_master_id = emi.entity_master_id
                                          ) as em(priority, entity_role_map_id, entity_name)
           			   		 		  on         tab.entity_id = em.entity_role_map_id
           		       		 		  order by adv.updated_date desc
                      		   ) row
                		 )'
	into    v_videojsonarr;
     
     select count(1)
    	into   v_video_count
    	from   unnest(v_videojsonarr) video_id;
     
     foreach v_videojson in array v_videojsonarr
     loop
     	v_json := v_json||v_videojson||',';
  	end loop;
     
     if v_video_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}';
     p_videojson := v_json::jsonb;
     
  	drop table v_videojsondata;
     
 exception
	
     when others then
      	p_videocount := -1;
          p_videojson  := '{"items":[]}';
     
end;

$_$;


--
