-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_store_state_city(character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_store_state_city(character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_store_state_city(p_state character varying, p_result refcursor, p_state_cur refcursor, p_city_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
  
  v_state zeven.zeven_partner_store_info.state%type = upper(p_state);
  
begin

  open p_state_cur for
  select distinct state
  from zeven.zeven_partner_store_info
  order by state;
  
  open p_city_cur for
  select distinct city
  from zeven.zeven_partner_store_info
  where upper(state) = coalesce(v_state,upper(state))
  order by city;
  
  open p_result for select 1 as p_result;
  
exception
  when others then
    open p_result for select -1 as p_result;
end;

$$;


--
