-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_sport_list(refcursor)
-- Type: FUNCTION

-- Name: zeven_sport_list(refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_sport_list(p_cur_sport_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin

open p_cur_sport_list for
  select      sport_master_id,
              sport_name,
              created_date,
              update_date,
              created_by,
              updated_by
  from      zeven.zeven_sport_master
  where       sport_master_id not in (1,2)
    and       is_active   = 1
    and       is_delete   = 0;
end;
$$;


--
