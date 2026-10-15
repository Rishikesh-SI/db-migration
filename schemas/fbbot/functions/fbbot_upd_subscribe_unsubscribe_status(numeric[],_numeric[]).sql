-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_upd_subscribe_unsubscribe_status(numeric[], numeric[])
-- Type: FUNCTION

-- Name: fbbot_upd_subscribe_unsubscribe_status(numeric[], numeric[]); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_upd_subscribe_unsubscribe_status(p_subscribe_arr numeric[], p_unsubscribe_arr numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
    update fbbot.fbbot_user_team_map
    set status = 2
    where user_id in(select unnest(p_subscribe_arr))
    and status = 1;
    
    update fbbot.fbbot_user_list_change
    set status = 2
    where user_id in(select unnest(p_unsubscribe_arr))
    and status = 1;
    
    p_result := 1;
    
exception
	when others then
    	p_result := -1;
        
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
