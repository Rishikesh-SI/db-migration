-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_ins_lb_users_mi(numeric, text[], text[])
-- Type: FUNCTION

-- Name: siwaf_ins_lb_users_mi(numeric, text[], text[]); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf.siwaf_ins_lb_users_mi(p_opt_type numeric, p_username text[], p_password text[]) RETURNS TABLE(user_id numeric, user_name text, user_pwd character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE

v_client_name TEXT := 'MI';
v_client_id NUMERIC := 47;

v_fullname TEXT;
v_user_id NUMERIC;
v_map_id NUMERIC;

i INT;
v_start INT;
v_end INT;

BEGIN

/*
SELECT *
FROM siwaf.siwaf_ins_lb_users(
2,
ARRAY[
--'mi',
'amey',
'QA_Team',
'Abhay',
'Akshay',
'dhruv',
'ganesh',
'hanumant',
'sanskar',
'shruti',
'snehal',
'supriya',
'vibhor',
'aditya',
'akshay_sawant',
'chetan',
'gaurav',
'sandeep',
'sudhakar',
'vrushikesh',
'abhijeet',
'narendra',
'nitesh'
],
ARRAY[
--'45537343653232554145595446476D72326B316655773D3D',
'6762354C7663565245386531306C5774795744706E513D3D',
'5976704C433758626C316257525646504377437337513D3D',
'6D33463242414666386D4D6F7559316B66587A4171413D3D',
'4D2F55525A6A4E4C766A564769747A4837382B2F46673D3D',
'5031546C366A337253467A7046484B676E774E566D773D3D',
'777A45384A2F534C37533764734B79664D566D474A773D3D',
'6A4D70704F5A6A3677596F6F677067422B336D3839513D3D',
'523636426C6F4A7135516D6E576649424450716956773D3D',
'6542544761705370583279635746733371514D336E413D3D',
'51704D306948446D473258663279366C3267347162773D3D',
'5879452F5247486D3261686F6135646445754C4647773D3D',
'796A777076752B586543787275534370762F726A67513D3D',
'664548502B5941573037574E317963584E486E4F6A773D3D',
'584D54396C33705451383768793436485133354732413D3D',
'5232574741754749306F57344548416A507843344E513D3D',
'59544F424B38785263305A68547962365254786268773D3D',
'6F414677653635614C6F7838423733484B52544967773D3D',
'657572677747466A37504F526B7076635A31434869773D3D',
'48454744532F44306E4F33326F586175454D584E65673D3D',
'45477271716D6D633339754E326E55526D5655464F773D3D',
'595A67586F666F56313755654A5956373451717342413D3D',
'464168674148556E44663756536B523655684B7242773D3D'
]
);
*/

IF p_opt_type = 2 THEN
    IF array_length(p_username,1) IS DISTINCT FROM array_length(p_password,1) THEN
        RAISE EXCEPTION 'Username array length (%) must equal password array length (%)',
        array_length(p_username,1), array_length(p_password,1);
    END IF;
END IF;


IF p_opt_type = 1 THEN

    RETURN QUERY
    SELECT
        u.user_id::numeric,
        u.user_name::text,
        u.user_pwd::varchar
    FROM waf_master.waf_user u
    WHERE lower(u.user_name) ILIKE p_username[array_lower(p_username,1)] || '%';

    RETURN;

END IF;

------------------------------------------------------------------
-- OPTION 2 : INSERT USERS (MI ONLY)
------------------------------------------------------------------

IF p_opt_type = 2 THEN

RAISE NOTICE 'Starting MI user creation';

v_start := array_lower(p_username,1);
v_end := array_upper(p_username,1);

FOR i IN v_start..v_end
LOOP

    v_fullname := p_username[i] || '_' || v_client_name;

    ---------------------------------------------------
    -- CHECK IF USER EXISTS (CASE INSENSITIVE)
    ---------------------------------------------------

    IF EXISTS (
        SELECT 1
        FROM waf_master.waf_user u
        WHERE lower(u.user_name) ILIKE lower(v_fullname)
    ) THEN

        RAISE NOTICE 'User % already exists. Skipping...', v_fullname;

        RETURN QUERY
        SELECT
            u.user_id::numeric,
            u.user_name::text,
            u.user_pwd::varchar
        FROM waf_master.waf_user u
        WHERE u.user_name ILIKE v_fullname;

        CONTINUE;

    END IF;

    ---------------------------------------------------
    -- GENERATE USER ID
    ---------------------------------------------------

    SELECT COALESCE(MAX(user_id),0) + 1
    INTO v_user_id
    FROM waf_master.waf_user;

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
        p_password[i],
        1
    );

    ---------------------------------------------------
    -- GENERATE USER CLIENT MAP ID
    ---------------------------------------------------

    SELECT COALESCE(MAX(user_client_map_id),0) + 1
    INTO v_map_id
    FROM waf_master.waf_user_client_map;

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
        p_password[i];

END LOOP;

RAISE NOTICE 'MI user creation completed';

END IF;

END;

$$;


--
