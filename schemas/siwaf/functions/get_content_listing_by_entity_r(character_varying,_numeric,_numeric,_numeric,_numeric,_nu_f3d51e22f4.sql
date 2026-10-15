-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_content_listing_by_entity_r(character varying, numeric, numeric, numeric, numeric, numeric, numeric, text)
-- Type: FUNCTION

-- Name: _get_content_listing_by_entity_r(character varying, numeric, numeric, numeric, numeric, numeric, numeric, text); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_content_listing_by_entity_r(p_schema character varying, p_page_number numeric, p_item_count numeric, p_page1_item_count numeric, p_queried_entity numeric, p_language numeric, p_filter_entity numeric, p_url text, OUT p_result numeric, OUT p_content_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
/*
SELECT * from siwaf._get_content_listing_by_entity_r(
	'labstmp',-- <p_schema character varying>, 
	1,-- <p_page_number numeric>, 
	10,-- <p_item_count numeric>, 
	5,-- <p_page1_item_count numeric>, 
	552,-- <p_queried_entity numeric>, 
	4,-- <p_language numeric>, 
	null-- <p_filter_entity numeric>, 
);
*/
declare
	
	v_limit smallint := case p_page_number when 1 then p_page1_item_count else p_item_count end;
	v_offset smallint := case p_page_number when 1 then 0 else (p_page1_item_count + (((p_page_number - 1) * p_item_count) - p_item_count)) end;
	v_required_entities numeric[] ;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_content_count int;
	v_category_asset_count_json jsonb;
	v_category_count numeric;
	v_content_json jsonb;
	v_json jsonb := '{}'::jsonb;
	v_entity_detail_json jsonb;
	v_entity_array text[];
	v_entity_role_map numeric[];
	
begin

	if p_queried_entity is null then
	
	v_required_entities := ('{'||p_language||'}')::numeric[];
	
	else
	
	v_required_entities := ('{'||p_queried_entity||', '||p_language||'}')::numeric[];
	
	end if;
	
	if v_required_entities is null then
		
		p_result := 0;
		return;
		
	else
	
		if p_url is not null then
		
		p_url := replace(p_url,'-',' ');
		
		v_entity_array := string_to_array(lower(p_url),'/')::text[];
				
		execute
		'select array(select entity_role_map_id from '||$1||'.'||$1||'_entity_role_map
		where entity_master_id in (select entity_master_id  from '||$1||'.'||$1||'_entity_master
						  where lower(entity_name) in (select unnest($2) b))) a '
						  
		into v_entity_role_map
		using p_schema,v_entity_array;
		
		elseif p_queried_entity is not null  then
		
			v_entity_role_map := v_required_entities ;	
		
		end if;
		
		
		
		
		execute 'with tab as
					(select unnest(te) entity_role_map_id, count(1) as asset_count
						from (select tagged_entity te
								from '||$1||'.'||$1||'_asset_list
								where tagged_entity @> $2
								and is_published = 1
								and published_date <= $3
							) tab_1
						group by unnest(te)
					)
					select json_agg(row_to_json(row))::jsonb
					from (select row_number() over(order by t.entity_role_map_id) slno, t.entity_role_map_id, em.entity_name, t.asset_count
							from tab t
							join '||$1||'.'||$1||'_entity_role_map erm
							on erm.entity_role_map_id = t.entity_role_map_id
							join '||$1||'.'||$1||'_entity_category ec
							on ec.entity_role_id = erm.entity_role_id
							join '||$1||'.'||$1||'_entity_master em
							on em.entity_master_id = erm.entity_master_id
							where ec.category_name = ''Category Type''
							order by 1
						) row'
		into v_category_asset_count_json
		using p_schema, v_entity_role_map, v_current_timestamp;
		
		v_json := jsonb_set(v_json,'{category}',v_category_asset_count_json,true);
		
		v_category_count := jsonb_array_length(v_category_asset_count_json);
		
		if p_filter_entity is not null then
			
			v_required_entities := array_append(v_required_entities, p_filter_entity);
			
		end if;
		
		execute 'select count(1)
					from '||$1||'.'||$1||'_asset_list
					where tagged_entity @> $2
					and is_published = 1
					and published_date <= $3
					and web_listing_json is not null'
		into v_content_count
		using p_schema,v_entity_role_map, v_current_timestamp;
		
		v_json := jsonb_set(v_json,'{asset_count}',v_content_count::text::jsonb,true);
		
		execute 'select jsonb_agg(web_listing_json)
					from (select web_listing_json
							from '||$1||'.'||$1||'_asset_list
							where tagged_entity @> $2
							and is_published = 1
							and published_date <= $3
							and web_listing_json is not null
							order by published_date desc
							limit $4
							offset $5
						) tab'
    	into v_content_json
    	using p_schema,v_entity_role_map, v_current_timestamp, v_limit, v_offset;
		
		v_json := jsonb_set(v_json,'{content}',v_content_json,true);
		
		execute 'select row_to_json(row)::jsonb
					from (select eg.entity_group_id as group_id, eg.group_name as group, et.entity_type_id as type_id,
									et.entity_type_name as type, 
									unaccent(coalesce(lem.entity_display_name, em.entity_name)) as name,
									lem.entity_image_path||lem.entity_image_file_name as image, em.canonical_url as url,
									lem.entity_description as desc
							from '||$1||'.'||$1||'_entity_role_map erm
			  				join '||$1||'.'||$1||'_entity_role er
			  				on er.entity_role_id = erm.entity_role_id
			  				join '||$1||'.'||$1||'_entity_type et
			  				on et.entity_type_id = er.entity_type_id
							join '||$1||'.'||$1||'_entity_group eg
			  				on eg.entity_group_id = er.entity_group_id
			  				join '||$1||'.'||$1||'_entity_master em
			  				on em.entity_master_id = erm.entity_master_id
							left join '||$1||'.'||$1||'_language_entity_map lem
							on lem.entity_master_id = em.entity_master_id
							and lem.language_entity_role_map_id = $3
			  				where erm.entity_role_map_id in (select unnest($2) b)
						) row'
		into v_entity_detail_json
		using p_schema, v_entity_role_map, p_language;
		
		v_json := jsonb_set(v_json,'{detail}',v_entity_detail_json,true);
		
		if v_json is not null then
			
			p_result := 1;
			p_content_json := v_json;
			
		else
			
			p_result := 0;
			
		end if;
		
	end if;
	
-- exception
-- 	when others then
-- 		p_result := -1;
	
end;
$_$;


--
