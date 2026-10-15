-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_store_uuid(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_store_uuid(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_store_uuid(p_uuid_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_uuid character varying;
    v_status numeric;
    v_message character varying;
    v_uuid_id numeric;
BEGIN
    v_uuid := p_uuid_json->>'uuid';

    IF v_uuid IS NULL OR v_uuid = '' THEN
        v_status := 0;
        v_message := 'UUID is required';

    ELSE

        IF not exists (select 1 FROM labdd_v1.labdd_v1_uuid_storage
        WHERE uuid = v_uuid) THEN
            -- insert only if not exists
            INSERT INTO labdd_v1.labdd_v1_uuid_storage (uuid, created_date, updated_date)
            VALUES (v_uuid, v_current_timestamp, v_current_timestamp)
            RETURNING uuid_id INTO v_uuid_id;

            v_status := 1;
            v_message := 'UUID stored successfully';
        ELSE
            -- duplicate found, don’t insert
			update labdd_v1.labdd_v1_uuid_storage
			set updated_date =v_current_timestamp
			WHERE uuid = v_uuid;
			
            v_status := 1;
            v_message := 'Duplicate UUID - not inserted';
        END IF;
    END IF;

    p_result_json := jsonb_build_object(
        'data', jsonb_build_object(
            'status', coalesce(v_status, 1),
            'message', coalesce(v_message, ''),
            'uuid', coalesce(v_uuid, ''),
            'uuid_id', coalesce(v_uuid_id, 0),
            'timestamp', v_current_timestamp
        )
    );
END;

$$;


--
