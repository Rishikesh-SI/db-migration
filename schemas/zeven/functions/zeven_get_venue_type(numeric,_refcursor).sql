-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_venue_type(numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_venue_type(numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_venue_type(p_zeven_venue_typeid numeric, p_venue_type_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin

      open p_venue_type_cur for 
      select  *
      from   zeven.zeven_venue_type 
      where   zeven_venue_typeid = coalesce(p_zeven_venue_typeid,zeven_venue_typeid); 

end;
$$;


--
