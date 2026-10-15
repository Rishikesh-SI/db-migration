-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_upd_matchstory(numeric, numeric, text)
-- Type: FUNCTION

-- Name: sibot_upd_matchstory(numeric, numeric, text); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_upd_matchstory(p_application_id numeric, p_match_id numeric, p_matchstory_url text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
    update sibot.sibot_application_match_map
    set matchstory_url = p_matchstory_url
    where match_id = p_match_id and application_id = p_application_id;
    
    p_result := 1;
    
exception
	when others then
    	p_result := -1;
end;

$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
