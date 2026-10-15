-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_city_state_country(refcursor)
-- Type: FUNCTION

-- Name: zeven_get_city_state_country(refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_city_state_country(p_cur_city_state_country refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin 

    open p_cur_city_state_country for 
      select  ct.cityid,ct.city_name,s.stateid,s.state_name,c.countryid,c.country_name
      from    zeven.zeven_city ct
      left join zeven.zeven_state s
            on  s.stateid = ct.stateid
      left join zeven.zeven_country c
            on  c.countryid = s.countryid
     order by city_name;
  
end;
$$;


--
