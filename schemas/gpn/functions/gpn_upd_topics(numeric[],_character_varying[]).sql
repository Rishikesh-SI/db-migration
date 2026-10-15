-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_upd_topics(numeric[], character varying[])
-- Type: FUNCTION

-- Name: gpn_upd_topics(numeric[], character varying[]); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_upd_topics(p_topic_id numeric[], p_topic_arn character varying[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

BEGIN

	WITH TAB_GPN_TOPIC_UPD AS
    (
        SELECT *
        FROM UNNEST(P_TOPIC_ID, P_TOPIC_ARN) U(TOPIC_ID,TOPIC_ARN)
    )
   	UPDATE GPN.GPN_TOPIC T1
   	SET    TOPIC_ARN    = T2.TOPIC_ARN,
    	   STATUS      = 1,
           UPDATED_DATE = current_timestamp,
           IS_ACTIVE    = 1
	FROM   TAB_GPN_TOPIC_UPD T2  
    WHERE  T1.TOPIC_ID     = T2.TOPIC_ID;
	
--    WITH TAB_GPN_USER_TOPIC_MAP_UPD AS
--    (
--        SELECT *
--        FROM UNNEST(P_TOPIC_ID) U(TOPIC_ID)
--    )
--    UPDATE GPN.GPN_USER_TOPIC_MAP T1
--    SET    STATUS   = 1
--    FROM TAB_GPN_USER_TOPIC_MAP_UPD T2
--    WHERE  T1.TOPIC_ID  = T2.TOPIC_ID;
    
    P_RESULT := 1;
    
EXCEPTION
    WHEN OTHERS THEN
      P_RESULT := -1;
END;

$$;


--
