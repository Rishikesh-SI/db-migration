-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_publish_type_list(refcursor)
-- Type: FUNCTION

-- Name: zeven_publish_type_list(refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_publish_type_list(p_cur_type_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin 
  
  open p_cur_type_list for
  select  publish_type_id,
          publish_type_name,
          is_active
  from   zeven.zeven_publish_type_master
  where  is_active = 1;
  
end;
$$;


--
