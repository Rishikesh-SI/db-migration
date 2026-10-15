-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_get_ad_position_listing()
-- Type: FUNCTION

-- Name: labhsl_get_ad_position_listing(); Type: FUNCTION; Schema: labhsl; Owner: -
--

CREATE FUNCTION labhsl.labhsl_get_ad_position_listing(OUT p_ad_position_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
	select ('{"data":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
	from (select erm.entity_role_map_id, em.entity_name
			from labhsl.labhsl_entity_category ec
			join labhsl.labhsl_entity_role_map erm
			on erm.entity_role_id = ec.entity_role_id
			join labhsl.labhsl_entity_master em
			on em.entity_master_id = erm.entity_master_id
			where category_name = 'Ad Positions'
			order by em.entity_master_id) row
	into p_ad_position_json;
	
exception
	when others then
		p_ad_position_json := '{"data":[]}'::jsonb;
end;

$$;


--
