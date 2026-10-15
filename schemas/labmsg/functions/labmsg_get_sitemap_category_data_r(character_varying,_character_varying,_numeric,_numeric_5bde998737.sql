-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_get_sitemap_category_data_r(character varying, character varying, numeric, numeric, character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labmsg_get_sitemap_category_data_r(character varying, character varying, numeric, numeric, character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_get_sitemap_category_data_r(p_schema_prefix character varying, p_language_url character varying, p_sitemap_category_id numeric, p_time numeric, p_asset_type_id character varying, p_page_number numeric, p_item_number numeric, p_content_source_id numeric, OUT p_sitemap_category_data_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	
	v_language_url character varying := coalesce(p_language_url,' ');
	v_language_entity_role_map_id numeric;
	v_page_language_filter_query text := ' ';
	v_is_content_asset numeric;
	v_asset_type_id character varying(10);
	v_entity_role_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_time numeric := coalesce(p_time, 48);
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_content_source_id numeric := p_content_source_id;
	v_content_source_filter_query text := ' ';
	v_language_filter_query text := ' ';
	
begin
	
	if p_page_number is not null and p_item_number is not null then
		v_from_row_number := ((p_page_number - 1) * p_item_number) + 1;
		v_to_row_number := p_page_number * p_item_number;
	else
		v_from_row_number := 1;
		v_to_row_number := coalesce(p_item_number, 50000);
	end if;
	
	execute 'select erm.entity_role_map_id
			from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
			on erm.entity_master_id = em.entity_master_id
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
			on ec.entity_role_id = erm.entity_role_id
			where coalesce(em.canonical_url,'''||' '||''') = '''||replace(v_language_url,'/','')||'''
			and ec.category_name = '''||'Language'||''''
	into v_language_entity_role_map_id;
	
	
	
	--- where coalesce(em.canonical_url,'''||' '||''') = '''||case v_language_url when ' ' then v_language_url else '/'||v_language_url end||'''
	
	-- raise notice 'v_language_entity_role_map_id %',v_language_entity_role_map_id;
	
	if v_language_entity_role_map_id is not null 
	and p_schema_prefix <> 'yho' then
		
		v_page_language_filter_query := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
											where aem.asset_id = p.page_id
											and aem.asset_type_id = 11
											and aem.entity_role_map_id = '||v_language_entity_role_map_id||')';
		
	end if;
	
	if v_language_entity_role_map_id is not null then
		v_language_filter_query := ' and aem.entity_role_map_id = '||v_language_entity_role_map_id;
	end if;
		
	if v_content_source_id is not null then
    		
		v_content_source_filter_query := ' and (al.web_detail_jsn->''data''->>''content_source_id'')::text::numeric = '||v_content_source_id||'';
		
	end if;
	
	select sc.is_content_asset, coalesce(p_asset_type_id,sc.asset_type_id), cscm.entity_role_id
	into v_is_content_asset, v_asset_type_id, v_entity_role_id 
	from siwaf.siwaf_sitemap_category sc
	join siwaf.siwaf_client_sitemap_category_map cscm
	on cscm.sitemap_category_id = sc.category_id
	where cscm.client_code = p_schema_prefix
	and category_id = p_sitemap_category_id;
	
	if v_is_content_asset = 1 then
		
		if p_sitemap_category_id = 3 then
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select al.asset_title as title, al.title_alias, al.updated_date,
								lower(replace(pem.entity_url,'' '',''-'')) primary_entity_name,
								lower(replace(sem.entity_url,'' '',''-'')) secondary_entity_name,
								al.image_path||al.image_file_name as thumbnail_image, i.image_caption,
								row_number() over(order by al.published_date desc) slno
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
							on aem.asset_id = al.asset_id
							and aem.asset_type_id = al.asset_type_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
							on perm.entity_role_map_id = al.primary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
							on pem.entity_master_id = perm.entity_master_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
							on serm.entity_role_map_id = al.secondary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
							on sem.entity_master_id = serm.entity_master_id
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_album_asset_map aam
							on aam.album_id = al.asset_id
							and al.asset_type_id = 2
							and aam.is_cover = 1
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
							on i.image_id = aam.asset_id
							and aam.asset_type_id = 3
							where al.asset_type_id in(select asset_type_id::numeric
													from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
							'||v_language_filter_query||
							' and al.published_date <= '''||v_current_timestamp||'''
          					and al.is_published = 1 '
                        			||v_content_source_filter_query||
						')row
					where slno between '||v_from_row_number||' and '||v_to_row_number
			into p_sitemap_category_data_json;
			
			
			
			
		else
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select al.asset_title as title, al.title_alias, al.updated_date,
								lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
								lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name,
								al.image_path||al.image_file_name as thumbnail_image, i.image_caption,
								CP.content_provider_name as publisher,
								(select string_agg(em2.entity_name,'','') from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem1
								left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm2 on aem1.entity_role_map_id = erm2.entity_role_map_id
								left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em2 on erm2.entity_master_id = em2.entity_master_id 
								where asset_id = al.asset_id and asset_type_id = al.asset_type_id) entities
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
							on aem.asset_id = al.asset_id
							and aem.asset_type_id = al.asset_type_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
							on perm.entity_role_map_id = al.primary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
							on pem.entity_master_id = perm.entity_master_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
							on serm.entity_role_map_id = al.secondary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
							on sem.entity_master_id = serm.entity_master_id
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_album_asset_map aam
							on aam.album_id = al.asset_id
							and al.asset_type_id = 2
							and aam.is_cover = 1
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
							on i.image_id = aam.asset_id
							and aam.asset_type_id = 3
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_provider_author_map PAM
							on al.author_id = PAM.author_id
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_content_provider CP
							on PAM.content_provider_id = CP.content_provider_id
							where al.asset_type_id in(select asset_type_id::numeric
													from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
							'||v_language_filter_query||
							' and al.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
          					  and al.published_date <= '''||v_current_timestamp||'''
          					and al.is_published = 1 '
                        			||v_content_source_filter_query||
							' order by al.published_date desc)row'
			into p_sitemap_category_data_json;
			
		end if;
		
	else
		
		if p_sitemap_category_id = 1 then
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select p.alias as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 0
							and p.scheduled_publish <= '''||v_current_timestamp||''''
							||v_page_language_filter_query
							||') row'
			into p_sitemap_category_data_json;
			
			if p_sitemap_category_data_json is null and v_language_entity_role_map_id is not null then
				
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select p.alias as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 0
							and p.language_entity_role_map_id = '||v_language_entity_role_map_id||'
							and p.scheduled_publish <= '''||v_current_timestamp||''') row'
				into p_sitemap_category_data_json;
				
			end if;
			
		elsif p_sitemap_category_id = 12 then
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select ''amp/''||title_alias as title_alias 
					      from (select meta_info->>''amp_alias'' as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 1
							and p.scheduled_publish <= '''||v_current_timestamp||''''
							||v_page_language_filter_query
							||')b
							) row'
			into p_sitemap_category_data_json;
			
			if p_sitemap_category_data_json is null and v_language_entity_role_map_id is not null then
				
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select ''amp/''||title_alias as title_alias 
					      from
					       (select meta_info->>''amp_alias'' title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 1
							and p.language_entity_role_map_id = '||v_language_entity_role_map_id||'
							and p.scheduled_publish <= '''||v_current_timestamp||''') b
							)row'
				into p_sitemap_category_data_json;
				
			end if;	
			
		elsif p_sitemap_category_id in(4,5,8,9,10,11) then
			
			if p_schema_prefix='labyho' then 
			 if p_sitemap_category_id =4 then 
			 execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (
			 select * from 
			(select entity_name, url||''/''||alias  as title_alias, 
			updated_date,url||''/''||alias as canonical_url,row_number() over() slno
							from (select entity_name,
								  em.canonical_url, 
								  em.updated_date, 
								   ''teams/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.source_object_id as url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id = '||v_entity_role_id||'
								)tab
								cross join (select substring(a.alias,''\/([a-z0-9\-]+)'')  as alias from '||p_schema_prefix||'.'||p_schema_prefix||'_page a
											join '||p_schema_prefix||'.'||p_schema_prefix||'_page b on b.page_id=a.parent_id
										    where b.alias= ''teams''
										   and a.is_active=1 and a.is_deleted=0 
											and a.is_published=1
											and  a.title !=''Teams Tabs'') row
										) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
										)row'
									into p_sitemap_category_data_json	;
										
			 elsif p_sitemap_category_id = 5 then   
			 
			 
			 execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (
			 select * from 
			(select entity_name, url||(case when  alias ='' '' then coalesce(alias,'''') 
           else ''/''||coalesce(alias,'''') end )  as title_alias, 
			updated_date,url||(case when  alias is null then ''/''||coalesce(alias,'''') 
           else coalesce(alias,'''') end ) as canonical_url,
		   row_number() over() slno
							from (select entity_name,
								  em.canonical_url, 
								  em.updated_date, 
								   ''players/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.source_object_id as url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id = '||v_entity_role_id||'
								)tab
								cross join (select coalesce(substring(a.alias,''\/([a-z0-9\-]+)''),'' '') as alias from '||p_schema_prefix||'.'||p_schema_prefix||'_page a
											join '||p_schema_prefix||'.'||p_schema_prefix||'_page b on b.page_id=a.parent_id
										    where b.alias= ''players''
										   and a.is_active=1 and a.is_deleted=0 
											and a.is_published=1) row
										) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
										)row'
									into p_sitemap_category_data_json	;
			
			elsif p_sitemap_category_id = 10 then 
				
					execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
							from (
							 select * from 
				    	(select entity_name, url||''/fixtures-results'' as title_alias, 
							updated_date,url||''/fixtures-results'' as canonical_url,row_number() over() slno
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date, 
										   ''amp/teams/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.source_object_id as url
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = '||v_entity_role_id||'
										)tab
										
												) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
												)row'
											into p_sitemap_category_data_json	;
											
			elsif p_sitemap_category_id = 11 then   
			 
			 
					 execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
							from (
					 select * from 
					(select entity_name, url as title_alias, 
					updated_date,url as canonical_url,
				   row_number() over() slno
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date, 
										   ''amp/players/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.source_object_id as url
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = '||v_entity_role_id||'
										)tab
									
												) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
												)row'
											into p_sitemap_category_data_json	;	
									
			/*else
					execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (
			 select * from 
			(select distinct entity_name, canonical_url  as title_alias, 
			updated_date,
			canonical_url as canonical_url,
		   row_number() over(order by updated_date desc) slno
							from (select entity_name,
								  em.canonical_url, 
								  em.updated_date, 
								   ''series/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.tour_id as url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id in (4,8) and em.canonical_url is not null
								)tab
								) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
									order by slno	 )row'
						into p_sitemap_category_data_json	;*/
			elsif p_sitemap_category_id = 8 then
			
					/*execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (
			 		select * from 
					(select distinct entity_name, canonical_url  as title_alias, 
					updated_date,
					canonical_url as canonical_url,
		   			row_number() over(order by updated_date desc) slno
							from (select entity_name,
								  em.canonical_url, 
								  em.updated_date, 
								   ''series/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.tour_id as url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id in (4,8) and em.canonical_url is not null
								)tab
								) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
									order by slno	 )row'
						into p_sitemap_category_data_json	;*/
						
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select * from 
	(select title_alias,canonical_url,updated_date,row_number() over(order by updated_date desc) slno
	from (select title_alias,canonical_url,max(updated_date) as updated_date
	from (select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 4 and show_content = 1
										)tab
										cross join (select unnest (array[''standings'',''fixtures-results'',''stats'',''venues'',''timeline'',''news'',
													''photos'',''videos'']) as url) row
												) tab1
	union all
	
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 4 and show_content = 0
										)tab
										cross join (select unnest (array[''standings'',''fixtures-results'',''stats'',''venues'',''timeline'']) as url) row
												) tab1
	union all											
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 8 and show_content = 1
										)tab
										cross join (select unnest (array[''fixtures-results'',''teams'',''stats'',''venues'',''news'',
													''photos'',''videos'']) as url) row
												) tab1
	union all
	
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date				   
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 8 and show_content = 0
										)tab
										cross join (select unnest (array[''fixtures-results'',''teams'',''stats'',''venues'']) as url) row
												) tab1	
								 )tab2
								 group by 1,2
		 					 )tab3
							 where  title_alias is not null
		 					) tab4
						where slno between '||v_from_row_number||' and '||v_to_row_number||'
					    order by slno	 )row'
						into p_sitemap_category_data_json	;	
			
			else
					
					execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select * from 
	(select ''amp''||title_alias as title_alias,canonical_url ,updated_date,row_number() over(order by updated_date desc) slno
	from (select title_alias,canonical_url,max(updated_date) as updated_date
	from (select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 4 and show_data = 1
										)tab
										cross join (select unnest (array[''standings'',''fixtures-results'',''stats'',''venues'',''news'',
													''photos'',''videos'']) as url) row
												) tab1
	union all
	
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 4 and show_data = 0
										)tab
										cross join (select unnest (array[''standings'',''fixtures-results'',''stats'',''venues'']) as url) row
												) tab1
	union all											
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 8 and show_data = 1
										)tab
										cross join (select unnest (array[''fixtures-results'',''teams'',''stats'',''venues'',''news'',
													''photos'',''videos'']) as url) row
												) tab1
	union all
	
	select * from 
					(select entity_name,canonical_url||''/''||url as title_alias,
					 canonical_url||''/''||url as canonical_url ,updated_date				   
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = 8 and show_data = 0
										)tab
										cross join (select unnest (array[''fixtures-results'',''teams'',''stats'',''venues'']) as url) row
												) tab1	
								 )tab2	
								 group by 1,2
		 					 )tab3
							 where  title_alias is not null
		 					) tab4
						where slno between '||v_from_row_number||' and '||v_to_row_number||'
					    order by slno	 )row'
						into p_sitemap_category_data_json	;			
			 
			 end if;
			 
			 else
			 
			    
				if p_sitemap_category_id=4and p_schema_prefix='labsaw'  then 
				--select 1/0;
				
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
							from (
							 select * from 
				    	(select entity_name, url  as title_alias, 
							updated_date,url as canonical_url,row_number() over() slno
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date, 
										   ''cricket/scores-fixtures/''||replace(replace(replace(replace(replace(lower(entity_name),'' '',''-''),'','',''''), '''''''', ''''),''/'',''-''),''.'','''')||''-''||erm.source_object_id as url
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = '||v_entity_role_id||' and erm.source_object_id is not null
										)tab
										
												) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
												)row'
										into p_sitemap_category_data_json;		
										
               elsif p_sitemap_category_id=4 then 
				--select 1/0;
				
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
							from (
							 select * from 
				    	(select entity_name, url||''/''||alias  as title_alias, 
							updated_date,url||''/''||alias as canonical_url,row_number() over() slno
									from (select entity_name,
										  em.canonical_url, 
										  em.updated_date, 
										   ''teams/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.source_object_id as url
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id = '||v_entity_role_id||'
										)tab
										
												) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
												)row'
										into p_sitemap_category_data_json;										
				
				elsif p_sitemap_category_id=5 then 
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select 
					
					 canonical_url as title_alias, 
					
					
					updated_date
							from (
							select case when '''||p_schema_prefix||'''=''labkkr''  
					 then ''players/''||replace(lower(entity_name),'' '',''-'')||''-profile''||''-''||erm.source_object_id 
					when '''||p_schema_prefix||'''=''labtkr''  
					 then ''players/''||replace(lower(entity_name),'' '',''-'')||''-profile''||''-''||erm.source_object_id 
						when '''||p_schema_prefix||'''=''labstmp''  
					 then ''players/''||replace(lower(entity_name),'' '',''-'')||''-profile''||''-''||erm.source_object_id 

					else canonical_url end as canonical_url, em.updated_date, 
							row_number() over(order by em.updated_date desc) slno
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id = '||v_entity_role_id||'
									
									and  erm.is_active=1
								)tab
							where slno between '||v_from_row_number||' and '||v_to_row_number||
						')row'
			into p_sitemap_category_data_json;
			
			elsif p_sitemap_category_id = 888 then
			   
execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
							from (
							 select * from 
				    	(select entity_name, url  as title_alias, 
							updated_date,url as canonical_url,row_number() over() slno
									from (select DISTINCT on (url)
									      entity_name,
										  --em.canonical_url, 
										  em.updated_date, 
										   --erm.tour_id,
										   ''cricket''||em.canonical_url||''/scores-fixtures'' as url
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
											on em.entity_master_id = erm.entity_master_id
											where entity_role_id in(6,28,31) and erm.source_object_id is not null
											and em.canonical_url is not null and em.canonical_url!=''null''
											and em.show_data=1
											group by  
											entity_name,--em.canonical_url,
											em.updated_date,--erm.tour_id,
											url
											 
											
										)tab
										
									) tab1 where slno between '||v_from_row_number||' and '||v_to_row_number||'
												
								)row'
										into p_sitemap_category_data_json;	
			end if;
			end if;
			
		elsif p_sitemap_category_id = 6 then	
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (
											   
						   select * from (
select match_id,sitemap_url,match_end_date,created_date,
row_number() over (order by created_date) as rn
						  from siwaf.siwaf_sitemap_matches
						   where client_code ='''||p_schema_prefix||''') tab1 
						   where rn between  '||v_from_row_number||' and '||v_to_row_number||'
						   )row'
		
		   into p_sitemap_category_data_json;
		   
		elsif p_sitemap_category_id = 7  then 
		
		-- select 1/0;
		execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from ( 
					select unaccent(title_alias) as title_alias from (
					select 
		       ''topic/''||replace(lower(entity_name),'' '',''-'')||''-''||erm.entity_role_map_id   as title_alias,
				(select count(1) from labsaw.labsaw_asset_list
				where tagged_entity is not null and tagged_entity@> Array[entity_role_map_id]::int[]
               -- where tagged_entity @>  string_to_array(entity_role_map_id::text,'','')::int[]
			   
			   ) as cnt
				
				from labsaw.labsaw_entity_role_map erm
				join labsaw.labsaw_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where entity_role_id in (2,24,23,13,15,4,14,11,12)
				and  erm.is_active=1 
				and source_object_id is not null)tab
				where cnt >4)row'
				into p_sitemap_category_data_json;
			
		end if;
		
	end if;
	
-- exception
--	when others then
--		p_sitemap_category_data_json := '{"data":[]}'::jsonb;

end;
$$;


--
