-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_get_users_to_subscribe(refcursor)
-- Type: FUNCTION

-- Name: gpn_get_users_to_subscribe(refcursor); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_get_users_to_subscribe(p_user_subscription_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
     v_user_topic_map_id_arr numeric[];
     
begin
	
     select array(select user_topic_map_id
                  from gpn_v2.gpn_user_topic_map
                  where status in (0,2)
                  and new_user_policy is not null
                  order by created_date desc
                  limit 500)
     into v_user_topic_map_id_arr;
     
     update gpn_v2.gpn_user_topic_map
     set status = 4
     where user_topic_map_id =any(select unnest(v_user_topic_map_id_arr));
     
     open p_user_subscription_data for
     select utm.user_topic_map_id, utm.user_id, u.device_token, utm.application_id, a.application_arn, utm.topic_id, t.topic_arn,
     		utm.subscription_arn, utm.new_user_policy as user_policy
     from gpn_v2.gpn_user_topic_map utm
     join gpn_v2.gpn_user u
     on u.application_id = utm.application_id
     and u.user_id = utm.user_id
     join gpn_v2.gpn_application a
     on a.application_id = u.application_id
     join gpn_v2.gpn_topic t
     on t.topic_id = utm.topic_id
     where utm.user_topic_map_id =any(select unnest(v_user_topic_map_id_arr));
     
end;

$$;


--
