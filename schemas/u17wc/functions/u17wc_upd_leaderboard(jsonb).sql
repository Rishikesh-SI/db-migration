-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_upd_leaderboard(jsonb)
-- Type: FUNCTION

-- Name: u17wc_upd_leaderboard(jsonb); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_upd_leaderboard(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_match_source_object_id character varying(50);
    v_match_centre_id numeric;
    
begin
	
    select p_json->'leader_board'->>'match_source_object_id'
    into v_match_source_object_id;
    
    select match_centre_id
    into strict v_match_centre_id
    from u17wc.u17wc_match_centre
    where match_source_object_id = v_match_source_object_id;
    
    update u17wc.u17wc_match_centre
    set leader_board = p_json
    where match_centre_id = v_match_centre_id;
    
    p_result := 1;
    
exception
	when no_data_found then
    	p_result := 0;
	when others then
    	p_result := -1;
end;

$$;


--
