-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour_team_get(integer, integer, refcursor)
-- Type: FUNCTION

-- Name: ss_tour_team_get(integer, integer, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_tour_team_get(p_opt_type integer, p_cf_tourid integer, p_team_details refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  P.KHAMKAR              03/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************
BEGIN
        
	--------------------------------------------------------------------
        /* GET TEAM DETAILS */
        
        OPEN P_TEAM_DETAILS FOR
        SELECT
        C.CF_TEAMID,
        C.TEAM_NAME,
        C.TEAM_SHORT_NAME
        FROM  eks.SS_TOUR_TEAM C
        WHERE IS_ACTIVE =1
        AND   CF_TOURID=P_CF_TOURID
       -- ORDER BY TEAM_NAME
       ORDER BY random()
          ;
        
	--------------------------------------------------------------------

END;

$$;


--
