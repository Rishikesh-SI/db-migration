-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_get_sitemap(character varying, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labman_get_sitemap(character varying, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: labman; Owner: -
--

CREATE FUNCTION labman.labman_get_sitemap(p_category character varying, p_language_id numeric, p_page_number numeric, p_item_number numeric, p_count refcursor, p_sitemap_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
	v_fromrownumber numeric;
	v_torownumber numeric;
    v_entity_type_id numeric;
begin
	v_fromrownumber := (p_page_number * p_item_number - (p_item_number - 1));
  	v_torownumber   := (p_page_number * p_item_number);
    if p_category = 'sports' then
    	v_entity_type_id = 36;
    elsif p_category = 'players' then
    	v_entity_type_id = 2;
    elsif p_category = 'teams' then
    	v_entity_type_id = 1;
    elsif p_category = 'tournaments' then
    	v_entity_type_id = 34;
    end if;
    open p_count for
    select count(1)
    from   labman.labman_entity_master
    where  entity_master_id in(
        select entity_master_id
        from   labman.labman_entity_role_map
        where  entity_role_id in(
            select entity_role_id
            from   labman.labman_entity_role
            where  entity_type_id = v_entity_type_id))
	and canonical_url is not null;
    
    open p_sitemap_cur for
    select canonical_url, updated_date, slno
    from
    (
        select case p_language_id when 7925 then '/hi'||canonical_url when 7926 then canonical_url else null end as canonical_url, updated_date,
        		row_number() over(order by updated_date desc) slno
        from   labman.labman_entity_master
        where  entity_master_id in(
            select entity_master_id
            from   labman.labman_entity_role_map
            where  entity_role_id in(
                select entity_role_id
                from   labman.labman_entity_role
                where  entity_type_id = v_entity_type_id))
        and canonical_url is not null
    ) tab
    where slno between v_fromrownumber and v_torownumber;
end;

 $$;


--
