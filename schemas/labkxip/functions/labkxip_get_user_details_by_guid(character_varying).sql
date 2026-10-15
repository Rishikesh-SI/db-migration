-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_user_details_by_guid(character varying)
-- Type: FUNCTION

-- Name: labkxip_get_user_details_by_guid(character varying); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_user_details_by_guid(p_user_guid character varying, OUT p_mobilenum character varying, OUT p_countrycode text, OUT p_firstname text, OUT p_lastname text, OUT p_gender text) RETURNS record
    LANGUAGE plpgsql STABLE PARALLEL SAFE
    AS $$
DECLARE
    v_user_guid character varying(1000);
BEGIN
    -- Assign input parameter
    v_user_guid := p_user_guid;
    
    -- Initialize outputs as NULL
    p_mobileNum := NULL;
    p_countryCode := NULL;
    p_firstName := NULL;
    p_lastName := NULL;
    p_gender := NULL;
    
    -- Fetch credentials 
    SELECT mobile_no, country_code, first_name, last_name, gender
INTO p_mobileNum, p_countryCode, p_firstName, p_lastName, p_gender
FROM labkxip.labkxip_web_user  
WHERE user_guid = p_user_guid
    LIMIT 1;
    
EXCEPTION
    WHEN OTHERS THEN
        p_mobileNum := NULL;
        p_countryCode := NULL;
        p_firstName := NULL;
        p_lastName := NULL;
        p_gender := NULL;
        RAISE NOTICE 'Error in labkxip_get_user_details_by_guid: %', SQLERRM;
END;
$$;


--
