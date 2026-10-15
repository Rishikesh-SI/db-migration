-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_album_listing(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: swa_get_album_listing(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_album_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_albumcount numeric, OUT p_albumjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	  v_draftcreatedbyquery   varchar(500) := ' ';
    v_assetcreatedbyquery varchar(500) := ' ';
    v_searchkeyword varchar(4000) := upper(p_searchkeyword);
    v_searchdraftquery varchar(200) := ' ';
    v_searchalbumquery varchar(200) := ' ';
	  v_draftalbumcount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias varchar(4000);
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_albumcount numeric := 0;
	  v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_albumjsonarr jsonb[];
    v_albumjson jsonb;
    v_json varchar(30000) := '{"items":[';
    v_album_count numeric:=0;
    v_asset_type_id numeric:=2;
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_authorid is not null then
     	
           v_draftcreatedbyquery   := ' and adv.asset_id in(select asset_id
          									    from swa.swa_author_action
                                                           where action_id = 4
                                                           and asset_type_id = '||v_asset_type_id||'
                                                           and author_id = $1) ';
		
     	v_assetcreatedbyquery := ' and adv.album_id in(select asset_id
          										 from swa.swa_author_action
                                                             where action_id = 4
                                                             and asset_type_id = '||v_asset_type_id||'
                                                             and author_id = $1) ';
		
  	end if;
     
     if v_searchkeyword is not null then
     	
          v_searchdraftquery   := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$2'||'||''%'' ';
          v_searchalbumquery := ' and upper(title) like ''%''||'||'$2'||'||''%'' ';
          
  	end if;
     
     create temp table if not exists v_albumjsondata
    (
        album_id numeric,
        title varchar(4000),
        album_guid varchar(256),
        status varchar(256),
        entity_id numeric,
        created_date timestamp,
        modified_date timestamp,
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
		    	    and    ((exists (select album_id
                                     						 from   swa.swa_album a
                                                                  where 
                                                          a.album_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from swa.swa_album
                                                                      where album_id = adv.asset_id)))'
             	    ||v_draftcreatedbyquery
                   ||v_searchdraftquery
    		into    v_draftalbumcount
     	using   p_authorid, v_searchkeyword;
          
     	execute 'select array(select asset_draft_id
				  from   (select row_number() over(order by adv.updated_date desc) slno, asset_draft_id
                      		from   swa.swa_asset_draft as adv
                              where  adv.asset_type_id  = ' || v_asset_type_id || '
                              and    adv.version_number = (select max(ad1.version_number)
          	    						   from   swa.swa_asset_draft as ad1
               	                            where  ad1.asset_id = adv.asset_id
                                                and ad1.asset_type_id = adv.asset_type_id)
		    	    and    ((exists (select album_id
                                     						 from   swa.swa_album a
                                                                  where 
                                                          a.album_id = adv.asset_id
                                                              and is_published = 0
                                                           and is_trashed = 0))
					  				or (adv.version_number > (select max(published_version_number)
                                             					from swa.swa_album
                                                                      where album_id = adv.asset_id)))'
                              ||v_draftcreatedbyquery
                              ||v_searchdraftquery
                              ||') tab
                      where  slno between '||'$3'||' and '||'$4'||')'
    		into    v_assetdraftidarr
    		using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
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
					
                         if v_entitymasterid is not null and v_priority = 1 then
                         	
                              insert into v_albumjsondata
							  select ad.asset_id , v_titlealias, (asset_data->'data'->'guid'), (asset_data->'data'->'status')::varchar
                , v_entitymasterid, ad.created_date, ad.updated_date,ad.version_number
							  from   swa.swa_asset_draft ad
							  join   swa.swa_album a
							  on ad.asset_id=a.album_id
							  where  asset_draft_id = v_assetdraftid;
                         
                         end if;
                         
        			end loop;
                    
               else
               	
                    insert into v_albumjsondata
					select ad.asset_id , v_titlealias, (asset_data->'data'->'guid'), a.IS_PUBLISHED, null, ad.created_date, ad.updated_date,ad.version_number
					from   swa.swa_asset_draft ad
					join   swa.swa_album a
					on ad.asset_id=a.album_id
					where  asset_draft_id = v_assetdraftid;
                    
      		end if;
               
    		end loop;
			
     elsif p_status = 1 then
     	
          execute 'select count(1)
          	    from   swa.swa_album as adv
                   where  is_published = 1
                   and    is_trashed   = 0'
                   ||v_assetcreatedbyquery
                   ||v_searchalbumquery
          into    v_albumcount
          using   p_authorid, v_searchkeyword;
          
          execute 'insert into v_albumjsondata
          	    select album_id, title, album_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(
                   select row_number() over(order by adv.updated_date desc) slno, album_id, title, album_guid, adv.is_published,
                   entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   from   swa.swa_album as adv
                   join   swa.swa_asset_entity_map aem
                   on     aem.asset_id = adv.album_id
                   and    aem.asset_type_id      = ' || v_asset_type_id || '
                   join   swa.swa_entity_role_map erm
                   on     erm.entity_role_map_id = aem.entity_role_map_id
                   where  adv.is_published       = 1
                   and    adv.is_trashed         = 0
                   and    aem.priority           = 1'
                   ||v_assetcreatedbyquery
                   ||v_searchalbumquery
                   ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	else
     	
          execute 'select count(1)
          	    from   swa.swa_album adv
                   where  is_published = 0
                   and    is_trashed   = 1'
                   ||v_assetcreatedbyquery
                   ||v_searchalbumquery
          into    v_albumcount
          using   p_authorid, v_searchkeyword;
          
    		execute 'insert into v_albumjsondata
          	    select album_id, title, album_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                   from(
                   select row_number() over(order by adv.updated_date desc) slno, album_id, title, album_guid, adv.is_published, entity_master_id, adv.created_date, adv.updated_date, published_version_number
                   from   swa.swa_album as adv
                   join   swa.swa_asset_entity_map aem
                   on     aem.asset_id = adv.album_id
                   and    aem.asset_type_id      = ' || v_asset_type_id || '
                   join   swa.swa_entity_role_map erm
                   on     erm.entity_role_map_id = aem.entity_role_map_id
                   where  adv.is_published       = 0
                   and    adv.is_trashed         = 1
                   and    aem.priority           = 1'
                   ||v_assetcreatedbyquery
                   ||v_searchalbumquery
                   ||') tab
                   where  slno between '||'$3'||' and '||'$4'
          using   p_authorid, v_searchkeyword, v_fromrownumber, v_torownumber;
          
  	end if;
     
  	p_albumcount := v_draftalbumcount + v_albumcount;
     
  	execute 'select array(select row_to_json(row) as jsonrow
				  from (select tab.album_id, tab.title, tab.album_guid as guid, tab.status, tab.created_date,
                      	   tab.created_date modified_date,adv.published_date, tab.version_number,u.user_id created_by, 
                            u.user_name created_by_name,adv.total_assets, adv.cover_image, i.image_file_name, i.image_path,
                            em as entitydata, adv.title_alias
                      	   from   v_albumjsondata as tab
                            join   swa.swa_album adv
                            on     tab.album_id = adv.album_id
                            left join   swa.swa_image i
                            on     i.image_id = adv.cover_image::numeric
                            join 	swa.swa_user u
                            on	u.user_id=adv.created_by
                            left join (select 1 as priority, erm.entity_role_map_id, emi.entity_name
                            		    from   swa.swa_entity_master emi
                                       join   swa.swa_entity_role_map erm
                                       on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name)
					   on     tab.entity_id = em.entity_role_map_id
                            order by adv.updated_date desc) row
                      )'
	into    v_albumjsonarr;
     
     foreach v_albumjson in array v_albumjsonarr
     loop
     	
          v_json := v_json||v_albumjson||',';
          
  	end loop;
     
     select count(1)
    	into   v_album_count
    	from   unnest(v_albumjsonarr) album_id;
     
     if v_album_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json      := v_json||']}';
     p_albumjson := v_json::jsonb;
     
  	drop table v_albumjsondata;
     
/*exception
	
     when others then
     	p_albumcount := -1;
          p_albumjson  := '{"items":[]}';*/
     
end;

$_$;


--
