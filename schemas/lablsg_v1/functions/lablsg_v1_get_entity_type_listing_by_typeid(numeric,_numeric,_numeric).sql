-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_entity_type_listing_by_typeid(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_get_entity_type_listing_by_typeid(numeric, numeric, numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_entity_type_listing_by_typeid(p_entity_type_id numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_entity_type_id numeric := p_entity_type_id;
    v_total numeric;
    v_total_pages numeric;
    v_items jsonb;
    v_pagination jsonb;
BEGIN
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);

    IF p_entity_type_id IS NOT NULL THEN
        SELECT COUNT(*) INTO v_total
        FROM lablsg_v1.lablsg_v1_entity_type AS et
        JOIN lablsg_v1.lablsg_v1_entity_role AS er ON et.entity_type_id = er.entity_type_id
        JOIN lablsg_v1.lablsg_v1_entity_role_map AS erm ON er.entity_role_id = erm.entity_role_id
        JOIN lablsg_v1.lablsg_v1_entity_master AS em ON erm.entity_master_id = em.entity_master_id
        WHERE et.entity_type_id = v_entity_type_id
          AND em.is_active=1 AND em.is_deleted=0;
    ELSE
        SELECT COUNT(*) INTO v_total
        FROM lablsg_v1.lablsg_v1_entity_type AS et
        JOIN lablsg_v1.lablsg_v1_entity_role AS er ON et.entity_type_id = er.entity_type_id
        JOIN lablsg_v1.lablsg_v1_entity_role_map AS erm ON er.entity_role_id = erm.entity_role_id
        JOIN lablsg_v1.lablsg_v1_entity_master AS em ON erm.entity_master_id = em.entity_master_id
        WHERE em.is_active=1 AND em.is_deleted=0;
    END IF;

    v_total_pages := CASE WHEN p_itemnumber > 0 THEN CEIL(v_total / p_itemnumber) ELSE 0 END;

    IF p_entity_type_id IS NOT NULL THEN
        SELECT jsonb_agg(row_to_json(t))
        INTO v_items
        FROM (
           SELECT
                entity_type_id,
                entity_type_name,
                entity_role_map_id,
                entity_role_id,
                entity_master_id,
                entity_name,
                entity_display_name,
                canonical_url,
                entity_url,
                created_date
            FROM (
                SELECT
                    et.entity_type_id,
                    et.entity_type_name,
                    erm.entity_role_map_id,
                    erm.entity_role_id,
                    erm.entity_master_id,
                    em.entity_name,
                    em.entity_display_name,
                    em.canonical_url,
                    em.entity_url,
                    em.created_date,
                    ROW_NUMBER() OVER (ORDER BY em.created_date DESC, em.entity_master_id) as rn
                FROM lablsg_v1.lablsg_v1_entity_type AS et
                JOIN lablsg_v1.lablsg_v1_entity_role AS er
                    ON et.entity_type_id = er.entity_type_id
                JOIN lablsg_v1.lablsg_v1_entity_role_map AS erm
                    ON er.entity_role_id = erm.entity_role_id
                JOIN lablsg_v1.lablsg_v1_entity_master AS em
                    ON erm.entity_master_id = em.entity_master_id
                WHERE et.entity_type_id = v_entity_type_id
                  AND em.is_active=1 AND em.is_deleted=0
            ) sub
            WHERE (
                (v_fromrownumber IS NOT NULL AND v_torownumber IS NOT NULL AND sub.rn BETWEEN v_fromrownumber AND v_torownumber)
                OR
                (v_fromrownumber IS NULL OR v_torownumber IS NULL)
            )
        ) t;

        IF v_items IS NULL THEN
            v_items := '[]'::jsonb;
        END IF;
    ELSE
        SELECT jsonb_agg(row_to_json(t))
        INTO v_items
        FROM (
            SELECT
                entity_type_id,
                entity_type_name,
                entity_role_id,
                entity_role_map_id,
                entity_master_id,
                entity_name,
                entity_display_name,
                canonical_url,
                entity_url,
                created_date
            FROM (
                SELECT
                    et.entity_type_id,
                    et.entity_type_name,
                    er.entity_role_id,
                    erm.entity_role_map_id,
                    erm.entity_master_id,
                    em.entity_name,
                    em.entity_display_name,
                    em.canonical_url,
                    em.entity_url,
                    em.created_date,
                    ROW_NUMBER() OVER (ORDER BY em.created_date DESC, em.entity_master_id) as rn
                FROM lablsg_v1.lablsg_v1_entity_type AS et
                JOIN lablsg_v1.lablsg_v1_entity_role AS er
                    ON et.entity_type_id = er.entity_type_id
                JOIN lablsg_v1.lablsg_v1_entity_role_map AS erm
                    ON er.entity_role_id = erm.entity_role_id
                JOIN lablsg_v1.lablsg_v1_entity_master AS em
                    ON erm.entity_master_id = em.entity_master_id
                WHERE em.is_active=1 AND em.is_deleted=0
            ) sub
           WHERE (
                (v_fromrownumber IS NOT NULL AND v_torownumber IS NOT NULL AND sub.rn BETWEEN v_fromrownumber AND v_torownumber)
                OR
                (v_fromrownumber IS NULL OR v_torownumber IS NULL)
			 )
        ) t;

        IF v_items IS NULL THEN
            v_items := '[]'::jsonb;
        END IF;
    END IF;

if p_pagenumber is null and p_itemnumber is null then 
v_total_pages=1;
end if;

    v_pagination := jsonb_build_object(
        'page', p_pagenumber,
        'page_size', p_itemnumber,
        'total', v_total,
        'total_pages', v_total_pages
    );

    p_output := jsonb_build_object(
        'items', v_items,
        'pagination', v_pagination
    );

EXCEPTION
    WHEN OTHERS THEN
        p_output := jsonb_build_object(
            'items', '[]'::jsonb,
            'pagination', jsonb_build_object(
                'page', 1,
                'page_size', 0,
                'total', 0,
                'total_pages', 0
            )
        );
END;
$$;


--
