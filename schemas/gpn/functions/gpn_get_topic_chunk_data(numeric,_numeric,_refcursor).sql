-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_get_topic_chunk_data(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: gpn_get_topic_chunk_data(numeric, numeric, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_get_topic_chunk_data(p_topic_id numeric, p_chunk_id numeric, p_topic_chunk_user_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_chunk_start_value numeric;
    v_chunk_end_value numeric;
    v_current_timestamp timestamp := current_timestamp;
    
begin
	
    if exists(select 1 from gpn.gpn_topic_chunk_map where topic_id = p_topic_id and chunk_id = p_chunk_id and status = 0) then
        
        select chunk_start_value, chunk_end_value
        into   v_chunk_start_value, v_chunk_end_value
        from   gpn.gpn_topic_chunk_map
        where  topic_id = p_topic_id
        and    chunk_id = p_chunk_id
        and    status = 0;
        
        update gpn.gpn_topic_chunk_map
        set    status = 1,updated_date=v_current_timestamp
        where  topic_id = p_topic_id
        and    chunk_id = p_chunk_id
        and    status = 0;
        
        open p_topic_chunk_user_detail for
        select user_topic_map_id, topic_id, topic_arn, user_id, device_token, application_id, subscription_arn, application_arn, platform_id,
        	   application_stage
        from
        (
            select row_number() over(order by utm.user_id) slno, utm.user_topic_map_id, t.topic_id, t.topic_arn, u.user_id, u.device_token,
            	   t.application_id, null as subscription_arn, a.application_arn, a.platform_id, a.application_stage
        	from   gpn.gpn_user_topic_map utm
            join   gpn.gpn_topic t
            on     t.topic_id = utm.topic_id
            join   gpn.gpn_user u
            on     u.user_id = utm.user_id
            join   gpn.gpn_application a
            on     a.application_id = t.application_id
        	where  utm.topic_id = p_topic_id
        	 and    utm.status = 4
        )a
        where slno between v_chunk_start_value and v_chunk_end_value;
        
	else
    	
        open p_topic_chunk_user_detail for
        select -1 result;
        
    end if;
    
end;

$$;


--
