-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_ins_lb_users(numeric, text, text[])
-- Type: FUNCTION

-- Name: siwaf_ins_lb_users(numeric, text, text[]); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf.siwaf_ins_lb_users(p_opt_type numeric, p_username text, p_password text[]) RETURNS TABLE(user_id numeric, user_name text, user_pwd character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE

v_clients TEXT[][] := ARRAY[
    ARRAY['GT','510'],
    ARRAY['RR','527'],
    ARRAY['KKR_v1','543'],
    ARRAY['DD_v1','547'],
    ARRAY['KC_v1','532'],
    ARRAY['PBKS','511'],
    ARRAY['LSG','526'],
    ARRAY['ILT','553'],
	ARRAY['MSG','562'],
	ARRAY['GSOC','552'],
	ARRAY['MI','47']
	-- fih : 508
]; ----array length 11

v_fullname TEXT;
v_user_id NUMERIC;
v_client_id NUMERIC;
v_map_id NUMERIC;
i INT;

BEGIN

------------------------------------------------------------------
-- OPTION 1 : FETCH EXISTING USERS
------------------------------------------------------------------

IF p_opt_type = 1 THEN

    RAISE NOTICE 'Fetching existing users for username pattern %', p_username;

    RETURN QUERY
    SELECT
        u.user_id::numeric,
        u.user_name::text,
        u.user_pwd::varchar
    FROM waf_master.waf_user u
    WHERE lower(u.user_name) LIKE lower(p_username) || '%';

    RETURN;

END IF;

------------------------------------------------------------------
-- OPTION 2 : INSERT USERS
------------------------------------------------------------------

IF p_opt_type = 2 THEN

RAISE NOTICE 'Starting user creation for username: %', p_username;

FOR i IN 1..array_length(v_clients,1)
LOOP

    v_fullname := p_username || '_' || v_clients[i][1];
    v_client_id := v_clients[i][2]::numeric;

    ---------------------------------------------------
    -- CHECK IF USER EXISTS
    ---------------------------------------------------

    IF EXISTS (
        SELECT 1
        FROM waf_master.waf_user u
        WHERE lower(u.user_name) = lower(v_fullname)
    ) THEN

        RAISE NOTICE 'User % already exists. Skipping...', v_fullname;

        RETURN QUERY
        SELECT
            u.user_id::numeric,
            u.user_name::text,
            u.user_pwd::varchar
        FROM waf_master.waf_user u
        WHERE lower(u.user_name) = lower(v_fullname);

        CONTINUE;

    END IF;

    ---------------------------------------------------
    -- GENERATE USER ID
    ---------------------------------------------------

    SELECT COALESCE(MAX(u.user_id),0) + 1
    INTO v_user_id
    FROM waf_master.waf_user u;

    ---------------------------------------------------
    -- INSERT USER
    ---------------------------------------------------

    INSERT INTO waf_master.waf_user
    (
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
        is_password_changed
    )
    VALUES
    (
        v_user_id,
        v_fullname,
        v_fullname,
        v_fullname,
        1,
        NULL,
        NULL,
        current_timestamp,
        current_timestamp,
        1,
        1,
        1,
        0,
        1,
        uuid_generate_v4(),
        p_password[i]::varchar,
        1
    );

    ---------------------------------------------------
    -- GENERATE USER CLIENT MAP ID
    ---------------------------------------------------

    SELECT COALESCE(MAX(m.user_client_map_id),0) + 1
    INTO v_map_id
    FROM waf_master.waf_user_client_map m;

    ---------------------------------------------------
    -- INSERT CLIENT MAPPING
    ---------------------------------------------------

    INSERT INTO waf_master.waf_user_client_map
    (
        user_client_map_id,
        user_id,
        client_id,
        created_date,
        updated_date,
        created_by,
        updated_by,
        is_active,
        is_deleted,
        is_published,
        ucmap_guid
    )
    VALUES
    (
        v_map_id,
        v_user_id,
        v_client_id,
        current_timestamp,
        current_timestamp,
        1,
        1,
        1,
        0,
        1,
        uuid_generate_v4()
    );

    ---------------------------------------------------
    -- RETURN INSERTED USER
    ---------------------------------------------------

    RETURN QUERY
    SELECT
        v_user_id,
        v_fullname,
        p_password[i]::varchar;

END LOOP;

RAISE NOTICE 'User creation completed';

END IF;

END;

$$;


--
