-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_delete_topics(numeric[])
-- Type: FUNCTION

-- Name: gpn_delete_topics(numeric[]); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_delete_topics(p_topic_id_arr numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	
begin
	insert into gpnv2.gpn_topic_delete_log
	select p_topic_id_arr,v_current_timestamp;
	
	insert into gpnv2.gpn_topic_deleted(topic_id, topic_name, topic_arn, application_id, league_id, match_id, team_id, event_id,
										subscription_id, language_id, country_id, for_admin_notification, status, created_date, updated_date)
	select topic_id, topic_name, topic_arn, application_id, league_id, match_id, team_id, event_id, subscription_id, language_id, country_id,
			for_admin_notification, status, v_current_timestamp, v_current_timestamp
	from gpnv2.gpn_topic
	where topic_id in(select topic_id from unnest(p_topic_id_arr) u(topic_id));
	
	delete from gpnv2.gpn_topic
	where topic_id in(select topic_id from unnest(p_topic_id_arr) u(topic_id));
	
	p_result := 1;
	
-- exception
-- 	when others then
-- 		p_result := -1;
end;
$$;


--
