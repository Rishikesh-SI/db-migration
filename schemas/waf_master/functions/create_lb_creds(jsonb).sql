-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: create_lb_creds(jsonb)
-- Type: FUNCTION

-- Name: create_lb_creds(jsonb); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.create_lb_creds(p_input_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_client_id      INT;
    v_user_name      TEXT;
    v_password       TEXT;
    v_user_id        INT;
    v_now            TIMESTAMP := current_timestamp;
    v_user_guid      UUID := uuid_generate_v4();
BEGIN
    
    v_client_id := COALESCE((p_input_json->>'clientId')::INT, 0);
    v_user_name := (p_input_json->>'user_name');
    v_password  := (p_input_json->>'password');

    IF v_client_id = 0 OR v_user_name IS NULL OR v_password IS NULL THEN
        RAISE EXCEPTION 'Missing required fields: clientId, user_name, or password';
    END IF;

    -- Generate user_id dynamically
    SELECT COALESCE(MAX(user_id), 0) + 1 INTO v_user_id 
    FROM waf_master.waf_user;

    -- Insert into waf_user
    INSERT INTO waf_master.waf_user (
        user_id,
        user_name,
        full_name,
        display_name,
        partner_id,
        email_id,
        profile_picture_url,
        created_date,
        updated_date,
        created_by,
        updated_by,
        is_active,
        is_deleted,
        is_published,
        user_guid,
        user_pwd,
        reset_key,
        key_expiry_date,
        failed_attempts,
        unlock_date,
        bio,
        is_password_changed
    )
    VALUES (
        v_user_id,
        v_user_name,
        v_user_name,
        v_user_name,
        1,
        NULL,
        NULL,
        v_now,
        v_now,
        1,
        1,
        1,
        0,
        1,
        v_user_guid,
        v_password,
        NULL,
        NULL,
        0,
        NULL,
        NULL,
        FALSE
    );

    -- Insert into waf_user_client_map
    INSERT INTO waf_master.waf_user_client_map (
        user_clent_map_id,
        user_id,
        client_id,
        created_date,
        updated_date,
        created_by,
        updated_by,
        is_active,
        is_deleted,
        is_published,
        published_date,
        ucamp_guid
    )
    VALUES (
        v_user_id, 
        v_user_id,
        v_client_id,
        v_now,
        v_now,
        1,
        1,
        1,
        0,
        1,
        v_now,
        uuid_generate_v4()
    );

    -- Return success response
    p_result := jsonb_build_object(
        'status', 'success',
        'user_id', v_user_id,
        'user_name', v_user_name,
        'client_id', v_client_id
    );

END;
$$;


--
