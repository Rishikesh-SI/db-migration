-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_article_listing_test(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric)
-- Type: FUNCTION

-- Name: swa_get_article_listing_test(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_article_listing_test(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, p_createdby numeric, p_content_source_id numeric, OUT p_articlecount numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_column_name text;
	v_authorquery text := ' ';
	v_draftcreatedbyquery text := ' ';
    v_articlecreatedbyquery text := ' ';
	v_searchdraftquery text := ' ';
    v_searcharticlequery text := ' ';
	v_fromtodatequery text:= ' ';
	v_contentsourcequery text := ' ';
	v_entitycount numeric;
	v_assetidarr numeric[];
	v_assetfilterquery text := ' ';
	v_searchkeyword text := upper(p_searchkeyword);
	v_article_json json;
	v_sorting_column text;
	v_assets_json json;
	
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if p_authorid is not null then
    	if p_status = 0 then
        	v_column_name := 'ad.asset_id';
		else
			v_column_name := 'ad.article_id';
		end if;
        v_authorquery := ' and exists(select 1 from swa.swa_author_action aa
        								where aa.asset_id = '||v_column_name||' and aa.action_id = 4 and aa.asset_type_id = 1 and aa.author_id = $3) ';
	end if;
    
	if p_createdby is not null then
		v_draftcreatedbyquery := ' and (ad.asset_data->''data''->>''created_by'')::numeric = $8';
		v_articlecreatedbyquery := ' and ad.created_by = $8';
	end if;
    
	if v_searchkeyword is not null then
		v_searchdraftquery := ' and upper(ad.asset_data->''data''->>''title'') like ''%$4%'' ';
		v_searcharticlequery := ' and upper(ad.title) like ''%$4%'' ';
	end if;
    
	if p_from_date is not null and p_to_date is not null then
		if p_status = 1 then
			v_column_name := 'ad.published_date';
		else
			v_column_name := 'ad.updated_date';
		end if;
		v_fromtodatequery := ' and '||v_column_name||' between $6 and $7 ';
	end if;
    
	if p_content_source_id is not null then
		v_contentsourcequery = ' and content_source_id = $2 ';
	end if;
    
	select count(1) into v_entitycount from (select entityid from unnest(p_entityrolemapid) u(entityid)) a;
	
	if v_entitycount > 0 then
    	
        if p_status = 0 then
        	
            execute 'with entitydata(t_json)
            			as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id from swa.swa_asset_draft ad
                        	where asset_type_id = 1
                            and version_number = (select max(version_number) from swa.swa_asset_draft adi
                            						where adi.asset_id = ad.asset_id and adi.asset_type_id = ad.asset_type_id)
							and (asset_data->''data''->>''entitydata'') is not null
                            order by ad.updated_date desc)
						select array(select asset_draft_id
                        				from(select obj->>''entity_role_map_id'', asset_draft_id
                                        		from entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
												where (obj->>''entity_role_map_id'')::numeric in (select entityid from unnest($2) u(entityid)))jd
										group by asset_draft_id
										having count(1) = $3)'
			into v_assetidarr
            using null, p_entityrolemapid, v_entitycount;
            
            v_assetfilterquery := ' and ad.asset_draft_id in(select asset_draft_id from unnest($5) u(asset_draft_id))';
            
		else
        	
            v_assetfilterquery := ' and exists(select 1 from swa.swa_asset_entity_map eam
            									where eam.asset_id = ad.article_id
                                                and eam.asset_type_id = 1
                                                and eam.entity_role_map_id in (select entityid from unnest($9) u(entityid))
                                                group by eam.asset_id
                                                having count(1) = $10)';
			
		end if;
        
	end if;
    
    if p_status = 0 then
    	
        execute 'select (''{"assets":[''||string_agg((row_to_json(a))::text,'','')||'']}'')::json
        			from (select ad.asset_draft_id, row_number() over (order by ad.updated_date desc) slno
                    		from swa.swa_asset_draft ad
                            where ad.asset_type_id = 1
                            and ad.version_number = (select max(ad1.version_number) from swa.swa_asset_draft ad1
                            							where ad1.asset_id = ad.asset_id
                                                        and ad1.asset_type_id = ad.asset_type_id)
							and ((exists (select a.article_id from swa.swa_article a
                            				where a.article_id = ad.asset_id and a.is_published = 0 and a.is_trashed = 0 '||v_contentsourcequery||' ))
									or (ad.version_number > (select max(a.published_version_number) from swa.swa_article a
                                    							where a.article_id = ad.asset_id '||v_contentsourcequery||' )))'
							||v_authorquery
                            ||v_searchdraftquery
                            ||v_assetfilterquery
                            ||v_fromtodatequery
                            ||v_draftcreatedbyquery
                            ||' order by ad.updated_date desc) a'
		into v_assets_json
        using null, p_content_source_id, p_authorid, v_searchkeyword, v_assetidarr, p_from_date, p_to_date, p_createdby;
		
        execute 'select (''{"articles":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
        			from (select ad.asset_id article_id, (asset_data->''data''->>''title'') title, (asset_data->''data''->>''guid'') article_guid,
                    				(asset_data->''data''->>''status'') is_published, ad.created_date, ad.updated_date, ad.version_number,
                                    (asset_data->''data''->>''slug_url'') title_alias
							from swa.swa_asset_draft ad
                            where ad.asset_draft_id in(select asset_draft_id
                            							from (select (json_array_elements(a->''assets'')->>''asset_draft_id'')::numeric asset_draft_id,
                                                        				(json_array_elements(a->''assets'')->>''slno'')::numeric slno
																from (select $2 as a) b) c
														where slno between $3 and $4)) row'
		into v_article_json
        using null, v_assets_json, v_fromrownumber, v_torownumber;
		
	elsif p_status in(1, 2) then
    	
        execute 'select (''{"assets":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
        			from (select *
                    		from (select ad.article_id,row_number() over(order by case '||p_status||' when 1 then ad.published_date else ad.updated_date end desc) slno
                            		from swa.swa_article as ad
                                    join swa.swa_asset_entity_map aem
                                    on aem.asset_id = ad.article_id
                                    and aem.asset_type_id = 1
                                    where ad.is_published = case '||p_status||' when 1 then 1 else 0 end
                                    and ad.is_trashed = case '||p_status||' when 1 then 0 else 1 end
                                    and aem.priority = 1 '
                                    ||v_authorquery
                                    ||v_searcharticlequery
                                    ||v_assetfilterquery
                                    ||v_fromtodatequery
                                    ||v_articlecreatedbyquery
                                    ||v_contentsourcequery
                                    ||') a) row'
		into v_assets_json
        using null, p_content_source_id, p_authorid, v_searchkeyword, v_assetidarr, p_from_date, p_to_date, p_createdby, p_entityrolemapid, v_entitycount;
        
        execute 'select (''{"articles":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
        			from (select article_id, title, article_guid, ad.is_published, ad.created_date, ad.updated_date,
                    				published_version_number version_number, ad.title_alias,
                                    row_number() over(order by case '||p_status||' when 1 then ad.published_date else ad.updated_date end desc) slno
							from swa.swa_article as ad
                            where article_id in(select article_id
                            					from (select (json_array_elements(a->''assets'')->>''article_id'')::numeric article_id,
                                                				(json_array_elements(a->''assets'')->>''slno'')::numeric slno
														from (select $2 as a) b) c
												where slno between $3 and $4)) row'
		into v_article_json
		using null, v_assets_json, v_fromrownumber, v_torownumber;
		
	end if;
    
    select coalesce(json_array_length((a->>'assets')::json),0) from (select v_assets_json as a) b into p_articlecount;
    select case when p_status in(0, 2) then 'a.updated_date' else 'a.published_date' end into v_sorting_column;
    
    execute 'select (''{"items":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
    			from (select tab.article_id,tab.title,tab.article_guid as guid,tab.status,tab.created_date,tab.updated_date modified_date,
                				a.published_date,tab.version_number,u2.user_id edited_by,u2.display_name edited_by_name,a.content_source_id,
                                split_part(string_agg(u.user_id::varchar,'',''),'','',1) created_by,tab.title_alias,a.checked_out_by,slno,
                                split_part(string_agg(u.display_name,'',''),'','',1) created_by_name,u1.display_name as checked_out_by_name,
                                (select array_to_json(array_agg(a))
                                	from (select erm.priority, erm.entity_role_map_id, em.entity_name
                                    		from swa.swa_entity_master em
                                            join swa.swa_entity_role_map erm
                                            on erm.entity_master_id = em.entity_master_id
                                            join swa.swa_asset_entity_map aem
                                            on aem.entity_role_map_id = erm.entity_role_map_id
                                            and aem.asset_id = tab.article_id
                                            and aem.asset_type_id = 1
                                            limit 1)a)as entitydata
						from (select (json_array_elements(a->''articles'')->>''article_id'')::numeric article_id,
                        				(json_array_elements(a->''articles'')->>''title'') title,
                                        (json_array_elements(a->''articles'')->>''article_guid'') article_guid,
                                        (json_array_elements(a->''articles'')->>''is_published'') status,
                                        (json_array_elements(a->''articles'')->>''created_date'') created_date,
                                        (json_array_elements(a->''articles'')->>''updated_date'') updated_date,
                                        (json_array_elements(a->''articles'')->>''version_number'') version_number,
                                        (json_array_elements(a->''articles'')->>''title_alias'') title_alias,
                                        (json_array_elements(a->''articles'')->>''slno'')::numeric slno
								from (select $2 as a) b) tab
                                join swa.swa_article a
                                on   tab.article_id = a.article_id
                                join swa.swa_author_action aa
                                on aa.asset_type_id = 1
                                and aa.asset_id = a.article_id
								and aa.action_id = 4
								join swa.swa_user u
								on   u.user_id = aa.author_id
								join swa.swa_user u2
								on u2.user_id = a.created_by
								left join swa.swa_user u1
								on u1.user_id = a.checked_out_by
								group by tab.article_id,tab.title,tab.article_guid,tab.status,tab.created_date,tab.updated_date,a.published_date,
                                			tab.version_number,a.content_source_id,tab.title_alias,a.checked_out_by,u2.user_id,u2.display_name,
											u1.display_name,$3,slno
								order by $3 desc) row'
	into    p_articlejson
    using null, v_article_json, v_sorting_column;
    
	
 /*exception
	
     when others then
      	p_articlecount := -1;
          p_articlejson  := '{"items":[]}';*/
     
end;

$_$;


--
