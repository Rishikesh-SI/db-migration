-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_source_get(refcursor)
-- Type: FUNCTION

-- Name: ss_user_source_get(refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_user_source_get(p_user_source refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  P.KHAMKAR              03/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************

DECLARE

BEGIN
        
	
       OPEN p_user_source FOR
       SELECT distinct user_source from eks.ss_user
       where user_source is not null;
                  

END;

$$;


--
