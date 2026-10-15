-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_article_listing_backup_17022017(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: swa_get_article_listing_backup_17022017(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_article_listing_backup_17022017(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_articlecount numeric, OUT p_articlejson jsonb) RETURNS record
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
     v_titlealias            swa.swa_article.title_alias%type;
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
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from swa.swa_author_action
                                                           where action_id = 4
                                                           and asset_type_id = 1
                                                           and author_id = $1) ';
		
     	v_articlecreatedbyquery := ' and adv.article_id in(select asset_id
          										 from swa.swa_author_action
                                                             where action_id = 4
                                                             and asset_type_id = 1
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title_alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searcharticlequery := ' and upper(title_alias) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     create temp table if not exists v_articlejsondata
     (
         article_id     numeric,
         title_alias    varchar,
         article_guid   varchar,
         status         numeric,
         entity_id      numeric,
         created_date   timestamp,
         modified_date  timestamp,
         version_number numeric
  	);
     
     if p_status = 0 then
     	
          execute 'select count(1)
     		    from   swa.swa_asset_draft as adv
	              where  adv.asset_type_id  = ' || v_asset_type_id || '
     	         and    adv.version_number = (select max(ad1.version_number)
          	    						   from   swa.swa_asset_draft as ad1
               	                            where  ad1.asset_id = adv.asset_id)
		    	    and    (adv.asset_id not in (select article_id
              							   from   swa.swa_article
                         	                  where  (is_published = 1
                              	             		 or (is_published = 0
                                   	                	and is_trashed = 1)))
                      	  or adv.version_number > (select max(published_version_number)
                      						  from   swa.swa_article
                              	                 where  article_id = adv.asset_id))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
    		into    v_draftarticlecount
     	using   p_authorid, v_searchkeyword;
          
     	execute 'select array(select asset_draft_id
     					  from   swa.swa_asset_draft as adv
                         	  where  adv.asset_type_id  = ' || v_asset_type_id || '
                           	  and    adv.version_number = (select max(ad1.version_number)
                           							 from   swa.swa_asset_draft as ad1
                                   	                     where  ad1.asset_id = adv.asset_id)
					  	  and    (adv.asset_id not in (select article_id
                           							 from   swa.swa_article
                                   	                     where  (is_published = 1
                                        	                	    or (is_published = 0
                                             	                   	   and is_trashed = 1)))
					  			or adv.version_number > (select max(published_version_number)
                                   						from swa.swa_article
                                             	               where article_id = adv.asset_id))'
                           	  ||v_draftcreatedbyquery
                                ||v_searchdraftquery||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword;
          
          foreach v_assetdraftid in array v_assetdraftidarr
          loop
          	
               select asset_data->'data'->>'title_alias',
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
					
                         if v_entitymasterid is not null and v_priority = 1 then
                         	
                              insert into v_articlejsondata
                              select ad.asset_id, v_titlealias, (asset_data->'data'->'guid'), v.is_published, v_entitymasterid, v.created_date, v.updated_date, ad.version_number
                              from   swa.swa_asset_draft ad
                              join   swa.swa_article v
                              on     ad.asset_id    = v.article_id
                              where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_articlejsondata
                    select ad.asset_id, v_titlealias, (asset_data->'data'->'guid'), v.is_published, null, v.created_date, v.updated_date, ad.version_number
                    from   swa.swa_asset_draft ad
                    join   swa.swa_article v
                    on     ad.asset_id    = v.article_id
                    where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   swa.swa_article as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
          into    v_articlecount
          using   p_authorid, v_searchkeyword;
          
          execute 'insert into v_articlejsondata
          	    select article_id, title_alias, article_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   from   swa.swa_article as adv
                   join   swa.swa_asset_entity_map aem
                   on     aem.asset_id = adv.article_id
                   and    aem.asset_type_id      = ' || v_asset_type_id || '
                   join   swa.swa_entity_role_map erm
                   on     erm.entity_role_map_id = aem.entity_role_map_id
                   where  adv.is_published       = 1
                   and    adv.is_trashed         = 0
                   and    aem.priority           = 1'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
          using   p_authorid, v_searchkeyword;
          
  	else
     	
          execute 'select count(1)
          	    from   swa.swa_article adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
          into    v_articlecount
          using   p_authorid, v_searchkeyword;
          
    		execute 'insert into v_articlejsondata
          	    select article_id, title_alias, article_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   from   swa.swa_article adv
                   join   swa.swa_asset_entity_map aem
                   on     aem.asset_id = adv.article_id
                   and    aem.asset_type_id      = ' || v_asset_type_id || '
                   join   swa.swa_entity_role_map erm
                   on     erm.entity_role_map_id = aem.entity_role_map_id
                   where  adv.is_published       = 0
                   and    adv.is_trashed         = 1
                   and    aem.priority           = 1'
                   ||v_articlecreatedbyquery
                   ||v_searcharticlequery
          using   p_authorid, v_searchkeyword;
          
  	end if;
     
  	p_articlecount := v_draftarticlecount + v_articlecount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
     	    			  from (select slno, article_id, title_alias, guid, status, created_date, modified_date, published_date,version_number,created_by,created_by_name,content_source_id, entitydata
                           	   from (select    row_number() over(order by tab.created_date desc) as slno, tab.article_id, tab.title_alias, tab.article_guid as guid, tab.status, tab.created_date, tab.created_date modified_date,adv.published_date, tab.version_number,u.user_id created_by,u.user_name created_by_name,adv.content_source_id, em as entitydata
                                 	    from      v_articlejsondata as tab
                                       join      swa.swa_article adv
                                       on        tab.article_id = adv.article_id
                                       join 	    swa.swa_user u
                                       on	    u.user_id=adv.created_by
                                       left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name
                                       			from   swa.swa_entity_master emi
                                                  join   swa.swa_entity_role_map erm
                                                  on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name)
                                       on        tab.entity_id = em.entity_role_map_id
                                      ) as tab1
                                 where slno between '||'$1'||' and '||'$2'||'
                                ) row
                          )'
	into    v_articlejsonarr
     using   v_fromrownumber, v_torownumber;
     
     foreach v_articlejson in array v_articlejsonarr
     loop
     	
          v_json := v_json||v_articlejson||',';
          
  	end loop;
     
     v_json        := substring(v_json,1,(length(v_json)-1));
     v_json        := v_json||']}';
     p_articlejson := v_json::jsonb;
     
  	drop table v_articlejsondata;
     
exception
	
     when others then
     	p_articlecount := -1;
          p_articlejson  := '{"items":[]}';
     
end;

$_$;


--
