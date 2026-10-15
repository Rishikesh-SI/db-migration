-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_get_topic_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: labrs_get_topic_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: labrs_2602; Owner: -
--

CREATE FUNCTION labrs_2602.labrs_get_topic_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_topiccount numeric, OUT p_topicjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_draftcreatedbyquery   varchar(500) := ' ';
     v_topiccreatedbyquery varchar(500) := ' ';
     v_searchkeyword 	    varchar(4000) := upper(p_searchkeyword);
     v_searchdraftquery 	    varchar(200) := ' ';
     v_searchtopicquery    varchar(200) := ' ';
	v_drafttopiccount     numeric := 0;
     v_assetdraftidarr       numeric[];
     v_assetdraftid          numeric;
     v_titlealias            varchar(500);
     v_entityjson            json;
     v_entity                json;
     v_entitymasterid        numeric;
     v_priority              numeric;
     v_topiccount          numeric := 0;
	v_fromrownumber         numeric;
     v_torownumber           numeric;
     v_count                 numeric;
     v_topicjsonarr        jsonb[];
     v_topicjson           jsonb;
     v_json                  text := '{"items":[';
     v_topic_count         numeric:=0;
     v_asset_type_id         numeric:=5;
	 
	 v_priority1 numeric := 2;
     v_assetidarr numeric[];
     v_assetfilterquery varchar(4000) := ' ';
     v_entitycount numeric;
     v_channelname varchar(4000);
     v_channeldesc varchar(4000);
	 
	  v_from_and_to varchar(200):=' ';
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from labrs.labrs_author_action
                                                           where action_id = 4
                                                           and asset_type_id = ' || v_asset_type_id || '
                                                           and author_id = $1) ';
		
     	v_topiccreatedbyquery := ' and adv.topic_id in(select asset_id
          										 from labrs.labrs_author_action
                                                             where action_id = 4
                                                             and asset_type_id = ' || v_asset_type_id || '
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title_alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchtopicquery := ' and upper(title_alias) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
	
	if ( p_status =1 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and published_date >=$6  and published_date <=$7';
	
	end if ;
	
	if ( p_status =0 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and adv.updated_date >=$6  and adv.updated_date <=$7';
	
	end if ;
	
	if ( p_status =2 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and adv.updated_date >=$6  and adv.updated_date <=$7';
	
	end if ;
	
	
	
	
	----changes done by rakesh bhatkar date 06-03-2017---
	 select count(1)
     into   v_entitycount
     from   (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
	 
	 if v_entitycount >0 then 
	    if p_status =0 then 
		    
			with entitydata(t_json) as 
			    (select (asset_data->'data'->>'entitydata')::json,asset_id,asset_type_id
                 from swa.swa_asset_draft ad
                 where asset_type_id = v_asset_type_id
                 and version_number=(select max(version_number)
                                     from swa.swa_asset_draft adi
                                     where adi.asset_id=ad.asset_id
                                     and   adi.asset_type_id=ad.asset_type_id)
                )
	          select array(
                  select asset_id
                         from (
                           select  obj->>'entity_role_map_id' , asset_id, asset_type_id
                           from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
                           where  (obj->>'entity_role_map_id')::numeric in (select entityid from unnest(p_entityrolemapid) u(entityid))) jd
                           group by asset_id,asset_type_id
                           having count(1) = v_entitycount)
                           into  v_assetidarr;
						   
				if v_assetidarr is not null then
            	
            	  v_assetfilterquery := ' and adv.asset_id in(select asset_id from unnest($5) u(asset_id)) ';
            	
                end if;
     
         else
        
          select array(
          select asset_id
          from   labrs.labrs_asset_entity_map eam
          where  eam.asset_type_id = v_asset_type_id 
          and    eam.entity_role_map_id in (select entityid
							 from unnest(p_entityrolemapid) u(entityid))
                             group by eam.asset_id,asset_type_id
                             having count(1)=v_entitycount)
          into  v_assetidarr;
        
		if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.topic_id in(select asset_id from unnest($5) u(asset_id)) ';
            	
         end if;
     
     end if;
      
    end if;		   
						   
	
	----changes done by rakesh bhatkar date 06-03-2017---
     
     create temp table if not exists v_topicjsondata
     (
         topic_id     numeric,
         title_alias    varchar(4000),
         topic_guid   varchar(256),
         status         varchar(256),
         entity_id      numeric,
         created_date   timestamp,
         modified_date  timestamp,
         version_number numeric,
         channel_name varchar(4000),
         channel_description varchar(4000)
  	);
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   labrs.labrs_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and   adv.version_number = (select max(ad1.version_number)
												from   labrs.labrs_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
				and    ((exists (select topic_id
									from   labrs.labrs_topic a
									where  a.topic_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
						or (adv.version_number > (select published_version_number
													from labrs.labrs_topic
													where topic_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
				   ||v_assetfilterquery
				   ||v_from_and_to
    		into    v_drafttopiccount
     	using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   labrs.labrs_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                      and   adv.version_number = (select max(ad1.version_number)
												from   labrs.labrs_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
				and    ((exists (select topic_id
									from   labrs.labrs_topic a
									where  a.topic_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
						or (adv.version_number > (select published_version_number
													from labrs.labrs_topic
													where topic_id = adv.asset_id)))'
                                     ||v_draftcreatedbyquery
                                     ||v_searchdraftquery
									 ||v_assetfilterquery
									 ||v_from_and_to
                                     ||')tab
                                where  slno between '||'$3'||' and '||'$4'||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
          foreach v_assetdraftid in array v_assetdraftidarr
          loop
          	
               select asset_data->'data'->>'title_alias',
               	  asset_data->'data'->>'entitydata',
                      asset_data->'data'->>'channel_name',
               	  asset_data->'data'->>'channel_description'
			into   v_titlealias,
               	  v_entityjson,
                   		v_channelname,
                   v_channeldesc
      		from   labrs.labrs_asset_draft
      		where  asset_draft_id = v_assetdraftid;
               
      		if v_entityjson is not null then
               	
                    for v_entity in select * from json_array_elements(v_entityjson)
                    loop
                    	
                         select v_entity->>'entity_role_map_id',
                 			  v_entity->>'priority'
                         into   v_entitymasterid,
                         	  v_priority;
					
                         if v_entitymasterid is not null and v_priority = 1 then
                         	
                              insert into v_topicjsondata
                              select ad.asset_id, v_titlealias, (asset_data->'data'->>'topic_guid'), (asset_data->'data'->'status')::varchar
                              , v_entitymasterid, ad.created_date, ad.updated_date, ad.version_number, v_channelname, v_channeldesc
                              from   labrs.labrs_asset_draft ad
                              join   labrs.labrs_topic v
                              on     ad.asset_id    = v.topic_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_topicjsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->>'topic_guid'),(asset_data->'data'->'status')::varchar, null, ad.created_date, ad.updated_date, ad.version_number
                   ,v_channelname, v_channeldesc
                    from   labrs.labrs_asset_draft ad
                    join   labrs.labrs_topic v
                    on     ad.asset_id    = v.topic_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   labrs.labrs_topic as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_topiccreatedbyquery
                   ||v_searchtopicquery
				   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_topiccount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
          execute 'insert into v_topicjsondata
          	    select topic_id, title_alias, topic_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   , channel_name, channel_desc
                   from(select row_number() over(order by adv.updated_date desc) slno, topic_id, title_alias, topic_guid, adv.is_published,
                   aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number, channel_name, channel_desc
                   	    from   labrs.labrs_topic as adv
                        join   labrs.labrs_asset_entity_map aem
                        on     aem.asset_id = adv.topic_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labrs.labrs_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = 1'
                        ||v_topiccreatedbyquery
                        ||v_searchtopicquery
						||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	else
     	
          execute 'select count(1)
          	    from   labrs.labrs_topic adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_topiccreatedbyquery
                   ||v_searchtopicquery
				   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_topiccount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
    		execute 'insert into v_topicjsondata
          	    select topic_id, title_alias, topic_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   , channel_name, channel_desc
                   from(select row_number() over(order by adv.updated_date desc) slno, topic_id, title_alias, topic_guid, adv.is_published,
                   aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number , channel_name, channel_desc
                   	    from   labrs.labrs_topic as adv
                        join   labrs.labrs_asset_entity_map aem
                        on     aem.asset_id = adv.topic_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labrs.labrs_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                        and    aem.priority           = 1'
                        ||v_topiccreatedbyquery
                        ||v_searchtopicquery 
						||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	end if;
     
  	p_topiccount := v_drafttopiccount + v_topiccount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.topic_id, tab.title_alias, tab.topic_guid as guid, tab.status, tab.created_date,
                           tab.created_date modified_date,adv.published_date, tab.version_number,u.user_id created_by,
                           u.display_name created_by_name,adv.content_source_id, em as entitydata,
                           tab.channel_description, tab.channel_name, handle_value hashtag, i.image_file_name,
                           i.image_path,adv.title_alias
                           	   from v_topicjsondata as tab
                                 join labrs.labrs_topic adv
                                 on   tab.topic_id = adv.topic_id
                                 left join labrs.labrs_topic_asset_map tam
                                 on tam.topic_id = adv.topic_id
                                 and tam.asset_type_id = 3
                                 left join labrs.labrs_image i
                                 on i.image_id = tam.asset_id
                                 join labrs.labrs_user u
                                 on   u.user_id=adv.created_by
                                 left join (select distinct aem.priority, erm.entity_role_map_id, emi.entity_name, is_visible, is_linkable
                                 		    from   labrs.labrs_entity_master emi
                                            join   labrs.labrs_entity_role_map erm
                                            on     erm.entity_master_id = emi.entity_master_id
                                            join   labrs.labrs_asset_entity_map aem
                                            on     aem.entity_role_map_id = erm.entity_role_map_id
                  							and aem.priority=1
                                            and    aem.asset_type_id = '||v_asset_type_id||') as 
                                            em(priority, entity_role_map_id, entity_name, is_visible, is_linkable)
                                  on        tab.entity_id = em.entity_role_map_id
                                 order by adv.updated_date desc) row
                           )'
	into    v_topicjsonarr;
     
     select count(1)
    	into   v_topic_count
    	from   unnest(v_topicjsonarr) topic_id;
     
     foreach v_topicjson in array v_topicjsonarr
     loop
     	v_json := v_json||v_topicjson||',';
  	end loop;
     
     if v_topic_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}';
     p_topicjson := v_json::jsonb;
     
  	drop table v_topicjsondata;
     
 /*exception
	
     when others then
      	p_topiccount := -1;
          p_topicjson  := '{"items":[]}';*/
     
end;

 $_$;


--
