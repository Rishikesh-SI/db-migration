-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_upd_unsubscription_data(numeric[], numeric[])
-- Type: FUNCTION

-- Name: gpn_upd_unsubscription_data(numeric[], numeric[]); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_upd_unsubscription_data(p_user_topic_change_id numeric[], p_application_id numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_application_id_arr numeric[];
	v_application_id numeric;
	
begin
	
	drop table if exists t_user_topic_change_upd;
	
	create temp table t_user_topic_change_upd
	(
		c_user_topic_change_id numeric,
		c_application_id numeric
	);
	
	insert into t_user_topic_change_upd(c_user_topic_change_id, c_application_id)
	select unnest(p_user_topic_change_id), unnest(p_application_id);
	
	select array(select distinct c_application_id
			   from t_user_topic_change_upd)
	into v_application_id_arr;
	
	for v_application_id in(select application_id from unnest(v_application_id_arr) u(application_id))
	loop
		
		update gpnv2.gpn_user_topic_change utc
		set is_success = 1
		from t_user_topic_change_upd tab
		where utc.application_id = v_application_id
		and tab.c_application_id = utc.application_id
		and tab.c_user_topic_change_id = utc.user_topic_change_id
		and utc.is_success = -1;
		
		delete from gpnv2.gpn_user_topic_map utm
		using gpnv2.gpn_user_topic_change utc
		where utm.application_id = v_application_id
		and utc.application_id = v_application_id
		and utc.application_id = utm.application_id
		and utc.user_topic_map_id = utm.user_topic_map_id
		and utc.user_id = utm.user_id
		and utc.topic_id = utm.topic_id
		and utc.subscription_arn = utm.subscription_arn
		and utc.is_success = 1;
     	
		delete from gpnv2.gpn_user_topic_change
		where application_id = v_application_id
		and is_success = 1;
		
	end loop;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
