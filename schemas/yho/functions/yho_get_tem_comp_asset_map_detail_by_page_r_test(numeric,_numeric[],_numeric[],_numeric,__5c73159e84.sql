-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_tem_comp_asset_map_detail_by_page_r_test(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: yho_get_tem_comp_asset_map_detail_by_page_r_test(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_tem_comp_asset_map_detail_by_page_r_test(p_asset_id numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_use_fallback numeric, p_showcase_cur refcursor, p_showcase_ent_cur refcursor, p_showcase_asset_author_cur refcursor, p_template_comp_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
SELECT * from yho.yho_get_tem_comp_asset_map_detail_by_page_r_test(
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
	v_ent_count numeric := array_length(p_entityrole_mapid, 1);
	v_str_entityrole_mapid text := '{'||array_to_string(p_entityrole_mapid,',')||'}';
	v_str_any_entityrole_mapid text := '{'||array_to_string(p_any_entityrole_mapid,',')||'}';
	v_language_id numeric;
	v_tagged_assets_json json;
	v_total_tagged_assets_json json;
	v_tagged_assets_count numeric;
	v_req_asset_count numeric;
	v_fallback_assets_json json;
	v_total_assets numeric;
	v_fallback_assets_count numeric;
	v_a numeric;
	v_b numeric;
	v_c numeric;
	v_time numeric;
	v_fallback_start numeric;
    v_total_tagged_assets_count numeric;
	
begin
	
	if p_page1_size is null then
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
	
	select yho.yho_get_entity_language_from_entities(p_entityrole_mapid) into v_language_id;
	
	select showcase_assets_validity::numeric from yho.yho_site_master into v_time;
	
	select ('{"tagged_assets":['||string_agg(row_to_json(row)::text,',')||']}')::json
	from (select asset_id, asset_type_id, is_image_available, row_number() over (order by is_image_available desc, asset_order) as rno
		  from (select asset_id, asset_type_id, asset_order, is_image_available
				from (select coalesce((tcam.asset_meta->>'asset_id'),tcam.asset_id::text)::numeric as asset_id,
					  			coalesce((tcam.asset_meta->>'content_type'),tcam.asset_type_id::text)::numeric as asset_type_id,
					  			tcam.asset_order, case length(asset_meta->>'image_id') when 0 then 0 else 1 end as is_image_available
					  from yho.yho_template_component_asset_map tcam
					  where template_component_map_id = p_asset_id
					  and asset_type_id = 12
					  and published_date >= v_sysdate - (''''||v_time||' hours''')::interval
					  and published_date <= current_timestamp at time zone 'utc'
					 )tab
				where exists(select 1 from yho.yho_asset_entity_map aem
							 where aem.asset_id = tab.asset_id
							 and aem.asset_type_id = tab.asset_type_id
							 and aem.entity_role_map_id =any(v_str_entityrole_mapid::numeric[])
							 group by aem.asset_id, aem.asset_type_id
							 having count(1) = 1)
				and case coalesce(array_length(v_str_any_entityrole_mapid::numeric[],1),0)
					when 0 then 1 = 1
					else exists(select 1 from yho.yho_asset_entity_map aem
								where aem.asset_id = tab.asset_id
								and aem.asset_type_id = tab.asset_type_id
								and aem.entity_role_map_id =any(v_str_any_entityrole_mapid::numeric[])
								group by aem.asset_id, aem.asset_type_id) end
			   )tab1
		 )row
	into v_total_tagged_assets_json;
	
	select coalesce(json_array_length((a->>'tagged_assets')::json),0) into v_total_tagged_assets_count
	from (select v_total_tagged_assets_json as a) b;
	
	select ('{"tagged_assets":['||string_agg(row_to_json(row)::text,',')||']}')::json
	from (select c->>'asset_id' as asset_id, c->>'asset_type_id' as asset_type_id, c->>'is_image_available' as is_image_available
		  from (select json_array_elements(a) as c
				from (select v_total_tagged_assets_json->'tagged_assets' as a) as tab
			   ) as tab1
		  where (c->>'rno')::numeric between v_fromrownumber and v_torownumber
		 ) as row
	into v_tagged_assets_json;
	
	select coalesce(json_array_length((a->>'tagged_assets')::json),0) into v_tagged_assets_count
	from (select v_tagged_assets_json as a) b;
    	
	v_req_asset_count := greatest((v_itemnumber - v_tagged_assets_count),0);
	v_fallback_start := greatest((((greatest((case coalesce(p_page1_size, 0) when 0 then p_pagenumber else (p_pagenumber - 1) end), 0) * p_itemnumber) + coalesce(p_page1_size, 0)) - v_itemnumber), 0);
	

	
	select count(1) from yho.yho_asset_list al
	where asset_type_id in(1,2,4,5)
	and (asset_id,asset_type_id) not in(select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric,
                                         		(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric
                                         from (select v_total_tagged_assets_json as a) as tab)
	and exists(select 1 from yho.yho_asset_entity_map aem
                where aem.asset_id = al.asset_id
                and aem.asset_type_id = al.asset_type_id
                and aem.entity_role_map_id =any(v_str_entityrole_mapid::numeric[])
                group by aem.asset_id,aem.asset_type_id
                having count(1) = v_ent_count)
	and case coalesce(array_length(v_str_any_entityrole_mapid::numeric[],1),0)
			when 0 then 1 = 1
			else exists(select 1 from yho.yho_asset_entity_map aem
						where aem.asset_id = al.asset_id
						and aem.asset_type_id = al.asset_type_id
						and aem.entity_role_map_id =any(v_str_any_entityrole_mapid::numeric[])
						group by aem.asset_id,aem.asset_type_id) end
	and is_published = 1
	and is_trashed = 0
	and published_date <= v_sysdate
	into v_fallback_assets_count;
     
    	select ('{"fallback_assets":['||string_agg((row_to_json(row))::text,',')||']}')::json
	from (select asset_id, asset_type_id, is_image_available
           from (select asset_id, asset_type_id, is_image_available,
                 		row_number() over(order by is_image_available desc, published_date desc) as rno
                 from (select asset_id, asset_type_id, published_date,
                       		case coalesce(length(image_path),0) when 0 then 0 else 1 end as is_image_available
                       from yho.yho_asset_list al
                       where asset_type_id in(1,2,4,5)
                       and (asset_id,asset_type_id) not in(select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric,
                                                           			(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric
                                                           from (select v_total_tagged_assets_json as a) as tab)
                       and exists(select 1 from yho.yho_asset_entity_map aem
                                  where aem.asset_id = al.asset_id
                                  and aem.asset_type_id = al.asset_type_id
                                  and aem.entity_role_map_id =any(v_str_entityrole_mapid::numeric[])
                                  group by aem.asset_id,aem.asset_type_id
                                  having count(1) = v_ent_count)
                       and case coalesce(array_length(v_str_any_entityrole_mapid::numeric[],1),0)
                       		when 0 then 1 = 1
                       			else exists(select 1 from yho.yho_asset_entity_map aem
                                          where aem.asset_id = al.asset_id
                                          and aem.asset_type_id = al.asset_type_id
                                          and aem.entity_role_map_id =any(v_str_any_entityrole_mapid::numeric[])
                                          group by aem.asset_id,aem.asset_type_id)
                       		end
                       and is_published = 1
                       and is_trashed = 0
                       and published_date <= v_sysdate
                      )tab
                )tab1
           order by rno
           offset v_fallback_start
           limit v_req_asset_count
          )row
	into v_fallback_assets_json;
	
	/*raise notice '%',v_fallback_assets_json;
	raise notice '% v_tagged_assets_json',v_tagged_assets_json;
	select 1/0;*/
     
    	open p_showcase_cur for
   	select *
     from (select template_component_asset_map_id, template_component_map_id,
           		row_number() over(order by is_fallback, asset_order) as asset_order, asset_id, asset_type_id, asset_meta,
           		published_version_number, is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
           		is_published, published_date, asset_guid, title_alias, asset_title, sd as desc, total_assets, image_path,
           		image_file_name, is_fallback, short_title, full_text, is_image_available, responsive, mob_image_name,
           		mob_image_path
           from (select *
                 from (select tcam.template_component_asset_map_id, tcam.template_component_map_id, tcam.asset_order, al.asset_id,
                       		al.asset_type_id, tcam.asset_meta, al.published_version_number, al.is_trashed, al.created_date,
                       		al.updated_date, al.created_by, al.updated_by, al.is_active, al.is_deleted, al.is_published,
                       		al.published_date, al.asset_guid,
                       		coalesce((tcam.asset_meta->>'title_alias')::text, al.title_alias) as title_alias,
                       		tcam.asset_meta->>'title' as asset_title, coalesce((tcam.asset_meta->>'desc')::text, al.short_desc) as sd,
                       		al.total_assets, (tcam.asset_meta->>'image_path')::text image_path,
                       		(tcam.asset_meta->>'image_name')::text image_file_name, 0 as is_fallback, al.short_title, a.full_text,
                       		c.is_image_available, (tcam.asset_meta->>'responsive')::text responsive,
                       		(tcam.asset_meta->>'mob_image_name')::text mob_image_name,
                       		(tcam.asset_meta->>'mob_image_path')::text mob_image_path
                       from yho.yho_asset_list al
                       join yho.yho_template_component_asset_map tcam
                       on (tcam.asset_meta->>'asset_id')::numeric = al.asset_id
                       and (tcam.asset_meta->>'content_type')::numeric = al.asset_type_id
                       join (select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric as asset_id,
                             			(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric as asset_type_id, 
                             			(json_array_elements(a->'tagged_assets')->>'is_image_available')::numeric as is_image_available
                             from (select v_tagged_assets_json as a) b) c
                       on c.asset_id = al.asset_id
                       and c.asset_type_id = al.asset_type_id
                       left join yho.yho_article a
                       on a.article_id = al.asset_id
                       and al.asset_type_id = 1
                       where tcam.template_component_map_id = p_asset_id
                       and al.is_published = 1
                       and al.is_trashed = 0
                       and al.published_date <= v_sysdate
                       union
                       select tcam.template_component_asset_map_id, tcam.template_component_map_id, tcam.asset_order, tcam.asset_id,
                       		tcam.asset_type_id, tcam.asset_meta, tcam.published_version_number, tcam.is_trashed, tcam.created_date,
                       		tcam.updated_date, tcam.created_by, tcam.updated_by, tcam.is_active, tcam.is_deleted, tcam.is_published,
                       		tcam.published_date published_date, tcam.asset_guid, asset_meta->>'title_alias' as title_alias,
                       		asset_meta->>'title' as asset_title, ' ' as desc, null::numeric total_assets, ' ' as image_path,
                       		' ' as image_file_name, 0 as is_fallback, null as short_title, null as full_text, c.is_image_available,
                       		null as responsive, null as mob_image_name, null as mob_image_path
                       from yho.yho_template_component_asset_map tcam
                       join (select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric as asset_id,
                             			(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric as asset_type_id,
                             			(json_array_elements(a->'tagged_assets')->>'is_image_available')::numeric as is_image_available
                             from (select v_tagged_assets_json as a) b) c
                       on c.asset_id = tcam.asset_id
                       and c.asset_type_id = tcam.asset_type_id
                       where tcam.template_component_map_id = p_asset_id
                       and (tcam.asset_meta->>'asset_id')::numeric is null
                       and (tcam.asset_meta->>'content_type')::numeric is null
                       union
                       select asset_list_id template_component_asset_map_id, p_asset_id template_component_map_id,
                       		row_number() over(order by al.published_date desc) asset_order, al.asset_id, al.asset_type_id,
                       		null as asset_meta, al.published_version_number, al.is_trashed, al.created_date, al.updated_date,
                       		al.created_by, al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date,
                       		asset_guid, al.title_alias, asset_title, short_desc, null::numeric as total_assets, image_path,
                       		image_file_name, 1 as is_fallback, al.short_title, a.full_text, is_image_available, null as responsive,
                       		null as mob_image_name, null as mob_image_path
                       from yho.yho_asset_list al
                       left join yho.yho_article a
                       on a.article_id = al.asset_id
                       and al.asset_type_id = 1
                       join (select (json_array_elements(a->'fallback_assets')->>'asset_id')::numeric as asset_id,
                             			(json_array_elements(a->'fallback_assets')->>'asset_type_id')::numeric as asset_type_id,
              						(json_array_elements(a->'fallback_assets')->>'is_image_available')::numeric as is_image_available
                             from (select v_fallback_assets_json as a) b) c
                       on c.asset_id = al.asset_id
                       and c.asset_type_id = al.asset_type_id
                       and al.is_published = 1
                       and al.is_trashed = 0
                       and al.published_date <= v_sysdate
                      )tab
                )row
           order by is_fallback, is_image_available desc, asset_order
          ) tab
	order by asset_order;
	
    	open p_showcase_ent_cur for
     select *, yho.yho_get_entity_name(entity_role_map_id) as entity_name,
     		yho.yho_get_entity_display_name_by_language(v_language_id, entity_role_map_id) as ent_disp_name
	from yho.yho_asset_entity_map
     where (asset_id,asset_type_id) in(select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric,
                                       			(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric
                                       from (select v_tagged_assets_json as a) b
                                       union
                                       select (json_array_elements(a->'fallback_assets')->>'asset_id')::numeric,
                                      			(json_array_elements(a->'fallback_assets')->>'asset_type_id')::numeric
                                       from (select v_fallback_assets_json as a) b)
	order by asset_id, asset_type_id;
    	
    	open p_showcase_asset_author_cur for
     select aa.asset_id, aa.asset_type_id, aa.author_id, yho.yho_get_user_disp_name(aa.author_id) as author_name,
     		pam.content_provider_id as content_source_id, content_provider_name
     from yho.yho_author_action aa
     join yho.yho_user u
    	on u.user_id = aa.author_id
	left join yho.yho_provider_author_map pam
	on aa.author_id = pam.author_id
	left join yho.yho_content_provider cp
	on pam.content_provider_id = cp.content_provider_id
    	where (aa.asset_id,aa.asset_type_id) in(select (json_array_elements(a->'tagged_assets')->>'asset_id')::numeric,
                                             		(json_array_elements(a->'tagged_assets')->>'asset_type_id')::numeric
                                             from (select v_tagged_assets_json as a) b
                                             union
                                             select (json_array_elements(a->'fallback_assets')->>'asset_id')::numeric,
                                             		(json_array_elements(a->'fallback_assets')->>'asset_type_id')::numeric
                                             from (select v_fallback_assets_json as a) b)
	and action_id = 4
	order by asset_id, asset_type_id, author_id;
    	
    	open p_template_comp_cur for
	select template_component_map_id, is_published, 0 as is_trashed, updated_by, updated_date as published_date,
     		1 as published_version_number, (v_total_tagged_assets_count + v_fallback_assets_count) as v_asset_count
	from yho.yho_template_component_map
    	where template_component_map_id = p_asset_id;
     
end;

$$;


--
