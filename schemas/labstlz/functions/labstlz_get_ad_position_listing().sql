-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_get_ad_position_listing()
-- Type: FUNCTION

-- Name: labstlz_get_ad_position_listing(); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_get_ad_position_listing(OUT p_ad_position_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin

	select ('{"data":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
	from (select erm.entity_role_map_id, em.entity_name
			from labstlz.labstlz_entity_category ec
			join labstlz.labstlz_entity_role_map erm
			on erm.entity_role_id = ec.entity_role_id
			join labstlz.labstlz_entity_master em
			on em.entity_master_id = erm.entity_master_id
			where category_name = 'Ad Positions' 
		   -- and em.is_active=1 and em.is_delete=0
			order by em.entity_master_id) row
	into p_ad_position_json;

exception
	when others then
		p_ad_position_json := '{"data":[]}'::jsonb;
end;

$$;


--
