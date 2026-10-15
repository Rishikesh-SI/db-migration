-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_topics_to_delete(refcursor)
-- Type: FUNCTION

-- Name: gpn_get_topics_to_delete(refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_topics_to_delete(p_topics refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_current_timestamp_ist timestamp := v_current_timestamp + '5.5 hours'::interval;
	v_match_id_arr numeric[];
	v_topic_id_arr numeric[];
	v_application_id_arr numeric[];
	v_application_id numeric;
	
begin
	
	select array(select match_id
			   from gpnv2.gpn_match
			   where source_object_id <> '0'
			   and (match_end_date + '1 hours'::interval) < v_current_timestamp_ist)
	into v_match_id_arr;
	
	if array_length(v_match_id_arr,1) <> 0 then
		select array(select topic_id
				   from gpnv2.gpn_topic
				   where subscription_id = 4
				   and match_id in(select match_id from unnest(v_match_id_arr) u(match_id)))
		into v_topic_id_arr;
	end if;
	
	if array_length(v_topic_id_arr,1) <> 0 then
		
		update gpnv2.gpn_topic
		set status = -1,
		updated_date = v_current_timestamp
		where topic_id in(select topic_id from unnest(v_topic_id_arr) u(topic_id));
		
		select array(select distinct application_id
				   from gpnv2.gpn_topic
				   where status = -1)
		into v_application_id_arr;
		
	end if;
	
	for v_application_id in(select application_id from unnest(v_application_id_arr) u(application_id))
	loop
		
		insert into gpnv2.gpn_user_event_subscription_map_deleted(user_event_subscription_map_id, user_id,
													   application_id, league_id, event_id, subscription_id,
													   data_value_id, data_value, created_date)
		select user_event_subscription_map_id, user_id, application_id, league_id, event_id, subscription_id,
				data_value_id, data_value, v_current_timestamp
		from gpnv2.gpn_user_event_subscription_map
		where application_id = v_application_id
		and subscription_id = 4
		and data_value_id in(select match_id from unnest(v_match_id_arr) u(match_id));
		
		delete from gpnv2.gpn_user_event_subscription_map
		where application_id = v_application_id
		and subscription_id = 4
		and data_value_id in(select match_id from unnest(v_match_id_arr) u(match_id));
		
		insert into gpnv2.gpn_user_topic_map_deleted(user_topic_map_id, user_id, application_id, topic_id,
											subscription_arn, status, created_date)
		select user_topic_map_id, user_id, application_id, topic_id, subscription_arn, status, v_current_timestamp
		from gpnv2.gpn_user_topic_map
		where application_id = v_application_id
		and topic_id in(select topic_id from unnest(v_topic_id_arr) u(topic_id));
		
		delete from gpnv2.gpn_user_topic_map
		where application_id = v_application_id
		and topic_id in(select topic_id from unnest(v_topic_id_arr) u(topic_id));
		
	end loop;
	
	open p_topics for
	select topic_id, topic_name, topic_arn
	from gpnv2.gpn_topic
	where topic_id in(select topic_id from unnest(v_topic_id_arr) u(topic_id));

exception when others then
	open p_topics for
	select null as topic_id, null as topic_name, null as topic_arn
	where 1 = 2;
	
end;
$$;


--
