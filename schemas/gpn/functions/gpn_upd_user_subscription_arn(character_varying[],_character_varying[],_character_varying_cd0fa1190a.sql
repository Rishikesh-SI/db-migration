-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_upd_user_subscription_arn(character varying[], character varying[], character varying[], character varying[])
-- Type: FUNCTION

-- Name: gpn_upd_user_subscription_arn(character varying[], character varying[], character varying[], character varying[]); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_upd_user_subscription_arn(p_user_topic_map_id character varying[], p_user_id character varying[], p_topic_id character varying[], p_user_subscription_arn character varying[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
    v_current_timestamp timestamp := current_timestamp;
BEGIN

	/*WITH TAB_GPN_USER_TOPIC_MAP_UPD AS
    (
        SELECT *
        FROM UNNEST(P_TOPIC_ARN, P_USER_SUBSCRIPTION_ARN, P_DEVICE_TOKEN) U(TOPIC_ARN,SUBSCRIPTION_ARN,DEVICE_TOKEN)
    )
    UPDATE GPN.GPN_USER_TOPIC_MAP UTM
    SET    SUBSCRIPTION_ARN = T1.SUBSCRIPTION_ARN,updated_date=v_current_timestamp
        --   STATUS              = 1
    FROM   TAB_GPN_USER_TOPIC_MAP_UPD T1
    WHERE  UTM.USER_ID          = (SELECT U.USER_ID
                                    FROM   GPN.GPN_USER U
                                    WHERE  U.USER_ID      = UTM.USER_ID
                                    AND    U.DEVICE_TOKEN = T1.DEVICE_TOKEN)
      AND    UTM.TOPIC_ID         = (SELECT T.TOPIC_ID
                                    FROM   GPN.GPN_TOPIC T
                                    WHERE  T.TOPIC_ID  = UTM.TOPIC_ID
                                    AND    T.TOPIC_ARN = T1.TOPIC_ARN);*/
                                    
	with tab_gpn_user_topic_map_upd as
    (
        select *
        from unnest(p_user_topic_map_id, p_user_id, p_topic_id, p_user_subscription_arn)
        	 u(user_topic_map_id, user_id, topic_id, user_subscription_arn)
    )
    update gpn.gpn_user_topic_map utm
    set    subscription_arn = t.user_subscription_arn,
    	   updated_date = v_current_timestamp
           -- status = 1
    from   tab_gpn_user_topic_map_upd t
    where  utm.user_topic_map_id = t.user_topic_map_id::numeric
    and    utm.user_id           = t.user_id::numeric
    and    utm.topic_id          = t.topic_id::numeric;
                                    
                                    
--    DELETE 
--    FROM   GPN.GPN_USER_TOPIC_CHANGE UTC
--    WHERE  EXISTS(SELECT 1
--                  FROM   GPN.GPN_USER_TOPIC_MAP UTM
--                  WHERE  UTM.USER_ID  = UTC.USER_ID
--                  AND    STATUS      = 1)
--    AND   option = 2; 
--    
  
    
    P_RESULT := 1;
    
END;

$$;


--
