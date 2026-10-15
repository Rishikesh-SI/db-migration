-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_del_author_data(jsonb)
-- Type: FUNCTION

-- Name: labtri_del_author_data(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_del_author_data(p_input jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    i text; 
    v_user_id numeric;
    v_currenttimestamp timestamp := current_timestamp;
    v_ref_id jsonb;
BEGIN
    /*
    input
    {"data":{"ref_ids":["f3b539c1-a2df-44a1-8444-d1e2416788d0"]}}
    */ 
    SELECT p_input->'data'->>'ref_ids' INTO v_ref_id;
    RAISE NOTICE 'v_ref_id: %', v_ref_id;

    FOR i IN SELECT value::text FROM jsonb_array_elements_text(v_ref_id) value
    LOOP
        RAISE NOTICE 'i: %', i;

        IF EXISTS (SELECT 1 FROM labtri.labtri_user WHERE ref_id = i) THEN
            UPDATE labtri.labtri_user
            SET    is_published = 0,
                   is_active    = 0,
                   is_deleted   = 1,
                   updated_date = v_currenttimestamp
            WHERE  ref_id = i;

            SELECT user_id INTO v_user_id FROM labtri.labtri_user WHERE ref_id = i;

            UPDATE labtri.labtri_user_role
            SET    updated_date = v_currenttimestamp,
                   is_active    = 0,
                   is_deleted   = 1,
                   is_published = 0
            WHERE  user_id = v_user_id;

            p_result := 1;
        END IF;
    END LOOP;

    IF p_result IS NULL THEN
        p_result := 0;
    END IF;

END;
$$;


--
