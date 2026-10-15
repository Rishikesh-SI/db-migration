-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_bulk_upd_asset_entity_map(numeric, numeric, numeric[], jsonb, numeric, character varying, numeric[], numeric)
-- Type: FUNCTION

-- Name: labdms_bulk_upd_asset_entity_map(numeric, numeric, numeric[], jsonb, numeric, character varying, numeric[], numeric); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_bulk_upd_asset_entity_map(p_opttype numeric, p_status numeric, p_assettypeid numeric[], p_selectedassetsjson jsonb, p_tagid numeric, p_searchfilter character varying, p_entityrolemapid numeric[], p_newtagid numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    v_searchfilter varchar(4000) := upper(p_searchfilter);
    v_searchdraftquery varchar(4000) := ' ';
    v_searchassetquery varchar(4000) := ' ';
    v_enityrolemapidcount numeric;
    v_draftenityrolemapidquery varchar(4000) := ' ';
    v_assetenityrolemapidquery varchar(4000) := ' ';
    v_assettypeidcount numeric;
    v_assettypeid numeric;
    v_andfilterquery varchar(4000) := ' ';
    v_partialquery varchar(4000) := ' ';
    v_assetquery varchar(4000) := ' ';
    v_assettypefilterquery varchar(4000) := ' ';
    v_sysdate timestamp := current_timestamp at time zone 'utc';
    v_selectedassetsjsonarr json[];
    v_selectedassetsjsonarrlength numeric;
    v_selectedassetsjson json;
    v_jsonassettypeid numeric;
    v_jsonassetidlist varchar(40000) := '';
    v_versionnumber numeric;
    v_versionnumberquery varchar(4000) := ' ';
    v_jsonassetidlistcount numeric;
    v_jsonassetidlistarr numeric[];
    v_publishedarr varchar[];
    v_publishedarrlen numeric;
    v_publishedassetdata varchar(100);
    v_publishedjson jsonb;
    v_maxversionnumber numeric;
    v_newversionnumber numeric;
    v_draftarr varchar[];
    v_draftarrlen numeric;
    v_draftassetdata varchar(100);
    v_draftjson jsonb;
    v_unpublishedarr varchar[];
    v_unpublishedarrlen numeric;
    v_unpublishedassetdata varchar(100);
    v_unpublishedjson jsonb;
    v_closingbracket char(1) := ')';
    v_tagname varchar(100);
    v_newtagname varchar(100);
    v_assetdraftid numeric;
    v_json jsonb;
    
begin
	
  	if v_searchfilter is not null then
    	v_searchfilter := replace(v_searchfilter,'''','''''');
        v_searchfilter := replace(v_searchfilter,':','');
        v_searchfilter := '*'||replace(''||v_searchfilter||'',' ',':* & *') || ':*';
      	v_searchassetquery := ' and (to_tsvector(al.asset_title) @@@ to_tsquery('''||'$3'||''')
        							 or to_tsvector(sl.short_desc) @@@ to_tsquery('''||'$3'||'''))';
  		
    end if;
    
    select count(asset_type_id)
    into   v_assettypeidcount
	from   unnest(p_assettypeid) u(asset_type_id);
    
  	select count(entity_role_map_id)
  	into   v_enityrolemapidcount
  	from   unnest(p_entityrolemapid) u(entity_role_map_id);
  	
  	if p_opttype = 1 then
  	/*option type 1(all) begins*/
    	
        if p_status = 0 then
        	
            v_assetquery := 'select array(select asset_id||''|''||asset_type_id||''|''||version_number
            				 from   labdms.labdms_asset_draft as ad
                             where  ad.version_number = (select max(ad1.version_number)
                             							 from   labdms.labdms_asset_draft as ad1
                                                         where  ad1.asset_id = ad.asset_id
                                                         and    ad1.asset_type_id = ad.asset_type_id)
                             and    (ad.asset_id, ad.asset_type_id) exists (select al.asset_id, al.asset_type_id
                             											  	from   labdms.labdms_asset_list al
                                                                          	where  al.asset_id = ad.asset_id
                                                                          	and    al.asset_type_id = ad.asset_type_id
                                                                          	and    al.is_published = (case $1 when 1 then 1 else 0 end)
                                                                          	and    al.is_trashed   = (case $1 when 1 then 0 else 1 end))';
            
            if v_assettypeidcount > 0 then
            	v_assettypefilterquery := ' and ad.asset_type_id in(select asset_type_id from unnest($2) u(asset_type_id)) ';
			end if;
            
      		if v_searchfilter is not null then
            	v_searchdraftquery := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$3'||'||''%'' ';
      		end if;
            
      		if v_enityrolemapidcount > 0 then
            	v_draftenityrolemapidquery := ' and ad.asset_id in(select asset_id
                												   from   labdms.labdms_asset_entity_map aem
                                                                   where  aem.asset_type_id = ad.asset_type_id 
                                                                   and    aem.entity_role_map_id in (select entityrolemapid
                                                                   									 from   unnest($4) u(entityrolemapid))
																   group by aem.asset_id, asset_type_id
                                                                   having count(1) = '||v_enityrolemapidcount||')';
      		end if;
            
      		execute v_assetquery
            		||v_assettypefilterquery
                    ||v_searchdraftquery
                    ||v_draftenityrolemapidquery
                    ||v_closingbracket
			using   p_status, p_assettypeid, v_searchfilter, p_entityrolemapid
            into    v_draftarr;
            
            select array_length(v_draftarr,1)
            into   v_draftarrlen;
            
            if v_draftarrlen > 0 then
            	
                for i in 1..v_draftarrlen
               	loop
                	
                    select v_draftarr[i]
                    into   v_draftassetdata;
                    
                    update labdms.labdms_asset_draft ad
                    set    asset_data = jsonb_set(asset_data, '{data,entitydata}', (replace((asset_data->'data'->>'entitydata')::text, p_tagid::text,
                                                  p_newtagid::text))::text::jsonb, false),
                    	   updated_date = v_sysdate
                    where  ad.asset_id = split_part(v_draftassetdata,'|',1)::numeric
                    and    ad.asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                    and    ad.version_number = split_part(v_draftassetdata,'|',3)::numeric;
					
                    if exists(select 1
                              from   labdms.labdms_asset_list
                              where  asset_id = split_part(v_draftassetdata,'|',1)::numeric
                              and    asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                              and    is_published = 0
                              and    is_trashed = 0) then
						
                        update labdms.labdms_asset_entity_map
                    	set    entity_role_map_id = p_newtagid,
                        	   updated_date = v_sysdate
                    	where  asset_id = split_part(v_draftassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                    	and    entity_role_map_id = p_tagid;
                        
                        update labdms.labdms_asset_list
                        set    primary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                        where  asset_id = split_part(v_draftassetdata,'|',1)::numeric
                        and    asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                        and    primary_entity_role_map_id = p_tagid;
                        
                        update labdms.labdms_asset_list
                        set    secondary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                        where  asset_id = split_part(v_draftassetdata,'|',1)::numeric
                        and    asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                        and    secondary_entity_role_map_id = p_tagid;
                        
                    end if;
                    
                end loop;
                
            end if;
            
      		insert into labdms.t_allassetdataquery
            values(v_assetquery||v_assettypefilterquery||v_searchdraftquery||v_draftenityrolemapidquery
                                                       ||v_closingbracket);
            
            p_result := 1;
            
		elsif p_status = 1 then
        	
      		v_assetquery := 'select array(select asset_id||''|''||asset_type_id||''|''||published_version_number
            				 from   labdms.labdms_asset_list as al
                             where  al.is_published = (case $1 when 1 then 1 else 0 end)
                             and    al.is_trashed   = (case $1 when 1 then 0 else 1 end)';
			
            if v_assettypeidcount > 0 then
            	v_assettypefilterquery := ' and al.asset_type_id in(select asset_type_id
                													from   unnest($2) u(asset_type_id)) ';
			end if;
            
      		if v_enityrolemapidcount > 0 then
            	v_assetenityrolemapidquery := ' and al.asset_id in(select aem.asset_id
                												   from   labdms.labdms_asset_entity_map aem
                                                                   where  aem.asset_type_id = al.asset_type_id
                                                                   and    aem.entity_role_map_id in (select entityrolemapid
                                                                   									 from   unnest($4) u(entityrolemapid))
																   group by aem.asset_id, asset_type_id
                                                                   having count(1) = '||v_enityrolemapidcount||')';
      		end if;
            
      		execute v_assetquery
                    ||v_assettypefilterquery
                    ||v_searchassetquery
                    ||v_assetenityrolemapidquery
                    ||v_closingbracket
      		using   p_status, p_assettypeid, v_searchfilter, p_entityrolemapid
            into    v_publishedarr;
            
            select array_length(v_publishedarr,1)
            into   v_publishedarrlen;
            
            if v_publishedarrlen > 0 then
            	
                for i in 1..v_publishedarrlen
               	loop
                	
                    select v_publishedarr[i]
                    into   v_publishedassetdata;
                    
                    select max(version_number)
                    into   v_maxversionnumber
                    from   labdms.labdms_asset_draft
                    where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric;
                    
                    v_newversionnumber := v_maxversionnumber + 1;
                    
                    insert into labdms.labdms_asset_draft
                    select nextval('labdms.seq_labdms_asset_draft_id'), split_part(v_publishedassetdata,'|',1)::numeric,
                    	   split_part(v_publishedassetdata,'|',2)::numeric, v_newversionnumber,
                           jsonb_set(asset_data, '{data,entitydata}', (replace((asset_data->'data'->>'entitydata')::text, p_tagid::text,
									 p_newtagid::text))::text::jsonb, false), v_sysdate, v_sysdate, ad.created_by, ad.updated_by, ad.is_active,
						   ad.is_deleted, uuid_generate_v4()
					from   labdms.labdms_asset_draft ad
                    where  ad.asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    and    ad.asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric
                    and    ad.version_number = (select published_version_number
                                                from   labdms.labdms_asset_list al
                                                where  al.asset_id = ad.asset_id
                                                and    al.asset_type_id = ad.asset_type_id);
                    
                    if split_part(v_publishedassetdata,'|',2)::numeric = 1 then
                    	
                        update labdms.labdms_article
                        set    published_version_number = v_newversionnumber,
                        	   updated_date = v_sysdate
                        where article_id = split_part(v_publishedassetdata,'|',1)::numeric;
                        
                    end if;
                    
                    if exists(select 1
                              from   labdms.labdms_asset_list
                              where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                              and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric
                              and    is_published = 1
                              and    is_trashed = 0) then
						
                        update labdms.labdms_asset_list
                    	set    published_version_number = v_newversionnumber,
                    	   	   primary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                    	where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric
                    	and    primary_entity_role_map_id = p_tagid;
                    	
                    	update labdms.labdms_asset_list
                    	set    published_version_number = v_newversionnumber,
                    	       secondary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                    	where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric
                    	and    secondary_entity_role_map_id = p_tagid;
                    	
                    	update labdms.labdms_seo_data
                    	set    published_version_number = v_newversionnumber,
                    	       updated_date = v_sysdate
                    	where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric;
                    	
                    	update labdms.labdms_asset_entity_map
                    	set    entity_role_map_id = p_newtagid,
                    	       updated_date = v_sysdate
                    	where  asset_id = split_part(v_publishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_publishedassetdata,'|',2)::numeric
                    	and    entity_role_map_id = p_tagid;
                        
					end if;
                    
                end loop;
                
            end if;
            
      		insert into labdms.t_allassetdataquery
            values(v_assetquery||v_assettypefilterquery||v_searchassetquery||v_assetenityrolemapidquery||v_closingbracket);
            
      		p_result := 1;
        	
        else
        	
            v_assetquery := 'select array(select asset_id||''|''||asset_type_id||''|''||version_number
            				 from   labdms.labdms_asset_draft as ad
                             where  ad.version_number = (select max(ad1.version_number)
                             							 from   labdms.labdms_asset_draft as ad1
                                                         where  ad1.asset_id = ad.asset_id
                                                         and    ad1.asset_type_id = ad.asset_type_id)
							 and    (ad.asset_id, ad.asset_type_id) exists (select al.asset_id, al.asset_type_id
                             											  	from   labdms.labdms_asset_list al
                                                                          	where  al.asset_id = ad.asset_id
                                                                          	and    al.asset_type_id = ad.asset_type_id
                                                                          	and    al.is_published = (case $1 when 1 then 1 else 0 end)
                                                                          	and    al.is_trashed   = (case $1 when 1 then 0 else 1 end))';
            
            if v_assettypeidcount > 0 then
            	v_assettypefilterquery := ' and al.asset_type_id in(select asset_type_id
                													from   unnest($2) u(asset_type_id)) ';
			end if;
            
            if v_searchfilter is not null then
            	v_searchdraftquery := ' and upper(ad.asset_data->'||''''||'data'||'''->>'||''''||'title'||''''||') like ''%''||'||'$3'||'||''%'' ';
      		end if;
            
      		if v_enityrolemapidcount > 0 then
            	
                v_assetenityrolemapidquery := ' and (ad.asset_id, ad.asset_type_id) exists (select aem.asset_id, aem.asset_type_id
                																			from   labdms.labdms_asset_entity_map aem
                                                                                            where  aem.asset_id = ad.asset_id
                                                                                            and    aem.asset_type_id = ad.asset_type_id
                                                                                            and    aem.entity_role_map_id in (select entityrolemapid
                                                                                            								  from   unnest($4) u(entityrolemapid))
																						    group by aem.asset_id, asset_type_id
                                                                                            having count(1) = '||v_enityrolemapidcount||')';
				
      		end if;
            
      		execute v_assetquery
                    ||v_assettypefilterquery
                    ||v_searchdraftquery
                    ||v_assetenityrolemapidquery
                    ||v_closingbracket
      		using   p_status, p_assettypeid, v_searchfilter, p_entityrolemapid
            into    v_unpublishedarr;
            
            select array_length(v_unpublishedarr,1)
            into   v_unpublishedarrlen;
            
            if v_unpublishedarrlen > 0 then
            	
                for i in 1..v_unpublishedarrlen
               	loop
                	
                    select v_unpublishedarr[i]
                    into   v_unpublishedassetdata;
                    
                    update labdms.labdms_asset_draft
                    set    asset_data = jsonb_set(asset_data, '{data,entitydata}', (replace((asset_data->'data'->>'entitydata')::text,
												  p_tagid::text, p_newtagid::text))::text::jsonb, false),
                           updated_date = v_sysdate
                    where  asset_id = split_part(v_unpublishedassetdata,'|',1)::numeric
                    and    asset_type_id = split_part(v_unpublishedassetdata,'|',2)::numeric
                    and    version_number = split_part(v_unpublishedassetdata,'|',3)::numeric;
                    
                    if split_part(v_unpublishedassetdata,'|',2)::numeric = 1 then
                    	
                        update labdms.labdms_article
                        set    published_version_number = split_part(v_unpublishedassetdata,'|',3)::numeric,
                        	   updated_date = v_sysdate
                        where article_id = split_part(v_unpublishedassetdata,'|',1)::numeric;
                        
                    end if;
                    
                    if exists(select 1
                              from   labdms.labdms_asset_list
                              where  asset_id = split_part(v_draftassetdata,'|',1)::numeric
                              and    asset_type_id = split_part(v_draftassetdata,'|',2)::numeric
                              and    is_published = 1
                              and    is_trashed = 0) then
						
                        update labdms.labdms_asset_list
                    	set    published_version_number = v_maxversionnumber,
                    	       primary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                    	where  asset_id = split_part(v_unpublishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_unpublishedassetdata,'|',2)::numeric
                    	and    primary_entity_role_map_id = p_tagid;
                    	
                    	update labdms.labdms_asset_list
                    	set    published_version_number = v_maxversionnumber,
                    	       secondary_entity_role_map_id = p_newtagid,
                               updated_date = v_sysdate
                    	where  asset_id = split_part(v_unpublishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_unpublishedassetdata,'|',2)::numeric
                    	and    secondary_entity_role_map_id = p_tagid;
                    	
                    	update labdms.labdms_seo_data
                    	set    published_version_number = v_maxversionnumber,
                    	       updated_date = v_sysdate
                    	where  asset_id = split_part(v_unpublishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_unpublishedassetdata,'|',2)::numeric;
                    	
                    	update labdms.labdms_asset_entity_map
                    	set    entity_role_map_id = p_newtagid,
                    	       updated_date = v_sysdate
                    	where  asset_id = split_part(v_unpublishedassetdata,'|',1)::numeric
                    	and    asset_type_id = split_part(v_unpublishedassetdata,'|',2)::numeric
                    	and    entity_role_map_id = p_tagid;
                        
                    end if;
                    
                end loop;
                
            end if;
            
      		insert into labdms.t_allassetdataquery
            values(v_assetquery||v_assettypefilterquery||v_searchassetquery||v_assetenityrolemapidquery||v_closingbracket);
            
      		p_result := 1;
        	
		end if;
	/*option type 1(all) ends*/
    
  	elsif p_opttype = 2 then
    /*option type 2(selected) begins*/
    
    	select array(select json_array_elements(tjson)
                     from   (select (p_selectedassetsjson->'data'->'asset_type')::json tjson) a)
		into   v_selectedassetsjsonarr;
        
        select json_array_length((p_selectedassetsjson->'data'->'asset_type')::json)
        into   v_selectedassetsjsonarrlength;
        
        if v_selectedassetsjsonarrlength > 0 then
        	
            for i in 1..v_selectedassetsjsonarrlength
      		loop
            	
                select v_selectedassetsjsonarr[i]
                into   v_selectedassetsjson;
                
                select (v_selectedassetsjson->>'asset_type_id')::numeric, (v_selectedassetsjson->>'asset_id')::varchar
                into   v_jsonassettypeid, v_jsonassetidlist;
                
                select count(asset_id::numeric),string_to_array(v_jsonassetidlist,',')::numeric[]
                into   v_jsonassetidlistcount, v_jsonassetidlistarr
                from   unnest(string_to_array(v_jsonassetidlist,',')) u(asset_id);
                
                for i in 1..v_jsonassetidlistcount
                loop
                	
                    select max(ad.version_number)
                    into   v_maxversionnumber
                    from   labdms.labdms_asset_draft ad
                    where  ad.asset_id = v_jsonassetidlistarr[i]
                    and    ad.asset_type_id = v_jsonassettypeid;
                    
                    select em.entity_name
                    into   v_tagname
                    from   labdms.labdms_entity_master em
                    join   labdms.labdms_entity_role_map erm
                    on     erm.entity_master_id = em.entity_master_id
                    where  erm.entity_role_map_id = p_tagid;
                    
                    select em.entity_name
                    into   v_newtagname
                    from   labdms.labdms_entity_master em
                    join   labdms.labdms_entity_role_map erm
                    on     erm.entity_master_id = em.entity_master_id
                    where  erm.entity_role_map_id = p_newtagid;
                    
                    if p_status in (0, 2) then
                    	
                        v_newversionnumber := v_maxversionnumber;
                        
                        select asset_draft_id, asset_data
                        into   v_assetdraftid, v_json
                        from   labdms.labdms_asset_draft
                        where  asset_id = v_jsonassetidlistarr[i]
                    	and    asset_type_id = v_jsonassettypeid
                    	and    version_number = v_maxversionnumber;
                        
                        v_json := jsonb_set(v_json, '{data,entitydata}', (replace((v_json->'data'->>'entitydata')::text, p_tagid::text,
											p_newtagid::text))::text::jsonb, false);
						
                        v_json := jsonb_set(v_json, '{data,entitydata}', (replace((v_json->'data'->>'entitydata')::text, v_tagname::text,
											v_newtagname::text))::text::jsonb, false);
                        
                        update labdms.labdms_asset_draft
                    	set    asset_data = v_json,
                    		   updated_date = v_sysdate
                    	where  asset_draft_id = v_assetdraftid;
                        
					else
                    	
                    	v_newversionnumber := v_maxversionnumber + 1;
                        
                        select ad.asset_draft_id, ad.asset_data
                        into   v_assetdraftid, v_json
                        from   labdms.labdms_asset_draft ad
                        where  ad.asset_id = v_jsonassetidlistarr[i]
                    	and    ad.asset_type_id = v_jsonassettypeid
                    	and    ad.version_number = (select published_version_number
                                                    from   labdms.labdms_asset_list al
                                                    where   al.asset_id = ad.asset_id
                                                    and al.asset_type_id = ad.asset_type_id);
                        
                        v_json := jsonb_set(v_json, '{data,entitydata}', (replace((v_json->'data'->>'entitydata')::text, p_tagid::text,
											p_newtagid::text))::text::jsonb, false);
						
                        v_json := jsonb_set(v_json, '{data,entitydata}', (replace((v_json->'data'->>'entitydata')::text, v_tagname::text,
											v_newtagname::text))::text::jsonb, false);
                        
                    	insert into labdms.labdms_asset_draft
                    	select nextval('labdms.seq_labdms_asset_draft_id'), v_jsonassetidlistarr[i], v_jsonassettypeid, v_newversionnumber,
                        	   v_json, v_sysdate, v_sysdate, ad.created_by, ad.updated_by, ad.is_active, ad.is_deleted, uuid_generate_v4()
						from   labdms.labdms_asset_draft ad
                    	where  ad.asset_draft_id = v_assetdraftid;
						
					end if;
                    
                    if exists(select 1
                              from   labdms.labdms_asset_list
                              where  asset_id = v_jsonassetidlistarr[i]
                              and    asset_type_id = v_jsonassettypeid
                              and    is_published = (case p_status when 1 then 1 else 0 end)
                              and    is_trashed = (case p_status when 1 then 0 else 1 end)) then
						
                        update labdms.labdms_asset_entity_map
                        set    entity_role_map_id = p_newtagid,
                        	   updated_date = v_sysdate
						where  asset_id = v_jsonassetidlistarr[i]
                        and    asset_type_id = v_jsonassettypeid
                        and    entity_role_map_id = p_tagid;
                        
                        update labdms.labdms_asset_list
                        set    primary_entity_role_map_id = p_newtagid,
                        	   published_version_number = v_newversionnumber,
                        	   updated_date = v_sysdate
						where  asset_id = v_jsonassetidlistarr[i]
                        and    asset_type_id = v_jsonassettypeid
                        and    primary_entity_role_map_id = p_tagid;
                        
                        update labdms.labdms_asset_list
                        set    secondary_entity_role_map_id = p_newtagid,
                        	   published_version_number = v_newversionnumber,
                        	   updated_date = v_sysdate
						where  asset_id = v_jsonassetidlistarr[i]
                        and    asset_type_id = v_jsonassettypeid
                        and    secondary_entity_role_map_id = p_tagid;
                        
                        update labdms.labdms_seo_data
                        set    published_version_number = v_newversionnumber,
                        	   updated_date = v_sysdate
						where  asset_id = v_jsonassetidlistarr[i]
                        and    asset_type_id = v_jsonassettypeid;
                        
					end if;
                    
                    if p_status = 1 then
                    	
                        if v_jsonassettypeid = 1 then
                    		
                        	update labdms.labdms_article
                        	set    published_version_number = v_newversionnumber,
                        	   	   updated_date = v_sysdate
							where  article_id = v_jsonassetidlistarr[i];
                            
						elsif v_jsonassettypeid = 2 then
                        	
                            update labdms.labdms_album
                        	set    published_version_number = v_newversionnumber,
                        	   	   updated_date = v_sysdate
							where  album_id = v_jsonassetidlistarr[i];
                            
                        elsif v_jsonassettypeid = 4 then
                        	
                            update labdms.labdms_video
                        	set    published_version_number = v_newversionnumber,
                        	   	   updated_date = v_sysdate
							where  video_id = v_jsonassetidlistarr[i];
                            
                        end if;
                        
					end if;
                    
				end loop;
                
      		end loop;
            
		end if;
        
  		p_result := 1;
        
	end if;
  	/*option type 2(selected) ends*/
    
/*exception
	when others then
     	p_result := -1;*/
        
end;

 $_$;


--
