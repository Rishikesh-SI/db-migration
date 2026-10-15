-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_get_article_listing_bak_20170804(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: cfc_get_article_listing_bak_20170804(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: cfc; Owner: -
--

CREATE FUNCTION cfc.cfc_get_article_listing_bak_20170804(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_articlecount numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_draftcreatedbyquery   varchar(500) := ' ';
     v_articlecreatedbyquery varchar(500) := ' ';
     v_searchkeyword 	    varchar(4000) := upper(p_searchkeyword);
     v_searchdraftquery 	    varchar(200) := ' ';
     v_searcharticlequery    varchar(200) := ' ';
	v_draftarticlecount     numeric := 0;
     v_assetdraftidarr       numeric[];
     v_assetdraftid          numeric;
     v_titlealias            cfc.cfc_article.title_alias%type;
     v_entityjson            json;
     v_entity                json;
     v_entitymasterid        numeric;
     v_priority              numeric;
     v_articlecount          numeric := 0;
	v_fromrownumber         numeric;
     v_torownumber           numeric;
     v_count                 numeric;
     v_articlejsonarr        jsonb[];
     v_articlejson           jsonb;
     v_json                  text := '{"items":[';
     v_article_count         numeric:=0;
     v_asset_type_id         numeric:=1;
     v_priority1 numeric := 2;
     v_assetidarr numeric[];
     v_assetfilterquery varchar(4000) := ' ';
     v_entitycount numeric;
     
     v_entityrolemapid numeric[];
     v_hindi_exists numeric:=0;
     v_hindi_er_map_id numeric:=7925;
     v_eng_er_map_id numeric:=7926;
	 
	 v_from_and_to varchar(200):=' ';
     v_sorting_column varchar(100);
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     select count(1) into v_hindi_exists
      from (select entityid from unnest(p_entityrolemapid) U(entityid)) a
      where entityid=v_hindi_er_map_id;
      
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from cfc.cfc_author_action
                                                           where action_id = 4
                                                           and asset_type_id = 1
                                                           and author_id = $1) ';
		
     	v_articlecreatedbyquery := ' and adv.article_id in(select asset_id
          										 from cfc.cfc_author_action
                                                             where action_id = 4
                                                             and asset_type_id = 1
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searcharticlequery := ' and upper(title) like ''%''||'||'$2'||'||''%'' ';
          
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
	
	
     
     select count(1)
    into   v_entitycount
    from   (select entityid from unnest(p_entityrolemapid) U(entityid)) a;
    
    if v_entitycount > 0 then
      
      if p_status = 0 then
      
          IF v_hindi_exists > 0 THEN
                with entitydata(t_json)
                as(select (asset_data->'data'->>'entitydata')::json,asset_id,ASSET_TYPE_ID
                    from cfc.cfc_ASSET_DRAFT AD
                    WHERE ASSET_TYPE_ID = v_asset_type_id
                    and version_number=(SELECT MAX(VERSION_NUMBER)
                                        FROM cfc.cfc_ASSET_DRAFT ADI
                                        WHERE ADI.ASSET_ID=AD.ASSET_ID
                                        AND   ADI.ASSET_TYPE_ID=AD.ASSET_TYPE_ID)
                   	and (asset_data->'data'->>'entitydata') is not null
               	and (asset_data->'data'->>'entitydata')  like '%[%'
                  )
                  select array(
               select asset_id
               from (
               select  obj->>'entity_role_map_id' , asset_id, ASSET_TYPE_ID
               from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
               where  (obj->>'entity_role_map_id')::numeric in (select entityid from unnest(p_entityrolemapid) U(entityid))
               ) jd
               group by asset_id,ASSET_TYPE_ID
               having count(1) = v_entitycount)
               into  v_assetidarr;
           ELSE
               with entitydata(t_json)
                as(select (asset_data->'data'->>'entitydata')::json,asset_id,ASSET_TYPE_ID
                    from cfc.cfc_ASSET_DRAFT AD
                    WHERE ASSET_TYPE_ID = v_asset_type_id
                    and version_number=(SELECT MAX(VERSION_NUMBER)
                                        FROM cfc.cfc_ASSET_DRAFT ADI
                                        WHERE ADI.ASSET_ID=AD.ASSET_ID
                                        AND   ADI.ASSET_TYPE_ID=AD.ASSET_TYPE_ID)
                   and (asset_data->'data'->>'entitydata') is not null
               	and (asset_data->'data'->>'entitydata')  like '%[%'
                  )
                  select array(
               select asset_id
               from (
               select  obj->>'entity_role_map_id' , asset_id, ASSET_TYPE_ID
               from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
               where  (obj->>'entity_role_map_id')::numeric in (select entityid from unnest(p_entityrolemapid) U(entityid))
               ) jd
               group by asset_id,ASSET_TYPE_ID
               having count(1) = v_entitycount
               EXCEPT
               select asset_id
               from (
                   select  obj->>'entity_role_map_id' , asset_id, ASSET_TYPE_ID
                   from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
                   where  (obj->>'entity_role_map_id')::numeric in (v_hindi_er_map_id)
                   ) jd
               )
               into  v_assetidarr;
           END IF;
            raise notice '%',v_assetidarr;
            
            if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.asset_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
            end if;
     
     else
         
            select array(
            select asset_id
            from   cfc.cfc_asset_entity_map eam
            where  eam.asset_type_id = v_asset_type_id 
            and    eam.entity_role_map_id in (SELECT entityid
                   FROM UNNEST(p_entityrolemapid) U(entityid))
                            GROUP BY eam.asset_id,ASSET_TYPE_ID
                            HAVING COUNT(1)=v_entitycount)
            into  v_assetidarr;
         
            if v_assetidarr is not null then
            	
            	v_assetfilterquery := ' and adv.article_id in(select asset_id from unnest($5) U(asset_id)) ';
            	
            end if;
     
     end if;
      
    end if;
     
      create temp table if not exists v_articlejsondata
     (
         article_id     numeric,
         title    varchar(4000),
         article_guid   varchar(256),
         status         varchar(256),
         entity_id      numeric,
         created_date   timestamp,
         updated_date  timestamp,
         version_number numeric
  	 );
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   cfc.cfc_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and    adv.version_number = (select max(ad1.version_number)
                                     						 from   cfc.cfc_asset_draft as ad1
                                                                  where  ad1.asset_id = adv.asset_id
                                                                 and ad1.asset_type_id = adv.asset_type_id)
							  and    ((exists (select article_id
                                     						 from   cfc.cfc_article a
                                                                  where 
                                                          a.article_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from cfc.cfc_article
                                                                      where article_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
                   ||v_assetfilterquery
                   ||v_from_and_to
    		into    v_draftarticlecount
     	using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
     	execute 'select array(select asset_draft_id
          				  from(select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                                	  from   cfc.cfc_asset_draft as adv
                                     where  adv.asset_type_id  = ' || v_asset_type_id || '
                                     and    adv.version_number = (select max(ad1.version_number)
                                     						 from   cfc.cfc_asset_draft as ad1
                                                                  where  ad1.asset_id = adv.asset_id
                                                                 and ad1.asset_type_id = adv.asset_type_id)
							  and    ((exists (select article_id
                                     						 from   cfc.cfc_article a
                                                                  where 
                                                          a.article_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from cfc.cfc_article
                                                                      where article_id = adv.asset_id)))'
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
      		from   cfc.cfc_asset_draft
      		where  asset_draft_id = v_assetdraftid;
               
      		if v_entityjson is not null then
               	
                    for v_entity in select * from json_array_elements(v_entityjson)
                    loop
                    	
                         select v_entity->>'entity_role_map_id',
                 			  v_entity->>'priority'
                         into   v_entitymasterid,
                         	  v_priority;
					
                         if v_entitymasterid is not null /*and v_priority = v_priority1*/ then
                         	  
                   			  delete from v_articlejsondata
                   			  where  article_id = (select asset_id
                                                   from   cfc.cfc_asset_draft
                                                   where  asset_draft_id = v_assetdraftid);
                   			  
                              insert into v_articlejsondata
                              select ad.asset_id, v_titlealias, 
                             (asset_data->'data'->>'guid'), (asset_data->'data'->'status')::varchar
                              , v_entitymasterid, ad.created_date, ad.updated_date, ad.version_number
                              from   cfc.cfc_asset_draft ad
                              join   cfc.cfc_article v
                              on     ad.asset_id    = v.article_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_articlejsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->>'guid'), 
                   v.is_published, null, ad.created_date, ad.updated_date, ad.version_number
                    from   cfc.cfc_asset_draft ad
                    join   cfc.cfc_article v
                    on     ad.asset_id    = v.article_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   cfc.cfc_article as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
                   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_articlecount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
          execute 'insert into v_articlejsondata
          	    select article_id, title, article_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, article_id, title, article_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   cfc.cfc_article as adv
                        join   cfc.cfc_asset_entity_map aem
                        on     aem.asset_id = adv.article_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   cfc.cfc_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 1
                        and    adv.is_trashed         = 0
                        and    aem.priority           = '||v_priority1
                        ||v_articlecreatedbyquery
                        ||v_searcharticlequery
                        ||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	else
     	
          execute 'select count(1)
          	    from   cfc.cfc_article adv
                   where  is_published = 0
                   and    is_trashed   = 1
                   and is_deleted=0'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
                   ||v_assetfilterquery
				   ||v_from_and_to
          into    v_articlecount
          using   p_authorid, v_searchkeyword,null,null,v_assetidarr,p_from_date,p_to_date;
          
    		execute 'insert into v_articlejsondata
          	    select article_id, title, article_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(select row_number() over(order by adv.updated_date desc) slno, article_id, title, article_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   	    from   cfc.cfc_article as adv
                        join   cfc.cfc_asset_entity_map aem
                        on     aem.asset_id = adv.article_id
                        and    aem.asset_type_id      = ' || v_asset_type_id || '
                        join   cfc.cfc_entity_role_map erm
                        on     erm.entity_role_map_id = aem.entity_role_map_id
                        where  adv.is_published       = 0
                        and    adv.is_trashed         = 1
                         and adv.is_deleted=0
                        and    aem.priority           = '||v_priority1
                        ||v_articlecreatedbyquery
                        ||v_searcharticlequery
                        ||v_assetfilterquery
						||v_from_and_to
                        ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber,v_assetidarr,p_from_date,p_to_date;
          
  	end if;
     
  	p_articlecount := v_draftarticlecount + v_articlecount;
     
  	/*execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.article_id, tab.title, tab.article_guid as guid, tab.status, tab.created_date,
                   				tab.updated_date modified_date, adv.published_date, tab.version_number, u.user_id created_by,
                   				u.display_name created_by_name, adv.content_source_id, em as entitydata, adv.title_alias
                           	   	from v_articlejsondata as tab
                   				join cfc.cfc_article adv
                   				on   tab.article_id = adv.article_id
                   			   	join cfc.cfc_author_action aa
                   				on aa.asset_type_id = '||v_asset_type_id||'
                   				and aa.asset_id = adv.article_id
                   				and aa.action_id = 4
                                join cfc.cfc_user u
                                on   u.user_id = aa.author_id
                                left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name
                   						   from   cfc.cfc_entity_master emi
                   						   join   cfc.cfc_entity_role_map erm
                   						   on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name)
                   				on        tab.entity_id = em.entity_role_map_id
                                order by adv.updated_date desc) row
                           )'
	into    v_articlejsonarr;*/
	select case when p_status in(0,2) then 'adv.updated_date' else 'adv.published_date' end into v_sorting_column;
	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select tab.article_id, tab.title, tab.article_guid as guid, tab.status, tab.created_date,
                   				tab.updated_date modified_date, adv.published_date, tab.version_number, u.user_id created_by,
                   				u.display_name created_by_name, adv.content_source_id, adv.title_alias, adv.checked_out_by,u1.display_name as checked_out_by_name,
                   				(select array_to_json(array_agg(a))
                   				 from   (select erm.priority, erm.entity_role_map_id, emi.entity_name
                   						 from   cfc.cfc_entity_master emi
                   						 join   cfc.cfc_entity_role_map erm
                   						 on     erm.entity_master_id = emi.entity_master_id
                   						 join   cfc.cfc_asset_entity_map aem
                   						 on     aem.entity_role_map_id = erm.entity_role_map_id
                   						 and    aem.asset_id = tab.article_id
                   						 and    aem.asset_type_id = '||v_asset_type_id||'
                   						 limit  1
                                      	)a
								)as entitydata
                           	   	from v_articlejsondata as tab
                   				join cfc.cfc_article adv
                   				on   tab.article_id = adv.article_id
                   			   	join cfc.cfc_author_action aa
                   				on aa.asset_type_id = '||v_asset_type_id||'
                   				and aa.asset_id = adv.article_id
                   				and aa.action_id = 4
                                join cfc.cfc_user u
                                on   u.user_id = aa.author_id
                                left join cfc.cfc_user u1 on u1.user_id=adv.checked_out_by
                                order by '||v_sorting_column||' desc) row
                           )'
	into    v_articlejsonarr;
	 
     select count(1)
    	into   v_article_count
    	from   unnest(v_articlejsonarr) article_id;
     
     foreach v_articlejson in array v_articlejsonarr
     loop
     	v_json := v_json||v_articlejson||',';
  	end loop;
     
     if v_article_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}';
     p_articlejson := v_json::jsonb;
     
  	 drop table v_articlejsondata;
     
 /*exception
	
     when others then
      	p_articlecount := -1;
          p_articlejson  := '{"items":[]}';*/
     
end;

$_$;


--
