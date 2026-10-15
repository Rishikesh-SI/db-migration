-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_date_sitemap(character varying, character varying)
-- Type: FUNCTION

-- Name: _get_date_sitemap(character varying, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_date_sitemap(p_schema_prefix character varying, p_date character varying, OUT p_result numeric, OUT p_date_json jsonb, OUT p_asset_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_date character varying(10) = p_date;
	v_date_arr character varying(10)[];
	
begin
	
	if v_date is null then
		execute 'select min(published_date)::date::text
				from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
				where asset_type_id in(1,2,4)'
		into v_date;
		execute 'select array(select published_date::date::text
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
							where asset_type_id in(1,2,4)
							group by published_date::date
							order by published_date)'
		into v_date_arr;
	else
		v_date_arr[1] := v_date;
	end if;
	
	select ('{"date":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select substring(date,1,4) as yyyy, substring(date,6,2) as mm, substring(date,9,2) as dd
		 from unnest(v_date_arr) u(date)
		) row
	into p_date_json;
	
	execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
			from (select al.asset_title as title, al.title_alias, lem.canonical_url as language_url,
						lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
						lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name, al.updated_date
					from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
					on perm.entity_role_map_id = al.primary_entity_role_map_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
					on pem.entity_master_id = perm.entity_master_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
					on serm.entity_role_map_id = al.secondary_entity_role_map_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
					on sem.entity_master_id = serm.entity_master_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map lerm
					on lerm.entity_role_map_id = al.language_entity_role_map_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master lem
					on lem.entity_master_id = lerm.entity_master_id
					where al.asset_type_id in(1,2,4)
					and al.published_date::date = '''||v_date::date||'''
					and al.is_published = 1
				)row'
	into p_asset_json;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
		p_date_json := '{"date":[]}'::jsonb;
		p_date_json := '{"data":[]}'::jsonb;
end;
$$;


--
