-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ll_store_user_details(character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: labgt_ll_store_user_details(character varying, character varying, character varying); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ll_store_user_details(p_userid character varying, p_llid character varying, p_access_token character varying, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_userid character varying(1000);
    v_llid character varying(1000);
    v_access_token text;
    v_created_at timestamp without time zone;
BEGIN
    -- Initialize output
    p_result := false;
    
    -- Assign input parameters
    v_userid := p_userid;
    v_llid := p_llid;
    v_access_token := p_access_token;
    v_created_at := current_timestamp at time zone 'utc';
    
    -- Validate inputs
    IF v_userid IS NULL OR v_llid IS NULL OR v_access_token IS NULL THEN
        p_result := false;
        RETURN;
    END IF;
    
    -- Insert user details
    INSERT INTO labgt.labgt_livelike_users (
        userid,
        llid,
        access_token,
        created_at
    )
    VALUES (
        v_userid,
        v_llid,
        v_access_token,
        v_created_at
    );
    
    -- If insert successful, return true
    IF FOUND THEN
        p_result := true;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        p_result := false;
        RAISE NOTICE 'Error in labgt_ll_store_user_details: %', SQLERRM;
END;
$$;


--
