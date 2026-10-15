-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_sitemap_r_07062023(character varying)
-- Type: FUNCTION

-- Name: _get_sitemap_r_07062023(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_sitemap_r_07062023(p_schema_prefix character varying, OUT p_sitemap_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_array text[];
	v_record record;
	v_entity_count numeric;
	v_page_count numeric;
	v_i numeric;
	
begin
	
	select array(select '/'||coalesce(cscm.prefix,'')||sc.category_name||coalesce(cscm.postfix,'') as category_name
			   from siwaf.siwaf_client_sitemap_category_map cscm
			   join siwaf.siwaf_sitemap_category sc
			   on sc.category_id = cscm.sitemap_category_id
			   where cscm.client_code = p_schema_prefix
			   and cscm.is_paginated = 0
				and cscm.is_checked = 1)
	into v_array;
	
	for v_record in (select cscm.sitemap_category_id, sc.category_name, cscm.page_limit, cscm.entity_role_id,
				  		coalesce(cscm.prefix,'') prefix, coalesce(cscm.postfix,'') postfix
				  from siwaf.siwaf_client_sitemap_category_map cscm
				  join siwaf.siwaf_sitemap_category sc
				  on sc.category_id = cscm.sitemap_category_id
				  where cscm.client_code = p_schema_prefix
				  and cscm.is_paginated = 1
					and cscm.is_checked = 1)
	loop
		if v_record.sitemap_category_id = 3 then
			execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
					where asset_type_id in(1,2,4) and is_published = 1 and is_trashed = 0'
			into v_entity_count;
		else
			execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
					where entity_role_id = '||v_record.entity_role_id
			into v_entity_count;
		end if;
		raise notice 'v_entity_count : %',v_entity_count;
		select ceil(v_entity_count::numeric/v_record.page_limit) into v_page_count;
		raise notice 'v_page_count : %',v_page_count;
		for v_i in 1..v_page_count
		loop
			raise notice 'v_i : %',v_i;
			select array_append(v_array,('/'||coalesce(v_record.prefix,'')||v_record.category_name||'/'||v_i||coalesce(v_record.postfix,'')))
			into v_array;
			raise notice 'v_array : %',v_array;
		end loop;
	end loop;
	
	select ('{"sitemap":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select asset from unnest(v_array) u(asset)) row
	into p_sitemap_json;
	
exception
	when others then
		p_sitemap_json := ('{"sitemap":[]}')::jsonb;
	
end;

$$;


--
