-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_facilities(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_facilities(numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_facilities(p_sport_masterid numeric, p_venue_masterid numeric, p_cur_facility refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin
  open p_cur_facility for
    select  venue_masterid,venue_name,shortname,display_name,known_as,venue_parentid
    from    zeven.zeven_venue_master
    where   venue_masterid = coalesce (p_venue_masterid,venue_masterid) and venue_type = 2 
            and sport_master_id = coalesce(p_sport_masterid,sport_master_id);
end ;
$$;


--
