-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_get_poll_listing(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labpcm_get_poll_listing(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_get_poll_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_pollcount numeric, OUT p_polljson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_draftcreatedbyquery   varchar(500) := ' ';
     v_pollcreatedbyquery varchar(500) := ' ';
     v_searchkeyword 	    varchar(4000) := upper(p_searchkeyword);
     v_searchdraftquery 	    varchar(200) := ' ';
     v_searchpollquery    varchar(200) := ' ';
	v_draftpollcount     numeric := 0;
     v_assetdraftidarr       numeric[];
     v_assetdraftid          numeric;
     v_titlealias            labpcm.labpcm_poll.alias%type;
     v_entityjson            json;
     v_entity                json;
     v_entitymasterid        numeric;
     v_priority              numeric;
     v_pollcount          numeric := 0;
	v_fromrownumber         numeric;
     v_torownumber           numeric;
     v_count                 numeric;
     v_polljsonarr        jsonb[];
     v_polljson           jsonb;
     v_json                  text := '{"items":[';
     v_poll_count         numeric:=0;
     v_asset_type_id         numeric:=6;
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from labpcm.labpcm_author_action
                                                           where action_id = 4
                                                           and asset_type_id = ' || v_asset_type_id || '
                                                           and author_id = $1) ';
		
     	v_pollcreatedbyquery := ' and adv.poll_id in(select asset_id
          										 from labpcm.labpcm_author_action
                                                             where action_id = 4
                                                             and asset_type_id = ' || v_asset_type_id || '
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchpollquery := ' and upper(title) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     create temp table if not exists v_polljsondata
     (
         poll_id     numeric,
         title_alias    varchar(4000),
         poll_guid   varchar(256),
         status         varchar(256),
         entity_id      numeric,
         created_date   timestamp,
         modified_date  timestamp,
         version_number numeric
  	);
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   labpcm.labpcm_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and adv.version_number = (select max(ad1.version_number)
												from   labpcm.labpcm_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
					and ((exists (select poll_id
									from   labpcm.labpcm_poll a
									where  a.poll_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
							or (adv.version_number > (select max(published_version_number)
														from labpcm.labpcm_poll
														where poll_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
    		into    v_draftpollcount
     	using   p_authorid, v_searchkeyword;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   labpcm.labpcm_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                     and adv.version_number = (select max(ad1.version_number)
												from   labpcm.labpcm_asset_draft as ad1
												where  ad1.asset_id = adv.asset_id
												and    ad1.asset_type_id = adv.asset_type_id)
					and ((exists (select poll_id
									from   labpcm.labpcm_poll a
									where  a.poll_id = adv.asset_id
									and    is_published = 0
									and    is_trashed = 0))
							or (adv.version_number > (select max(published_version_number)
														from labpcm.labpcm_poll
														where poll_id = adv.asset_id)))'
                                     ||v_draftcreatedbyquery
                                     ||v_searchdraftquery
                                     ||')tab
                                where  slno between '||'$3'||' and '||'$4'||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
          foreach v_assetdraftid in array v_assetdraftidarr
          loop
          	
               select asset_data->'data'->>'title',
               	  asset_data->'data'->>'entitydata'
			into   v_titlealias,
               	  v_entityjson
      		from   labpcm.labpcm_asset_draft
      		where  asset_draft_id = v_assetdraftid;
               
      		if v_entityjson is not null then
               	
                    for v_entity in select * from json_array_elements(v_entityjson)
                    loop
                    	
                         select v_entity->>'entity_role_map_id',
                 			  v_entity->>'priority'
                         into   v_entitymasterid,
                         	  v_priority;
					
                         if v_entitymasterid is not null and v_priority = 1 then
                         	
                              insert into v_polljsondata
                              select ad.asset_id, v_titlealias, (asset_data->'data'->>'poll_guid'), (asset_data->'data'->>'status')::varchar
                              , v_entitymasterid, ad.created_date, ad.updated_date, ad.version_number
                              from   labpcm.labpcm_asset_draft ad
                              join   labpcm.labpcm_poll v
                              on     ad.asset_id    = v.poll_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_polljsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->>'poll_guid'), (asset_data->'data'->>'status')::varchar, null, ad.created_date, ad.updated_date, ad.version_number
                    from   labpcm.labpcm_asset_draft ad
                    join   labpcm.labpcm_poll v
                    on     ad.asset_id    = v.poll_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   labpcm.labpcm_poll as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_pollcreatedbyquery
                   ||v_searchpollquery
          into    v_pollcount
          using   p_authorid, v_searchkeyword;
          
          execute 'insert into v_polljsondata
          	    select poll_id, title, poll_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, poll_id, title, poll_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   labpcm.labpcm_poll as adv
                        join   labpcm.labpcm_asset_entity_map aem
                        on     aem.asset_id = adv.poll_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labpcm.labpcm_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = 1'
                        ||v_pollcreatedbyquery
                        ||v_searchpollquery
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	else
     	
          execute 'select count(1)
          	    from   labpcm.labpcm_poll adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_pollcreatedbyquery
                   ||v_searchpollquery
          into    v_pollcount
          using   p_authorid, v_searchkeyword;
          
    		execute 'insert into v_polljsondata
          	    select poll_id, title, poll_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, poll_id, title, poll_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   labpcm.labpcm_poll as adv
                        join   labpcm.labpcm_asset_entity_map aem
                        on     aem.asset_id = adv.poll_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   labpcm.labpcm_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                        and    aem.priority           = 1'
                        ||v_pollcreatedbyquery
                        ||v_searchpollquery
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	end if;
     
  	p_pollcount := v_draftpollcount + v_pollcount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.poll_id, tab.title_alias as title, tab.poll_guid as guid, tab.status, tab.created_date,
                           tab.created_date modified_date,null as published_date, tab.version_number,u.user_id created_by,
                           u.user_name created_by_name, em as entitydata
                           	   from v_polljsondata as tab
                                 join labpcm.labpcm_poll adv
                                 on   tab.poll_id = adv.poll_id
                                 join labpcm.labpcm_user u
                                 on   u.user_id=adv.created_by
                                 left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name
                                 		    from   labpcm.labpcm_entity_master emi
                                            join   labpcm.labpcm_entity_role_map erm
                                            on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name)
                                  on        tab.entity_id = em.entity_role_map_id
                                 order by adv.updated_date desc) row
                           )'
	into    v_polljsonarr;
     
     select count(1)
    	into   v_poll_count
    	from   unnest(v_polljsonarr) poll_id;
     
     foreach v_polljson in array v_polljsonarr
     loop
     	v_json := v_json||v_polljson||',';
  	end loop;
     
     if v_poll_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}';
     p_polljson := v_json::jsonb;
     
  	drop table v_polljsondata;
     
 /*exception
	
     when others then
      	p_pollcount := -1;
          p_polljson  := '{"items":[]}';*/
     
end;

 $_$;


--
