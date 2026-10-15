-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_user_id(character varying)
-- Type: FUNCTION

-- Name: abp_get_user_id(character varying); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_user_id(p_user_name character varying, OUT p_user_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

BEGIN
SELECT USER_ID INTO P_USER_ID

FROM ABP.ABP_USER
WHERE UPPER(full_NAME)=UPPER(P_USER_NAME);
 EXCEPTION WHEN OTHERS THEN P_USER_ID:= -1;
END

$$;


--
