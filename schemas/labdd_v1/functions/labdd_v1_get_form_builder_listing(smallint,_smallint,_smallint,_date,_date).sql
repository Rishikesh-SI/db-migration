-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_get_form_builder_listing(smallint, smallint, smallint, date, date)
-- Type: FUNCTION

-- Name: labdd_v1_get_form_builder_listing(smallint, smallint, smallint, date, date); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_get_form_builder_listing(p_status smallint, p_pagenumber smallint, p_itemnumber smallint, p_start_date date DEFAULT NULL::date, p_end_date date DEFAULT NULL::date, OUT p_count bigint, OUT p_form_builder_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_module constant text := 'dadas_delhi_campaign';
    v_offset integer;
BEGIN
    v_offset := (COALESCE(p_pagenumber, 1) - 1) * COALESCE(p_itemnumber, 25);

    SELECT COUNT(*)
      INTO p_count
      FROM labdd_v1.labdd_v1_custom_web_json
     WHERE LOWER(module_name) = v_module
       AND (p_status     IS NULL OR COALESCE((datajson->'data'->>'status')::smallint, 0) = p_status)
       AND (p_start_date IS NULL OR created_date >= p_start_date)
       AND (p_end_date   IS NULL OR created_date <  p_end_date + 1);

    SELECT COALESCE(
             jsonb_agg(
               jsonb_build_object(
                 'customID',         s.custom_id,
                 'status',           COALESCE((s.datajson->'data'->>'status')::smallint, 0),
                 'userGuid',         s.user_guid,
                 'additionalFields', jsonb_build_array(
                     jsonb_build_object('label', 'Full Name',
                                        'value', s.datajson->'data'->'wall_info'->>'full_name'),
                     jsonb_build_object('label', 'City',
                                        'value', s.datajson->'data'->'wall_info'->>'city'),
                     jsonb_build_object('label', 'Message',
                                        'value', s.datajson->'data'->'wall_info'->>'message')),
                 'createdDate',      s.created_date,
                 'updatedDate',      s.updated_date,
                 'submissionDate',   COALESCE(s.created_date, s.updated_date))
               ORDER BY s.created_date DESC),
             '[]'::jsonb)
      INTO p_form_builder_json
      FROM (SELECT custom_id, created_date, updated_date, user_guid, datajson
              FROM labdd_v1.labdd_v1_custom_web_json
             WHERE LOWER(module_name) = v_module
               AND (p_status     IS NULL OR COALESCE((datajson->'data'->>'status')::smallint, 0) = p_status)
               AND (p_start_date IS NULL OR created_date >= p_start_date)
               AND (p_end_date   IS NULL OR created_date <  p_end_date + 1)
             ORDER BY created_date DESC
             LIMIT  COALESCE(p_itemnumber, 25)
             OFFSET v_offset) AS s;

    p_form_builder_json := jsonb_build_object('data', p_form_builder_json);
END;
$$;


--
