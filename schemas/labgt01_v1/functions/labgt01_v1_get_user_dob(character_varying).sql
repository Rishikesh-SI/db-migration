-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_user_dob(character varying)
-- Type: FUNCTION

-- Name: labgt01_v1_get_user_dob(character varying); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_user_dob(p_user_guid character varying, OUT p_out jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_guid VARCHAR;
BEGIN
    v_user_guid := p_user_guid;

    -- Check if user exists
    IF NOT EXISTS (
        SELECT 1
        FROM labgt01_v1.labgt01_v1_web_user
        WHERE user_guid = v_user_guid
    ) THEN
        p_out := '{}'::jsonb;  -- Empty JSON object if no user is found
    ELSE
        -- Select the user info and return as JSONB
        SELECT jsonb_build_object(
                    'waf_user_guid', user_guid,
                    'dob', dob
               )
        INTO p_out
        FROM labgt01_v1.labgt01_v1_web_user
        WHERE user_guid = v_user_guid;
    END IF;
END;
$$;


--
