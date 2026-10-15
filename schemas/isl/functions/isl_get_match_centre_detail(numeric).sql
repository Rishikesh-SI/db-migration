-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_match_centre_detail(numeric)
-- Type: FUNCTION

-- Name: isl_get_match_centre_detail(numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_match_centre_detail(p_match_centre_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
begin
	
    if exists(select 1 from isl.isl_match_centre where match_centre_id = p_match_centre_id) then
    	
        select match_centre_json
        into   p_json
        from   isl.isl_match_centre
        where  match_centre_id = p_match_centre_id;
        
    else
    	
        p_json := '{"data":{}}';
        
    end if;
    
end;
$$;


--
