-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_article_listing(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: waf_get_article_listing(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_article_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_articlecount numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_createdbyquery varchar(50) := ' ';
    v_searchkeyword varchar(4000) := upper(p_searchkeyword);
    v_searchdraftquery varchar(200) := ' ';
    v_searcharticlequery varchar(200) := ' ';
	v_draftarticlecount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias JSON;
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_articlecount numeric := 0;
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_articlejsonarr jsonb[];
    v_articlejson jsonb;
    v_json varchar(4000) := '{"items":[';
begin
	
    if p_authorid is not null then
    		
          v_createdbyquery := ' and a.created_by = $1 ';
          
    end if;
    
    if p_searchkeyword is not null then
    		
          v_searchdraftquery   := ' and upper(a.asset_data->'||''''||'data'||'''->>'||''''||'title_alias'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searcharticlequery := ' and upper(title_alias) like ''%''||'||'$2'||'||''%'' ';
          
    end if;
    
    create temp table if not exists v_articlejsondata
    (
        article_id numeric,
        title_alias JSONB,
        article_guid JSONB,
        status numeric,
        entity_id numeric,
        created_date timestamp,
        modified_date timestamp
    );
    
    if p_status is null or p_status = 0 then
		
          execute 'select count(1)
    			 from   waf_master.waf_asset_draft as a
            	 where  a.asset_type_id  = 1
                 and    a.version_number = (select max(a1.version_number)
                 							 from waf_master.waf_asset_draft as a1
                        	                 where  a1.asset_id = a.asset_id)'
    			 ||v_createdbyquery
                ||v_searchdraftquery
    			 into   v_draftarticlecount
    			 using  p_authorid, v_searchkeyword;

          execute 'select array(select asset_draft_id
    			 from   waf_master.waf_asset_draft as a
            	 where  a.asset_type_id  = 1
                 and    a.version_number = (select max(a1.version_number)
                 							 from waf_master.waf_asset_draft as a1
                        	                 where  a1.asset_id = a.asset_id)'
    			 ||v_createdbyquery
                ||v_searchdraftquery
                ||
                 ' )'
    			 into   v_assetdraftidarr
    			 using  p_authorid, v_searchkeyword;
        
        foreach v_assetdraftid in array v_assetdraftidarr
        loop
        	
          select asset_data->'data'->'title_alias'::VARCHAR(100), asset_data->'data'->>'entitydata'
          into   v_titlealias, v_entityjson
          from   waf_master.waf_asset_draft
          where  asset_draft_id = v_assetdraftid;
          
          if v_entityjson is not null then
          	for v_entity in select * from json_array_elements(v_entityjson)
        		loop
					select v_entity->>'entity_master_id', v_entity->>'priority'
                		into   v_entitymasterid, v_priority;
                         
					if v_entitymasterid is not null and v_priority = 1 then
                		
                         insert into v_articlejsondata
                		select asset_id , v_titlealias, (asset_data->'data'->'guid'), a.is_published, v_entitymasterid, a.created_date, a.updated_date
                    	from   waf_master.waf_asset_draft ad
                join	waf_master.waf_article a
                on ad.asset_id= a.article_id
                    	where  asset_draft_id = v_assetdraftid;
                         
            		end if;
        		end loop;
            else
            	insert into v_articlejsondata
		  	select asset_id , v_titlealias, (asset_data->'data'->'guid'),a.is_published, null, a.created_date, a.updated_date
            	from   waf_master.waf_asset_draft ad
                join	waf_master.waf_article a
                on ad.asset_id= a.article_id
            	where  asset_draft_id = v_assetdraftid;
            end if;
            
        end loop;
    end if;
    
    if p_status is null or p_status = 1 then
    	
        execute 'select count(1)
            	  from   waf_master.waf_article as a
                  where 1 = 1'
                 ||v_createdbyquery
                 ||v_searcharticlequery
                 into   v_articlecount
                 using  p_authorid, v_searchkeyword;
        
        execute 'insert into v_articlejsondata
        		  select article_id, title_alias::JSON, article_guid::JSON, a.is_published, entity_master_id, a.created_date, a.updated_date
                 from   waf_master.waf_article as a
                 join   waf_master.waf_asset_entity_map as aem
                 on     aem.asset_id = a.article_id
                 and    aem.priority = 1'
        		  ||v_createdbyquery
                 ||v_searcharticlequery
                 using  p_authorid, v_searchkeyword;
        
    end if;
    
    p_articlecount := v_draftarticlecount + v_articlecount;
    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
     
    execute 'select array(select row_to_json(row) as jsonrow
     			 		  from (select slno, article_id, title_alias, guid, status, created_date, modified_date, entitydata
                       			from (select     row_number() over(order by created_date desc) as slno, article_id, title_alias, article_guid as guid, status, created_date, modified_date, em as entitydata
     	   			   		 		  from       v_articlejsondata as tab
     	   			   		 		  left join  (select 1 as priority, entity_master_id, entity_name
                       		 	    		      from   waf_master.waf_entity_master) as em(priority, entity_master_id, entity_name)
           			   		 		  on         tab.entity_id = em.entity_master_id
           		       		 		  order by article_id) as tab1
                       			where slno between $1 and $2
                      		   ) row
                		 )'
	 into v_articlejsonarr
     using v_fromrownumber, v_torownumber;
     
     foreach v_articlejson in array v_articlejsonarr
     loop
     	v_json := v_json||v_articlejson||',';
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1))||']}';
     
     p_articlejson := v_json::jsonb;
     
     drop table v_articlejsondata;
     
exception
	when others then
     	p_articlecount := -1;
          p_articlejson := '{"items":[{"error":"no record"}]}';
     
end;

$_$;


--
