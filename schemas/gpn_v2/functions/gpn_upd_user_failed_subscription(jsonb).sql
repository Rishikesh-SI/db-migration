-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_upd_user_failed_subscription(jsonb)
-- Type: FUNCTION

-- Name: gpn_upd_user_failed_subscription(jsonb); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_upd_user_failed_subscription(p_user_failed_subscription_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
     v_user_topic_map_id numeric;
     v_user_id numeric;
     v_application_id numeric;
     v_topic_id numeric;
     v_subscription_arn text;
     v_new_user_policy text;
     v_failed_attempts numeric;
     v_max_failed_attempts numeric := 3;
     
begin
     
     select p_user_failed_subscription_json->>'UserTopicMapID', p_user_failed_subscription_json->>'UserID',
     		p_user_failed_subscription_json->>'ApplicationID', p_user_failed_subscription_json->>'TopicID',
               p_user_failed_subscription_json->>'SubscriptionARN', p_user_failed_subscription_json->>'FilterPolicy',
               p_user_failed_subscription_json->>'EndPointArn'
	into v_user_topic_map_id, v_user_id, v_application_id, v_topic_id, v_subscription_arn, v_new_user_policy;
	
     select failed_attempts
     into v_failed_attempts
     from gpn_v2.gpn_user_topic_map
     where application_id = v_application_id
     and user_topic_map_id = v_user_topic_map_id
     and user_id = v_user_id
     and topic_id = v_topic_id;
     
     if v_failed_attempts < v_max_failed_attempts then
     	
          v_failed_attempts := v_failed_attempts + 1;
          
          update gpn_v2.gpn_user_topic_map
          set failed_attempts = v_failed_attempts, status = 0
          where application_id = v_application_id
          and user_topic_map_id = v_user_topic_map_id
          and user_id = v_user_id
          and topic_id = v_topic_id;
          
	else
     	
          update gpn_v2.gpn_user_topic_map
          set status = -1
          where application_id = v_application_id
          and user_topic_map_id = v_user_topic_map_id
          and user_id = v_user_id
          and topic_id = v_topic_id;
          
     end if;
     
     p_result := 1;
     
/*exception
	when others then
     	p_result := -1;*/
end;

$$;


--
