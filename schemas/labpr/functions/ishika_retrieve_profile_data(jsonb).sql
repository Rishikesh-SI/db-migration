-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ishika_retrieve_profile_data(jsonb)
-- Type: FUNCTION

-- Name: ishika_retrieve_profile_data(jsonb); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.ishika_retrieve_profile_data(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id INT;
    v_name TEXT;
    v_country TEXT;
BEGIN

    -- Extract values from the input JSONB
    SELECT 
        p_user_json->'data'->'user'->>'id',
        p_user_json->'data'->'user'->>'name',
        p_user_json->'data'->'user'->>'country'
    INTO 
        v_id,
        v_name,
        v_country;
		
	INSERT INTO labpr.profileIshika(id, name, country)
    VALUES (v_id, v_name, v_country);

    -- Constructing the output JSONB without jsonb_build_object
    p_ures_json := 
        ('{"id": ' || v_id || ', "name": "' || v_name || '", "country": "' || v_country || '"}')::jsonb;

    -- No need for RETURN statement
END;
$$;


--
