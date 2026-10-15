-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_zeven_event(numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_zeven_event(numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_zeven_event(p_zeven_eventid numeric, p_event_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin
  ---------------get select query----------------
  
      open p_event_cur for 
      select  distinct a.zeven_eventid,
              a.event_name,
              a.event_date,
              a.is_published,
              a.is_deleted,
              a.registration_fee,
              a.winning_prize,
              a.event_type,
              a.created_date,
              a.updated_date,
              a.venue_masterid,
              a.venue_parentid,
              a.event_desc,
              a.event_end_date,
              a.image_path,
              a.start_time,
              a.end_time
      from    zeven.zeven_event a
      where   zeven_eventid = coalesce(p_zeven_eventid,zeven_eventid);
end;
$$;


--
