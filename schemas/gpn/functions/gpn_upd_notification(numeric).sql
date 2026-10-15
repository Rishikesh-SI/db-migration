-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_upd_notification(numeric)
-- Type: FUNCTION

-- Name: gpn_upd_notification(numeric); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_upd_notification(p_notification_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

BEGIN
	
    UPDATE GPN.GPN_NOTIFICATION
    SET    STATUS         = 1,
           UPDATED_DATE    = current_timestamp at time zone 'utc' ,
           IS_ACTIVE       = 0,
           IS_DELETED      = 1
    WHERE  NOTIFICATION_ID = P_NOTIFICATION_ID;
    
    P_RESULT := 1;
	
EXCEPTION
	WHEN OTHERS THEN
    	P_RESULT := -1;

END;

$$;


--
