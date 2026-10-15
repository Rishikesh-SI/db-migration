-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_by_role(character varying, numeric, numeric[])
-- Type: FUNCTION

-- Name: _get_entity_by_role(character varying, numeric, numeric[]); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_by_role(p_schema_prefix character varying, p_entity_role_id numeric, p_entity_role_map_id numeric[], OUT p_result numeric, OUT p_entity_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
     v_entity_count numeric := coalesce(array_length(p_entity_role_map_id,1),0);
     v_entity_filter_query text := ' ';
     
begin
	
     if v_entity_count > 0 then
     	v_entity_filter_query := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
                                                  where aem.entity_role_map_id in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
                                                  and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem1
                                                  		 where aem1.asset_id = aem.asset_id
                                                             and aem1.asset_type_id = aem.asset_type_id
                                                             and aem1.entity_role_map_id = erm.entity_role_map_id)
                                                  group by aem.asset_id, aem.asset_type_id
                                                  having count(1) = '||v_entity_count||')';
	end if;
     
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
     		from (select erm.entity_role_map_id, em.entity_name
               		from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
                         join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where erm.entity_role_id = '||p_entity_role_id
                         ||v_entity_filter_query||'
				) as row'
	into p_entity_json;
     
     if p_entity_json is not null then
     	p_result := 1;
     else
     	p_result := 0;
          p_entity_json := '{"data":[]}'::jsonb;
     end if;
	
exception
	when others then
     	p_result := -1;
          p_entity_json := '{"data":[]}'::jsonb;
	
end;
$_$;


--
