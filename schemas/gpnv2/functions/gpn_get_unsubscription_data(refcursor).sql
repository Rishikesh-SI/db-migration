-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_unsubscription_data(refcursor)
-- Type: FUNCTION

-- Name: gpn_get_unsubscription_data(refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_unsubscription_data(p_unsubscription_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_current_timestamp_ist timestamp := v_current_timestamp + '5.5 hours'::interval;
	v_application_id_arr numeric[];
	v_application_count numeric;
	v_limit numeric := 5000;
	v_application_limit numeric;
	v_application_id numeric;
	v_count numeric := 0;
	
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
-- 			   and environment_id = 1
				)
	into v_application_id_arr;
	
	drop table if exists t_user_topic_change_id;
	
	create temp table t_user_topic_change_id
	(
		c_application_id numeric,
		c_user_topic_change_id numeric,
		c_priority numeric
	);
	
	select array_length(v_application_id_arr,1) into v_application_count;
	
	if v_application_count <> 0 then
		
		select v_limit/v_application_count into v_application_limit;
		
		for v_application_id in (select unnest(v_application_id_arr))
		loop
			
			insert into t_user_topic_change_id(c_application_id, c_user_topic_change_id, c_priority)
			select application_id, user_topic_change_id, priority
			from (select utc.application_id, utc.user_topic_change_id,
				 		case t.for_admin_notification when 0 then 1 when 1 then 2 end as priority
				 from gpnv2.gpn_user_topic_change utc
				 join gpnv2.gpn_topic t
				 on t.application_id = utc.application_id
				 and t.topic_id = utc.topic_id
				 where utc.application_id = v_application_id
				 and utc.is_success = 0
				 and utc.subscription_arn <> ' ') as tab
			order by priority
			limit v_application_limit;
			
		end loop;
		
	else
		
		select array(select application_id from gpnv2.gpn_application) into v_application_id_arr;
		
		select array_length(v_application_id_arr,1) into v_application_count;
		
		select v_limit/v_application_count into v_application_limit;
		
		for v_application_id in (select unnest(v_application_id_arr))
		loop
			
			insert into t_user_topic_change_id(c_application_id, c_user_topic_change_id)
			select application_id, user_topic_change_id
			from gpnv2.gpn_user_topic_change
			where application_id = v_application_id
			and is_success = 0
			and subscription_arn <> ' '
			limit v_application_limit;
			
		end loop;
		
	end if;
	
	select count(1)
	into v_count
	from t_user_topic_change_id;
	
	if v_count < v_limit then
		
		select application_id
		from (select application_id,count(1) total
			  from gpnv2.gpn_user_topic_change
			  where application_id in(select unnest(v_application_id_arr))
			  and is_success = 0
			  group by application_id
			  order by total desc
			  limit 1) tab
		into v_application_id;
		
		insert into t_user_topic_change_id(c_application_id, c_user_topic_change_id)
		select application_id, user_topic_change_id
		from gpnv2.gpn_user_topic_change
		where application_id = v_application_id
		and is_success = 0
		and subscription_arn <> ' '
		limit (v_limit - v_count);
		
	end if;
	
	update gpnv2.gpn_user_topic_change utc
     set is_success = -1, updated_date = v_current_timestamp
	from t_user_topic_change_id tab
     where tab.c_application_id = utc.application_id
	and tab.c_user_topic_change_id = utc.user_topic_change_id;
	
	open p_unsubscription_data for
	select utc.user_topic_change_id, utc.subscription_arn, t.topic_arn, utc.application_id
	from gpnv2.gpn_user_topic_change utc
	join t_user_topic_change_id tab
	on tab.c_application_id = utc.application_id
	and tab.c_user_topic_change_id = utc.user_topic_change_id
	join gpnv2.gpn_topic t
	on t.application_id = tab.c_application_id
	and t.topic_id = utc.topic_id;
	
end;
$$;


--
