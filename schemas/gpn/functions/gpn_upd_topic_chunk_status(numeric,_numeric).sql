-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_upd_topic_chunk_status(numeric, numeric)
-- Type: FUNCTION

-- Name: gpn_upd_topic_chunk_status(numeric, numeric); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_upd_topic_chunk_status(p_topic_id numeric, p_chunk_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
    update gpn.gpn_topic_chunk_map
    set    status = 2
    where  topic_id = p_topic_id
    and    chunk_id = p_chunk_id
    and    status = 1;
    
end;

$$;


--
