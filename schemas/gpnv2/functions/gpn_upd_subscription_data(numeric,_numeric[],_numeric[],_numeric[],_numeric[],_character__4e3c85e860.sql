-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_upd_subscription_data(numeric, numeric[], numeric[], numeric[], numeric[], character varying[], character varying[])
-- Type: FUNCTION

-- Name: gpn_upd_subscription_data(numeric, numeric[], numeric[], numeric[], numeric[], character varying[], character varying[]); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_upd_subscription_data(p_option_type numeric, p_user_topic_map_id numeric[], p_application_id numeric[], p_user_id numeric[], p_topic_id numeric[], p_user_subscription_arn character varying[], p_endpoint character varying[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_application_id_arr numeric[];
	v_application_id numeric;
	
begin
	
	if p_option_type = 1 then
		
		drop table if exists t_user_topic_map_upd;
		
		create temp table t_user_topic_map_upd
		(
			c_user_topic_map_id numeric,
			c_application_id numeric,
			c_user_id numeric,
			c_topic_id numeric,
			c_subscription_arn text,
			c_endpoint text
		);
		
		insert into t_user_topic_map_upd(c_user_topic_map_id, c_application_id, c_user_id, c_topic_id,
								   c_subscription_arn, c_endpoint)
		select unnest(p_user_topic_map_id), unnest(p_application_id), unnest(p_user_id), unnest(p_topic_id),
				unnest(p_user_subscription_arn), unnest(p_endpoint);
		
		select array(select distinct c_application_id
				   from t_user_topic_map_upd)
		into v_application_id_arr;
		
		for v_application_id in(select application_id from unnest(v_application_id_arr) u(application_id))
		loop
			
			update gpnv2.gpn_user_topic_map utm
			set subscription_arn = tab.c_subscription_arn,
				status = 1,
				endpoint_arn=c_endpoint
			from t_user_topic_map_upd tab
			where utm.application_id = v_application_id
			and tab.c_application_id = utm.application_id
			and tab.c_user_topic_map_id = utm.user_topic_map_id
			and tab.c_user_id = utm.user_id
			and tab.c_topic_id = utm.topic_id
			and utm.status = 4
			and utm.subscription_arn is null;
			
			if v_application_id in (4,5,6) then
			update gpnv2.gpn_user utm
			set endpoint_arn=c_endpoint
			from t_user_topic_map_upd tab
			where utm.application_id = v_application_id
			 and tab.c_application_id = utm.application_id
			 and tab.c_user_id = utm.user_id;
			end if;
			
			update gpnv2.gpn_user_topic_change utc
			set subscription_arn = tab.c_subscription_arn,
			endpoint_arn=tab.c_endpoint
			from t_user_topic_map_upd tab
			where utc.application_id = v_application_id
			and tab.c_application_id = utc.application_id
			and tab.c_user_topic_map_id = utc.user_topic_map_id
			and tab.c_user_id = utc.user_id
			and tab.c_topic_id = utc.topic_id
			and utc.subscription_arn = ' ';
			
		end loop;
		
	else
		
		update gpnv2.gpn_user_topic_map
		set status = -1
		where application_id = p_application_id[1]
		and user_topic_map_id = p_user_topic_map_id[1]
		and user_id = p_user_id[1]
		and topic_id = p_topic_id[1]
		and status = 4
		and subscription_arn is null;
		
		delete from gpnv2.gpn_user_topic_change
		where application_id = p_application_id[1]
		and user_topic_map_id = p_user_topic_map_id[1]
		and user_id = p_user_id[1]
		and topic_id = p_topic_id[1]
		and subscription_arn = ' ';
		
	end if;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
