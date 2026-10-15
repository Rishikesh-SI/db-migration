-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_upd_failed_tokens(character varying, character varying)
-- Type: FUNCTION

-- Name: gpn_upd_failed_tokens(character varying, character varying); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_upd_failed_tokens(p_device_token character varying, p_topic_arn character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_user_id numeric;
    v_topic_id numeric;
    v_current_timestanp timestamp without time zone := current_timestamp;
    
begin
	
    select user_id
    into   v_user_id
    from   gpn.gpn_user
    where  device_token = p_device_token;
    
    select topic_id
    into   v_topic_id
    from   gpn.gpn_topic
    where  topic_arn = p_topic_arn;
    
    if v_user_id is not null and v_topic_id is not null then
    	
        update gpn.gpn_user_topic_map
    	set    status = -1,
        	   updated_date = v_current_timestanp
    	where  user_id = v_user_id
       	and    topic_id = v_topic_id
    	and    status = 0;
        
        p_result := 1;
        
	else
        
        p_result := -1;
        
    end if;
	
end;

$$;


--
