-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_entity_type_list(numeric, numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_get_entity_type_list(numeric, numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_entity_type_list(p_pagenumber numeric, p_itemnumber numeric, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE 
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_pagenumber numeric:=p_pagenumber ;
    v_itemnumber numeric:=p_itemnumber ;
    v_total numeric;
    v_total_pages numeric;
    v_items jsonb;
    v_pagination jsonb;
BEGIN
    v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
    v_torownumber   := (v_pagenumber * v_itemnumber);

    -- Get total count
    SELECT COUNT(*) INTO v_total FROM lablsg_v1.lablsg_v1_entity_type;

    -- Calculate total pages
    v_total_pages := CASE WHEN v_itemnumber > 0 THEN CEIL(v_total / v_itemnumber) ELSE 0 END;

    -- Get paginated items using your requested WHERE clause
    SELECT jsonb_agg(row_to_json(t))
    INTO v_items
    FROM (
        SELECT
            entity_type_id,
            client_id,
            entity_type_name
        FROM (
            SELECT 
                entity_type_id,
                client_id,
                entity_type_name,
                ROW_NUMBER() OVER (ORDER BY entity_type_id) as rn
            FROM lablsg_v1.lablsg_v1_entity_type
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

if p_pagenumber is null and p_itemnumber is null then 
v_total_pages=1;
end if;

    -- Build pagination object
    v_pagination := jsonb_build_object(
        'page', v_pagenumber,
        'page_size', v_itemnumber,
        'total', v_total,
        'total_pages', v_total_pages
    );

    -- Build final output
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
