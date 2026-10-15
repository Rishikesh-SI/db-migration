-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_match_centre_status(numeric, character varying)
-- Type: FUNCTION

-- Name: labhkind_get_match_centre_status(numeric, character varying); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_match_centre_status(p_match_centre_id numeric, p_match_source_object_id character varying, OUT p_status numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
    select match_centre_json->'data'->>'status'
    into strict p_status
    from labhkind.labhkind_match_centre
    where match_centre_id = coalesce(p_match_centre_id, match_centre_id)
    and match_source_object_id = coalesce(p_match_source_object_id, match_source_object_id);

exception
	when no_data_found then
    	p_status := -1;

end;
$$;


--
