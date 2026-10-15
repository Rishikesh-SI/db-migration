-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_upd_user_subscription(jsonb)
-- Type: FUNCTION

-- Name: gpn_upd_user_subscription(jsonb); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_upd_user_subscription(p_user_subscription_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
     v_user_topic_map_id_arr numeric[];
     v_json json;
     v_user_topic_map_id numeric;
     v_user_id numeric;
     v_application_id numeric;
     v_topic_id numeric;
     v_subscription_arn text;
     v_new_user_policy text;
     
begin
     
     for v_json in select json_array_elements(p_user_subscription_json::json)
     loop
     	
          select v_json->>'UserTopicMapID', v_json->>'UserID', v_json->>'ApplicationID', v_json->>'TopicID', v_json->>'SubscriptionARN',
          		v_json->>'FilterPolicy', v_json->>'EndPointArn'
		into v_user_topic_map_id, v_user_id, v_application_id, v_topic_id, v_subscription_arn, v_new_user_policy;
          
          update gpn_v2.gpn_user_topic_map
          set status = 1, applied_user_policy = v_new_user_policy, new_user_policy = null, subscription_arn = v_subscription_arn,
          	failed_attempts = 0
          where application_id = v_application_id
          and user_topic_map_id = v_user_topic_map_id
          and user_id = v_user_id
          and topic_id = v_topic_id
          and new_user_policy = v_new_user_policy
          and status = 4;
          
     end loop;
     
     p_result := 1;
     
/*exception
	when others then
     	p_result := -1;*/
end;

$$;


--
