-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_ins_upd_form_builder(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_ins_upd_form_builder(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_ins_upd_form_builder(p_form_builder_json jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$

DECLARE
    v_module    constant text := 'dadas_delhi_campaign';
    v_requested integer;
    v_updated   integer;
BEGIN
    p_result := false;

    IF p_form_builder_json IS NULL
       OR NOT (p_form_builder_json ? 'data')
       OR jsonb_typeof(p_form_builder_json->'data') <> 'array' THEN
        RAISE EXCEPTION 'Invalid input JSON: "data" is missing or is not an array';
    END IF;

    v_requested := jsonb_array_length(p_form_builder_json->'data');

    IF v_requested = 0 THEN
        RETURN;
    END IF;

    WITH incoming AS (
        SELECT (e->>'customID')::numeric AS custom_id,
               (e->>'status')::smallint  AS status
          FROM jsonb_array_elements(p_form_builder_json->'data') e
         WHERE e->>'customID' ~ '^[0-9]+$'
           AND e->>'status'   ~ '^[0-2]$'
    ),
    updated AS (
        UPDATE labdd_v1.labdd_v1_custom_web_json t
           SET datajson     = jsonb_set(t.datajson, '{data,status}', to_jsonb(i.status)),
               updated_date = CURRENT_TIMESTAMP
          FROM incoming i
         WHERE t.custom_id = i.custom_id
           AND LOWER(t.module_name) = v_module
        RETURNING 1
    )
    SELECT COUNT(*) INTO v_updated FROM updated;

    p_result := (v_updated = v_requested);
END;
$_$;


--
