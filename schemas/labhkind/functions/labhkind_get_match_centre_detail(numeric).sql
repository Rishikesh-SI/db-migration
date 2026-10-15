-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_match_centre_detail(numeric)
-- Type: FUNCTION

-- Name: labhkind_get_match_centre_detail(numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_match_centre_detail(p_match_centre_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
begin
	
    if exists(select 1 from labhkind.labhkind_match_centre where match_centre_id = p_match_centre_id) then
    	
        select match_centre_json
        into   p_json
        from   labhkind.labhkind_match_centre
        where  match_centre_id = p_match_centre_id;
        
    else
    	
        p_json := '{"data":{}}';
        
    end if;
    
end;
$$;


--
