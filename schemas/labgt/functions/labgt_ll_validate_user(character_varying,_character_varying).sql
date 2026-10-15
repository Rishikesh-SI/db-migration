-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ll_validate_user(character varying, character varying)
-- Type: FUNCTION

-- Name: labgt_ll_validate_user(character varying, character varying); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ll_validate_user(p_llid character varying, p_access_token character varying, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_llid character varying(1000);
    v_access_token text;
    v_count numeric;
BEGIN
    -- Initialize output
    p_result := false;
    
    -- Assign input parameters
    v_llid := p_llid;
    v_access_token := p_access_token;
    
    -- Validate inputs
    IF v_llid IS NULL OR v_access_token IS NULL THEN
        p_result := false;
        RETURN;
    END IF;
    
    -- Check if user exists with matching id and access_token
    SELECT COUNT(1) INTO v_count
    FROM labgt.labgt_livelike_users
    WHERE llid = v_llid 
      AND access_token = v_access_token;
    
    -- If record exists, return true
    IF v_count > 0 THEN
        p_result := true;
    ELSE
        p_result := false;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        p_result := false;
        RAISE NOTICE 'Error in labgt_ll_validate_user: %', SQLERRM;
END;
$$;


--
