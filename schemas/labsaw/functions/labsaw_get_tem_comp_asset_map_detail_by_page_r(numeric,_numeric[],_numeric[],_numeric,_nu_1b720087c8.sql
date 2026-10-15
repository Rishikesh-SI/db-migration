-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_tem_comp_asset_map_detail_by_page_r(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labsaw_get_tem_comp_asset_map_detail_by_page_r(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_tem_comp_asset_map_detail_by_page_r(p_asset_id numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_use_fallback numeric, p_showcase_cur refcursor, p_showcase_ent_cur refcursor, p_showcase_asset_author_cur refcursor, p_template_comp_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from labsaw.labsaw_get_tem_comp_asset_map_detail_by_page_r(
	482,-- <p_asset_id numeric>, 
	array[35369],-- <p_entityrole_mapid numeric[]>, 
	null,-- <p_any_entityrole_mapid numeric[]>, 
	41,-- <p_pagenumber numeric>, 
	21,-- <p_itemnumber numeric>, 
	21,-- <p_page1_size numeric>, 
	1,-- <p_use_fallback numeric>, 
	'a',-- <p_showcase_cur refcursor>, 
	'b',-- <p_showcase_ent_cur refcursor>, 
	'c',-- <p_showcase_asset_author_cur refcursor>, 
	'd'-- <p_template_comp_cur refcursor>
);
fetch all in "a";
*/

declare
	
    v_sysdate timestamp := current_timestamp at time zone 'utc';
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_itemnumber numeric;
    v_ent_count numeric;
    v_str_entityrole_mapid text;
    v_str_any_entityrole_mapid text;
    v_language_id numeric;
    v_tagged_assets_json json;
    v_total_tagged_assets_json json;
    v_tagged_assets_count numeric;
    v_req_asset_count numeric;
    v_fallback_assets_json json;
    v_total_assets numeric;
    v_fallback_assets_count numeric := 0 ;
    v_a numeric;
    v_b numeric;
    v_c numeric;
    v_time numeric;
    v_fallback_start numeric;
	-----
	
	v_entity_count numeric;
	v_other_entity_count numeric;
	v_entity_filter_query_al text := ' ';
	v_entity_filter_query_tcam text := ' ';
	v_other_entity_filter_query_al text := ' ';
	v_other_entity_filter_query_tcam text := ' ';
	v_exclude_entity_filter_query_al text := ' ';
	v_exclude_entity_filter_query_tcam text := ' ';
	v_assets_count numeric;
   -- v_assets_count numeric;
	v_assets_json jsonb;
	v_showcase_asset_json jsonb;
	v_showcase_json jsonb;
	v_entity_filter_query_tcam1 text:=' ';
	v_fallback_query text :=' ';
	p_schema_prefix text:='labsaw';
begin
	
    if p_page1_size is null
    then
    	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber := (p_pagenumber * p_itemnumber);
        v_itemnumber := p_itemnumber;
	else
    	if p_pagenumber = 1 then
        	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
            v_itemnumber := p_page1_size;
		else
        	v_fromrownumber := p_page1_size + ((((p_pagenumber - 1) * p_itemnumber) - (p_itemnumber - 1)));
            v_itemnumber := p_itemnumber;
		end if;
        v_torownumber := p_page1_size + ((p_pagenumber - 1) * p_itemnumber);
        end if;
	
		if p_use_fallback = 0 then
		v_fallback_query := ' where is_fallback = $3 ';
		end if;
	
		select array_length(p_entityrole_mapid, 1), array_length(p_any_entityrole_mapid, 1)
		into v_entity_count, v_other_entity_count;
	
	  
	   
		if v_entity_count > 0 then
		
		v_entity_filter_query_al := ' and al.tagged_entity @> $1 ';
		
		v_entity_filter_query_tcam := ' and exists(select 1
										from labsaw.labsaw_asset_entity_map aem
										where aem.asset_id = (tcam.asset_meta->>''asset_id'')::numeric
										and aem.asset_type_id = (tcam.asset_meta->>''content_type'')::numeric
										and aem.entity_role_map_id 
										in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
										group by aem.asset_id, aem.asset_type_id
										having count(1) = '||v_entity_count||')';
		v_entity_filter_query_tcam1 := ' and exists(select 1
										from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
										where aem.asset_id =  tcam.asset_id
										and aem.asset_type_id = tcam.asset_type_id
										and aem.entity_role_map_id 
										in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
										group by aem.asset_id, aem.asset_type_id
										having count(1) = '||v_entity_count||')';								
	end if;
	
	if v_other_entity_count > 0 then
		
		v_other_entity_filter_query_al := ' and al.tagged_entity && $2 ';
		
		v_other_entity_filter_query_tcam := ' and exists(select 1
											from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
											where aem.asset_id = tcam.asset_id
											and aem.asset_type_id = tcam.asset_type_id
											and aem.entity_role_map_id in(select v_other_entity_role_map_id from unnest($2) u(v_other_entity_role_map_id))
											group by aem.asset_id, aem.asset_type_id
											having count(1) = 1)';
	end if;
	
	
	
	execute 'select count(1)
				from (select tcam.asset_id, tcam.asset_type_id
						from labsaw.labsaw_template_component_asset_map tcam
						where tcam.template_component_map_id = '||p_asset_id
						||' and tcam.asset_type_id = 12 
						 and asset_meta->>''asset_id'' is null
        				 and asset_meta->>''content_type'' is null
						'
						||v_entity_filter_query_tcam1
												
						||'union
						select tcam.asset_id, tcam.asset_type_id
						from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
						where tcam.template_component_map_id = '||p_asset_id
						||' and tcam.asset_type_id = 12
						and asset_meta->>''asset_id'' is not null
        				and asset_meta->>''content_type'' is not null'
						||v_entity_filter_query_tcam
						||v_other_entity_filter_query_tcam
						
						||'union
						select al.asset_id, al.asset_type_id
						from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
						where al.asset_type_id in(1,2,4)
						and al.is_published = 1
						and al.is_trashed = 0
						and (al.asset_id,al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
																	from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
																	where tcam.template_component_map_id = '||p_asset_id||'
																	and tcam.asset_type_id <> 12) '
						||v_entity_filter_query_al
						||v_other_entity_filter_query_al
						
						||' and '||p_use_fallback||' = 1
						
						
						) tab'
	into v_assets_count
	using p_entityrole_mapid::int[], p_any_entityrole_mapid::int[];
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select asset_id, asset_type_id, asset_order, is_fallback
					from (select asset_id, asset_type_id, row_number() over(order by is_fallback, asset_order) as asset_order,
								is_fallback, row_number() over(order by is_fallback, asset_order) as slno
							from (select tcam.asset_id, tcam.asset_type_id, tcam.asset_order, 0 as is_fallback
									from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
									where tcam.template_component_map_id = '||p_asset_id
									||' and tcam.asset_type_id = 12
									and asset_meta->>''asset_id'' is null
        				 			and asset_meta->>''content_type'' is null'
									||v_entity_filter_query_tcam1
									||'union
									select tcam.asset_id, tcam.asset_type_id, tcam.asset_order, 0 as is_fallback
									from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
									where tcam.template_component_map_id = '||p_asset_id
									||'and tcam.asset_type_id = 12
									and asset_meta->>''asset_id'' is not null
        							and asset_meta->>''content_type'' is not null'
									||v_entity_filter_query_tcam
									||v_other_entity_filter_query_tcam
									||'union
									select al.asset_id, al.asset_type_id, row_number() over(order by al.published_date desc) as asset_order,
											1 as is_fallback
									from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
									where al.asset_type_id in(1,2,4)
									and al.is_published = 1
									and al.is_trashed = 0
									and (al.asset_id, al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
																				from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
																				where tcam.template_component_map_id = '||p_asset_id||'
																				and tcam.asset_type_id <> 12) '
									||v_entity_filter_query_al
									||v_other_entity_filter_query_al
									||') tab_a'
							||v_fallback_query
						||') tab_b
					where slno between '||v_fromrownumber||' and '||v_torownumber||'
				) row'
	into v_assets_json
	using p_entityrole_mapid::int[], p_any_entityrole_mapid::int[], p_use_fallback;
	
	
	
	--raise notice '%',v_assets_json;
--select 1/0;
	open p_showcase_cur for
	with tab as
(select (jsonb_array_elements(a->'data')->>'asset_id')::numeric as asset_id,
						(jsonb_array_elements(a->'data')->>'asset_type_id')::numeric as asset_type_id,
						(jsonb_array_elements(a->'data')->>'asset_order')::numeric as asset_order,
						(jsonb_array_elements(a->'data')->>'is_fallback')::numeric as is_fallback
					from (select v_assets_json::jsonb as a) tab_a
)
select * from (
select tcam.template_component_asset_map_id, 
       tcam.template_component_map_id, 
	   tcam.asset_order, 
	   tcam.asset_id, 
	   tcam.asset_type_id, 
       tcam.asset_meta,
	  tcam.published_version_number, tcam.is_trashed, tcam.created_date, tcam.updated_date, tcam.created_by, tcam.updated_by, 
        		tcam.is_active, tcam.is_deleted, tcam.is_published, tcam.published_date published_date, tcam.asset_guid, 
       asset_meta->>'title_alias' as title_alias, 
	   asset_meta->>'title' as asset_title, ' ' as desc,
	   null::numeric total_assets, 
       ' ' as image_path, 
	   ' ' as image_file_name, 
	   0 as is_fallback, null short_title, null full_text, 
	   null responsive, null mob_image_name, null mob_image_path
from labsaw.labsaw_template_component_asset_map tcam
join tab c on c.asset_id = tcam.asset_id
        and c.asset_type_id = tcam.asset_type_id
    	where tcam.template_component_map_id = 13982
    	and (tcam.asset_meta->>'asset_id')::numeric is null
    	and (tcam.asset_meta->>'content_type')::numeric is null
union 
select tcam.template_component_asset_map_id, 
        tcam.template_component_map_id, tcam.asset_order, 
        al.asset_id, al.asset_type_id, tcam.asset_meta,
	al.published_version_number, al.is_trashed, al.created_date, al.updated_date, al.created_by, al.updated_by, al.is_active, al.is_deleted, 
        		al.is_published, al.published_date, al.asset_guid,
       al.title_alias, al.asset_title, al.short_desc as desc, al.total_assets, 
       al.image_path, al.image_file_name, 0 as is_fallback, al.short_title, 
	   ' ' full_text, 
	   (tcam.asset_meta->>'responsive')::text responsive,
	   (tcam.asset_meta->>'mob_image_name')::text mob_image_name,
	   (tcam.asset_meta->>'mob_image_path')::text mob_image_path
    	from labsaw.labsaw_asset_list al
    	join labsaw.labsaw_template_component_asset_map tcam
    	on (tcam.asset_meta->>'asset_id')::numeric = al.asset_id
    	and (tcam.asset_meta->>'content_type')::numeric = al.asset_type_id
        join tab c
        on c.asset_id = tcam.asset_id
        and c.asset_type_id = tcam.asset_type_id
    	where tcam.template_component_map_id = 13982
        and al.is_published = 1
    	and al.is_trashed = 0
union all
select asset_list_id template_component_asset_map_id, 13982 template_component_map_id, 
        		c.asset_order, 
				al.asset_id, al.asset_type_id, null asset_meta, 
	al.published_version_number, al.is_trashed, al.created_date, al.updated_date, al.created_by, al.updated_by, al.is_active, al.is_deleted, 
        		al.is_published, al.published_date, asset_guid,
        		 al.title_alias, asset_title, short_desc as desc, null::numeric total_assets,
				 image_path, 
        		image_file_name, 1 as is_fallback, al.short_title, '' as full_text, 
				 null responsive, null mob_image_name, null mob_image_path
    	from labsaw.labsaw_asset_list al
        join tab c
        on c.asset_id = al.asset_id
        and c.asset_type_id = al.asset_type_id
        and al.is_published = 1
    	and al.is_trashed = 0
		and c.is_fallback=1
    	)tab1
		order by asset_order ;

    open p_showcase_ent_cur for
    select *, labsaw.labsaw_get_entity_name(entity_role_map_id) entity_name, 
    		labsaw.labsaw_get_entity_display_name_by_language(4, entity_role_map_id) ent_disp_name
	from labsaw.labsaw_asset_entity_map
    where (asset_id,asset_type_id) in(select (jsonb_array_elements(a->'data')->>'asset_id')::numeric as asset_id,
						(jsonb_array_elements(a->'data')->>'asset_type_id')::numeric as asset_type_id
						
					from (select v_assets_json::jsonb as a
						 ) tab_a
)
    order by asset_id, asset_type_id;
   
    open p_showcase_asset_author_cur for
    select aa.asset_id, aa.asset_type_id, aa.author_id, 
    labsaw.labsaw_get_user_disp_name(aa.author_id) author_name,
    labsaw.labsaw_get_user_disp_name(aa.author_id) full_name -- , pam.content_provider_id as 00 -- content_source_id, content_provider_name
	from labsaw.labsaw_author_action aa
    join labsaw.labsaw_user u
    on u.user_id = aa.author_id
	/*left join labsaw.labsaw_provider_author_map pam
	on aa.author_id = pam.author_id
	left join labsaw.labsaw_content_provider cp
	on pam.content_provider_id = cp.content_provider_id*/
    where (aa.asset_id,aa.asset_type_id) in(select (jsonb_array_elements(a->'data')->>'asset_id')::numeric as asset_id,
						(jsonb_array_elements(a->'data')->>'asset_type_id')::numeric as asset_type_id
						
					from (select v_assets_json::jsonb as a
						 ) tab_a)
	and action_id = 4
	order by asset_id, asset_type_id, author_id;
    
	 
    open p_template_comp_cur for
	select template_component_map_id, is_published, 0 is_trashed, updated_by, updated_date as published_date, 1 as published_version_number, 
    		(v_assets_count) v_asset_count
	from labsaw.labsaw_template_component_map
    where template_component_map_id = p_asset_id;
	
    
end;

$_$;


--
