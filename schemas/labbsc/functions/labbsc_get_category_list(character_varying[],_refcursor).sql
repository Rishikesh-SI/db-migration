-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_category_list(character varying[], refcursor)
-- Type: FUNCTION

-- Name: labbsc_get_category_list(character varying[], refcursor); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_category_list(p_category character varying[], p_entity_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin
	
	open p_entity_master_cur for
	select erm.entity_role_map_id, em.entity_name, em.entity_display_name, ec.category_name, em.canonical_url
	from labbsc.labbsc_entity_category ec
	join labbsc.labbsc_entity_role_map erm
	on erm.entity_role_id = ec.entity_role_id
	join labbsc.labbsc_entity_master em
	on em.entity_master_id = erm.entity_master_id
	where lower(category_name) in (select lower(category) from unnest(p_category) u(category))
	and ec.is_active = 1
	and ec.is_deleted = 0
	and ec.is_published = 1
	and erm.is_active = 1
	order by 1;
	
end;

$$;


--
