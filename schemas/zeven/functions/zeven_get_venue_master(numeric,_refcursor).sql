-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_venue_master(numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_venue_master(numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_venue_master(p_venue_masterid numeric, p_venue_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin

      open p_venue_master_cur for 
      select  *
      from    zeven.zeven_venue_master 
      where   venue_masterid = coalesce(p_venue_masterid,venue_masterid) ;

end;
$$;


--
