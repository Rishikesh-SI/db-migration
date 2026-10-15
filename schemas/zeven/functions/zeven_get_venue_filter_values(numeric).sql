-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_venue_filter_values(numeric)
-- Type: FUNCTION

-- Name: zeven_get_venue_filter_values(numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_venue_filter_values(p_zeven_venue_masterid numeric, OUT p_venue_filter_values_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

BEGIN

  OPEN P_VENUE_FILTER_VALUES_CUR FOR
  SELECT * FROM zeven.ZEVEN_VENUE_FILTER_VALUES
  WHERE   --ZEVEN_VENUE_FILTER_VALUESID=NVL(P_ZEVEN_VENUE_FILTER_VALUESID,ZEVEN_VENUE_FILTER_VALUESID);
  VENUE_MASTERID = COALESCE(P_ZEVEN_VENUE_MASTERID,VENUE_MASTERID);
  
 
END;

$$;


--
