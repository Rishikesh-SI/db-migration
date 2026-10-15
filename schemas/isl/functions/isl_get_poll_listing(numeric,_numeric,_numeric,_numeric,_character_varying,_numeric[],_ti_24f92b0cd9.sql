-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_poll_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: isl_get_poll_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_poll_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_pollcount numeric, OUT p_polljson jsonb) RETURNS record
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
     v_titlealias            isl.isl_poll.alias%type;
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
	 
	  
	 v_priority1 numeric := 2;
     v_assetidarr numeric[];
     v_assetfilterquery varchar(4000) := ' ';
     v_entitycount numeric;
	 
	 v_from_and_to varchar(200):=' ';
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from isl.isl_author_action
                                                           where action_id = 4
                                                           and asset_type_id = ' || v_asset_type_id || '
                                                           and author_id = $1) ';
		
     	v_pollcreatedbyquery := ' and adv.poll_id in(select asset_id
          										 from isl.isl_author_action
                                                             where action_id = 4
                                                             and asset_type_id = ' || v_asset_type_id || '
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchpollquery := ' and upper(title) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
	
	
	
	
	
	
	if ( p_status =1 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and start_date >=$6  and start_date <=$7';
	
	end if ;
	
	if ( p_status =0 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and adv.start_date >=$6  and adv.start_date <=$7';
	
	end if ;
	
	if ( p_status =2 and  p_from_date is not null and p_to_date is not null )
	then 
	v_from_and_to := 'and adv.start_date >=$6  and adv.start_date <=$7';
	
	end if ;
	
	
	----CHANGES DONE BY RAKESH BHATKAR DATE: 06-03-2017---
	 select count(1)
     into   v_entitycount
     from   (select entityid from unnest(p_entityrolemapid) U(entityid)) a;
	 
	 if v_entitycount >0 then 
	    if p_status =0 then 
		    
			with entitydata(t_json) as 
			    (select (asset_data->'data'->>'entitydata')::json,asset_id,ASSET_TYPE_ID
                 from isl.isl_ASSET_DRAFT AD
                 WHERE ASSET_TYPE_ID = v_asset_type_id
                 and version_number=(SELECT MAX(VERSION_NUMBER)
                                     FROM isl.isl_ASSET_DRAFT ADI
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
						   
				if v_assetidarr is not null then
            	
            	  v_assetfilterquery := ' and adv.asset_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
                end if;
     
         else
        
          select array(
          select asset_id
          from   isl.isl_asset_entity_map eam
          where  eam.asset_type_id = v_asset_type_id 
          and    eam.entity_role_map_id in (SELECT entityid
							 FROM UNNEST(p_entityrolemapid) U(entityid))
                             GROUP BY eam.asset_id,ASSET_TYPE_ID
                             HAVING COUNT(1)=v_entitycount)
          into  v_assetidarr;
        
		if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.poll_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
         end if;
     
     end if;
      
    end if;		   
						   
	
	----CHANGES DONE BY RAKESH BHATKAR DATE: 06-03-2017---
     
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
     		    from   isl.isl_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and    adv.version_number = (select max(ad1.version_number)
          	    						   from   isl.isl_asset_draft as ad1
               	                            where  ad1.asset_id = adv.asset_id)
		    	    and    (adv.asset_id not in (select poll_id
              							   from   isl.isl_poll
                         	                  where  (is_published = 1
                              	             		 or (is_published = 0
                                   	                	and is_trashed = 1)))
                      	  or adv.version_number > (select max(published_version_number)
                      						  from   isl.isl_poll
                              	                 where  poll_id = adv.asset_id))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
				   ||v_assetfilterquery
				   ||v_from_and_to
    		into    v_draftpollcount
     	using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   isl.isl_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                     and    adv.version_number = (select max(ad1.version_number)
                                     						 from   isl.isl_asset_draft as ad1
                                                                  where  ad1.asset_id = adv.asset_id)
							  and    (adv.asset_id not in (select poll_id
                                     						 from   isl.isl_poll
                                                                  where  (is_published = 1
                                                                  	    or (is_published = 0
                                                                          	   and is_trashed = 1)))
					  				or adv.version_number > (select max(published_version_number)
                                             					from isl.isl_poll
                                                                      where poll_id = adv.asset_id))'
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
          	
               select asset_data->'data'->>'title',
               	  asset_data->'data'->>'entitydata'
			into   v_titlealias,
               	  v_entityjson
      		from   isl.isl_asset_draft
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
                              from   isl.isl_asset_draft ad
                              join   isl.isl_poll v
                              on     ad.asset_id    = v.poll_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_polljsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->>'poll_guid'), (asset_data->'data'->>'status')::varchar, null, ad.created_date, ad.updated_date, ad.version_number
                    from   isl.isl_asset_draft ad
                    join   isl.isl_poll v
                    on     ad.asset_id    = v.poll_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   isl.isl_poll as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_pollcreatedbyquery
                   ||v_searchpollquery
				   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_pollcount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
          execute 'insert into v_polljsondata
          	    select poll_id, title, poll_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, poll_id, title, poll_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   isl.isl_poll as adv
                        join   isl.isl_asset_entity_map aem
                        on     aem.asset_id = adv.poll_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   isl.isl_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = 1'
                        ||v_pollcreatedbyquery
                        ||v_searchpollquery
						||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	else
     	
          execute 'select count(1)
          	    from   isl.isl_poll adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_pollcreatedbyquery
                   ||v_searchpollquery
				   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_pollcount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
    		execute 'insert into v_polljsondata
          	    select poll_id, title, poll_guid, is_published, entity_role_map_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, poll_id, title, poll_guid, adv.is_published, aem.entity_role_map_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   isl.isl_poll as adv
                        join   isl.isl_asset_entity_map aem
                        on     aem.asset_id = adv.poll_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   isl.isl_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                        and    aem.priority           = 1'
                        ||v_pollcreatedbyquery
                        ||v_searchpollquery
						||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	end if;
     
  	p_pollcount := v_draftpollcount + v_pollcount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.poll_id, tab.title_alias as title, tab.poll_guid as guid, tab.status, tab.created_date,
                           tab.created_date modified_date,null as published_date, tab.version_number,u.user_id created_by,
                           u.display_name created_by_name, em as entitydata, i.image_path, i.title_alias, i.image_file_name, adv.start_date, adv.end_date
                           	   from v_polljsondata as tab
                                 join isl.isl_poll adv
                                 on   tab.poll_id = adv.poll_id
                   			   left join isl.isl_poll_asset_map pam
                   			   on   pam.poll_id = tab.poll_id
                   			   and  pam.asset_type_id = 3
                   			   left join isl.isl_image i
                   			   on   i.image_id = pam.asset_id
                                 join isl.isl_user u
                                 on   u.user_id=adv.created_by
                                 left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name
                                 		    from   isl.isl_entity_master emi
                                            join   isl.isl_entity_role_map erm
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
