-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_get_topics_to_delete(numeric, refcursor)
-- Type: FUNCTION

-- Name: gpn_get_topics_to_delete(numeric, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_get_topics_to_delete(p_league_id numeric, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin
	
	open p_topic_detail for
    select topic_id, topic_name
	from   gpn.gpn_topic
    where  league_id =  p_league_id
    and    topic_arn <> 'na'
    and    status = 1
    and 1=2; -- added by amkini since this sp needs to be revisited
	
end;

$$;


--
