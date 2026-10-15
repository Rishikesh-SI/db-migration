-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_upd_dob(jsonb)
-- Type: FUNCTION

-- Name: labgt_upd_dob(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_upd_dob(p_input jsonb, OUT p_output numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_dob text;
    v_user_guid character varying;
BEGIN
   
    v_dob := p_input->>'dob';
    v_user_guid := p_input->>'waf_user_guid'::character varying;

IF NOT EXISTS (
        SELECT 1
        FROM labgt.labgt_web_user
        WHERE user_guid = v_user_guid
    ) THEN
        p_output := 0; 
    ELSE

    UPDATE labgt.labgt_web_user
    SET dob = v_dob
    WHERE user_guid = v_user_guid;

        p_output := 1;  
END IF;
END;
$$;


--
