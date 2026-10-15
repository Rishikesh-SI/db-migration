-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_get_topic_listing_r(numeric, numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labecn_v1_get_topic_listing_r(numeric, numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE FUNCTION labecn_v1_bkp_29012025.labecn_v1_get_topic_listing_r(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_searchkeyword character varying, OUT p_topiccount numeric, OUT p_topicjson jsonb) RETURNS record
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
     
begin
	
    if p_page1_size is null 
     then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
      else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
     v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
     end if;

     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from labecn_v1.labecn_v1_author_action
                                                           where action_id = 4
                                                           and asset_type_id = ' || v_asset_type_id || '
                                                           and author_id = $1) ';
		
     	v_topiccreatedbyquery := ' and adv.topic_id in(select asset_id
          										 from labecn_v1.labecn_v1_author_action
                                                             where action_id = 4
                                                             and asset_type_id = ' || v_asset_type_id || '
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title_alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchtopicquery := ' and upper(title_alias) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     create temp table if not exists v_topicjsondata
     (
         topic_id     numeric,
         title_alias    varchar(4000),
         topic_guid   varchar(256),
         status         varchar(256),
         entity_id      numeric,
         created_date   timestamp,
         modified_date  timestamp,
         version_number numeric
  	);
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   labecn_v1.labecn_v1_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and   adv.version_number = (select max(ad1.version_number)
												from   labecn_v1.labecn_v1_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
				and    ((exists (select topic_id
									from   labecn_v1.labecn_v1_topic a
									where  a.topic_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
						or (adv.version_number > (select published_version_number
													from labecn_v1.labecn_v1_topic
													where topic_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
    		into    v_drafttopiccount
     	using   p_authorid, v_searchkeyword;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   labecn_v1.labecn_v1_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                      and   adv.version_number = (select max(ad1.version_number)
												from   labecn_v1.labecn_v1_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
				and    ((exists (select topic_id
									from   labecn_v1.labecn_v1_topic a
									where  a.topic_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
						or (adv.version_number > (select published_version_number
													from labecn_v1.labecn_v1_topic
													where topic_id = adv.asset_id)))'
                                     ||v_draftcreatedbyquery
                                     ||v_searchdraftquery
                                     ||')tab
                                where  slno between '||'$3'||' and '||'$4'||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
          foreach v_assetdraftid in array v_assetdraftidarr
          loop
          	
               select asset_data->'data'->>'title_alias',
               	  asset_data->'data'->>'entitydata'
			into   v_titlealias,
               	  v_entityjson
      		from   labecn_v1.labecn_v1_asset_draft
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
                              , v_entitymasterid, ad.created_date, ad.updated_date, ad.version_number
                              from   labecn_v1.labecn_v1_asset_draft ad
                              join   labecn_v1.labecn_v1_topic v
                              on     ad.asset_id    = v.topic_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_topicjsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->>'topic_guid'),(asset_data->'data'->'status')::varchar, null, ad.created_date, ad.updated_date, ad.version_number
                    from   labecn_v1.labecn_v1_asset_draft ad
                    join   labecn_v1.labecn_v1_topic v
                    on     ad.asset_id    = v.topic_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   labecn_v1.labecn_v1_topic as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_topiccreatedbyquery
                   ||v_searchtopicquery
          into    v_topiccount
          using   p_authorid, v_searchkeyword;
          
          execute 'insert into v_topicjsondata
          	    select topic_id, title_alias, topic_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, topic_id, title_alias, topic_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   labecn_v1.labecn_v1_topic as adv
                        join   labecn_v1.labecn_v1_asset_entity_map aem
                        on     aem.asset_id = adv.topic_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labecn_v1.labecn_v1_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = 1'
                        ||v_topiccreatedbyquery
                        ||v_searchtopicquery
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	else
     	
          execute 'select count(1)
          	    from   labecn_v1.labecn_v1_topic adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_topiccreatedbyquery
                   ||v_searchtopicquery
          into    v_topiccount
          using   p_authorid, v_searchkeyword;
          
    		execute 'insert into v_topicjsondata
          	    select topic_id, title_alias, topic_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, topic_id, title_alias, topic_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   labecn_v1.labecn_v1_topic as adv
                        join   labecn_v1.labecn_v1_asset_entity_map aem
                        on     aem.asset_id = adv.topic_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labecn_v1.labecn_v1_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                        and    aem.priority           = 1'
                        ||v_topiccreatedbyquery
                        ||v_searchtopicquery 
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	end if;
    
  	p_topiccount := v_drafttopiccount + v_topiccount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.topic_id,adv.channel_id, tab.title_alias, tab.topic_guid as guid, tab.status, tab.created_date,
                           tab.created_date modified_date,adv.published_date, tab.version_number,u.user_id created_by,
                           u.display_name created_by_name,adv.content_source_id, em as entitydata,
                           channel_desc as channel_description, channel_name asset_title, handle_value hashtag, i.image_file_name,
                           i.image_path, sport_id, sport_name, adv.match_id, adv.channel_type
                           	   from v_topicjsondata as tab
                                 join labecn_v1.labecn_v1_topic adv
                                 on   tab.topic_id = adv.topic_id
                                 left join labecn_v1.labecn_v1_topic_asset_map tam
                                 on tam.topic_id = adv.topic_id
                                 and tam.asset_type_id = 3
                                 left join labecn_v1.labecn_v1_image i
                                 on i.image_id = tam.asset_id
                                 join labecn_v1.labecn_v1_user u
                                 on   u.user_id=adv.created_by
                                 left join (select 1 as priority, erm.entity_role_map_id,
                                 emi.entity_name as name, is_visible, is_linkable,td.topic_id tid
                                 		    from   labecn_v1.labecn_v1_entity_master emi
                                            join   labecn_v1.labecn_v1_entity_role_map erm
                                            on     erm.entity_master_id = emi.entity_master_id
                                            join   labecn_v1.labecn_v1_asset_entity_map aem
                                            on     aem.entity_role_map_id = erm.entity_role_map_id
                                            and    aem.priority=1
                                            join   v_topicjsondata td
                                            on     aem.asset_id=td.topic_id
                                            and    aem.asset_type_id = '||v_asset_type_id||') as 
                                            em(priority, entity_role_map_id, name, is_visible, is_linkable)
                                  on        tab.entity_id = em.entity_role_map_id
                                   and tab.topic_id=em.tid
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
