-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_listing(character varying, character varying, numeric, numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_entity_listing(character varying, character varying, numeric, numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_listing(p_schema_prefix character varying, p_entity_category character varying, p_entity_group_id numeric, p_entity_type_id numeric, p_search_keyword character varying, p_page_number numeric, p_item_number numeric, OUT p_result numeric, OUT p_entity_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_entity_category text := coalesce(p_entity_category,'0');
	v_entity_group_id numeric := coalesce(p_entity_group_id,0);
	v_entity_type_id numeric := coalesce(p_entity_type_id,0);
	v_category_filter_query text := ' ';
	v_entity_filter_query text := ' ';
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_from_to_row_query text := ' ';
	
begin
	if v_entity_category <> '0' then
		v_category_filter_query := ' join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
								on ec.entity_role_id = er.entity_role_id
								and ec.category_name = case '''||v_entity_category||''' when ''0'' then ec.category_name else '''||v_entity_category||''' end ';
	end if;
	
	if p_search_keyword is not null then
		v_entity_filter_query := ' and upper(em.entity_name) like ''%'||upper(p_search_keyword)||'%'' ';
     end if;
	
	if p_page_number is not null and p_item_number is not null then
		v_from_row_number := ((p_page_number - 1) * p_item_number) + 1;
     	v_to_row_number := p_page_number * p_item_number;
		v_from_to_row_query := ' where slno between '||v_from_row_number||' and '||v_to_row_number;
	end if;
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select entity_name, entity_display_name, canonical_url, entity_role_map_id, priority, slno
					from (select em.entity_name, em.entity_display_name, em.canonical_url, erm.entity_role_map_id, erm.priority,
								row_number() over(order by em.entity_name) slno
							from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
							on erm.entity_master_id = em.entity_master_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role er
							on er.entity_role_id = erm.entity_role_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group eg
							on eg.entity_group_id = er.entity_group_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type et
							on et.entity_type_id = er.entity_type_id'
							||v_category_filter_query||
							'where eg.entity_group_id = case '||v_entity_group_id||' when 0 then eg.entity_group_id else '||v_entity_group_id||' end
							and et.entity_type_id = case '||v_entity_type_id||' when 0 then et.entity_type_id else '||v_entity_type_id||' end '
							||v_entity_filter_query||
						') tab'
					||v_from_to_row_query||
				')row'
	into p_entity_json;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
		p_entity_json := '{"data":[]}'::jsonb;

end;

$$;


--
