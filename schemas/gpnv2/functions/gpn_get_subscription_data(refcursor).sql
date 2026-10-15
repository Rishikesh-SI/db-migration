-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_subscription_data(refcursor)
-- Type: FUNCTION

-- Name: gpn_get_subscription_data(refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_subscription_data(p_subscription_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_current_timestamp_ist timestamp := v_current_timestamp + '5.5 hours'::interval;
	v_application_id_arr numeric[];
	v_topic_id_arr numeric[];
	v_application_count numeric;
	v_limit numeric := 6000;
	v_application_limit numeric;
	v_application_id numeric;
	v_application_arn text;
	v_count numeric;
	
begin
	
	select array(select a.application_id
				 from gpnv2.gpn_application a
				 where exists(select 1
							  from gpnv2.gpn_client_league_map clm
							  join gpnv2.gpn_match m
							  on m.league_id = clm.league_id
							  where ((m.match_start_date::date = v_current_timestamp_ist::date
									  or m.match_end_date >= v_current_timestamp_ist)
									 or m.is_active = 1)
							  and clm.client_id = a.client_id)
-- 				 and environment_id = 1
				 -- and a.application_id in(4,6,16,18,28,30)
				)
	into v_application_id_arr;
	
	drop table if exists t_user_topic_map_id;
	
	create temp table t_user_topic_map_id
	(
		c_application_id numeric,
		c_application_arn text,
		c_user_topic_map_id numeric,
		c_user_id numeric,
		c_topic_id numeric,
		c_topic_arn text
	);
	
	select array_length(v_application_id_arr,1) into v_application_count;
	
	select v_limit/v_application_count into v_application_limit;
	
	for v_application_id in (select unnest(v_application_id_arr))
	loop
		
		select application_arn
		into v_application_arn
		from gpnv2.gpn_application
		where application_id = v_application_id;
		
		with tab as
		(
			select application_id, topic_id, topic_arn
			from gpnv2.gpn_topic
			where application_id = v_application_id
			and (match_id in(select match_id from gpnv2.gpn_match
							 where (match_start_date::date = v_current_timestamp_ist::date
									or match_end_date >= v_current_timestamp_ist))
				 or subscription_id in(1,3))
		)
		insert into t_user_topic_map_id(c_application_id, c_application_arn, c_user_topic_map_id, c_user_id, c_topic_id, c_topic_arn)
		select utm.application_id, v_application_arn, utm.user_topic_map_id, utm.user_id, utm.topic_id, t.topic_arn
		from gpnv2.gpn_user_topic_map utm
		join tab t
		on t.application_id = utm.application_id
		and t.topic_id = utm.topic_id
		where utm.application_id = v_application_id
		and utm.status = 0
		and utm.subscription_arn is null
		limit v_application_limit;
		
	end loop;
	
	select count(1)
	into v_count
	from t_user_topic_map_id;
	
	/*if v_count < v_limit then
		
		select a.application_id, a.application_arn
		into v_application_id, v_application_arn
		from (select c_application_id as application_id, count(1) total_rows
			  from t_user_topic_map_id
			  group by c_application_id
			  order by total_rows desc
			  limit 1
			 ) tab
		join gpnv2.gpn_application a
		on a.application_id = tab.application_id;		
		
		with tab as
		(
			select application_id, topic_id, topic_arn
			from gpnv2.gpn_topic
			where application_id = v_application_id
			and (match_id in(select match_id from gpnv2.gpn_match
							 where (match_start_date::date = v_current_timestamp_ist::date
									or match_end_date >= v_current_timestamp_ist))
				 or subscription_id in(1,3))
		)
		insert into t_user_topic_map_id(c_application_id, c_application_arn, c_user_topic_map_id, c_user_id, c_topic_id, c_topic_arn)
		select utm.application_id, v_application_arn, utm.user_topic_map_id, utm.user_id, utm.topic_id, t.topic_arn
		from gpnv2.gpn_user_topic_map utm
		join tab t
		on t.application_id = utm.application_id
		and t.topic_id = utm.topic_id
		where utm.application_id = v_application_id
		and utm.status = 0
		and utm.subscription_arn is null
		and not exists(select 1 from t_user_topic_map_id t where t.c_user_topic_map_id = utm.user_topic_map_id)
		limit (v_limit - v_count);
		
	end if;*/
	
	update gpnv2.gpn_user_topic_map utm
	set status = 4, updated_date = v_current_timestamp
	from t_user_topic_map_id tab
	where tab.c_application_id = utm.application_id
	and tab.c_user_topic_map_id = utm.user_topic_map_id;
	
	open p_subscription_data for
	select tab.c_user_topic_map_id as user_topic_map_id, tab.c_topic_id as topic_id, tab.c_topic_arn as topic_arn, tab.c_user_id as user_id,
			u.device_token, tab.c_application_id as application_id, tab.c_application_arn as application_arn
	from t_user_topic_map_id tab
	join gpnv2.gpn_user u
	on u.application_id = tab.c_application_id
	and u.user_id = tab.c_user_id;
	
end;
$$;


--
