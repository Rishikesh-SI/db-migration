-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ll_get_user_details(character varying)
-- Type: FUNCTION

-- Name: labgt_ll_get_user_details(character varying); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ll_get_user_details(p_user_guid character varying, OUT p_llid character varying, OUT p_access_token text) RETURNS record
    LANGUAGE plpgsql STABLE PARALLEL SAFE
    AS $$
DECLARE
    v_user_guid character varying(1000);
BEGIN
    -- Assign input parameter
    v_user_guid := p_user_guid;
    
    -- Initialize outputs as NULL
    p_llid := NULL;
    p_access_token := NULL;
    
    -- Fetch credentials (READ-ONLY operation)
    SELECT llid, access_token
    INTO p_llid, p_access_token
    FROM labgt.labgt_livelike_users
    WHERE userid = v_user_guid
    LIMIT 1;
    
EXCEPTION
    WHEN OTHERS THEN
        p_llid := NULL;
        p_access_token := NULL;
        RAISE NOTICE 'Error in labgt_ll_get_user_details: %', SQLERRM;
END;
$$;


--
