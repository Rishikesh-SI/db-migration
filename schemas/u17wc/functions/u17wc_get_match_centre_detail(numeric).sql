-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_match_centre_detail(numeric)
-- Type: FUNCTION

-- Name: u17wc_get_match_centre_detail(numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_match_centre_detail(p_match_centre_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
begin
	
    if exists(select 1 from u17wc.u17wc_match_centre where match_centre_id = p_match_centre_id) then
    	
        select match_centre_json
        into   p_json
        from   u17wc.u17wc_match_centre
        where  match_centre_id = p_match_centre_id;
        
    else
    	
        p_json := '{"data":{}}';
        
    end if;
    
end;
$$;


--
