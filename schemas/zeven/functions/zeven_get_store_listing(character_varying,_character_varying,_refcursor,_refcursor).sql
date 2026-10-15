-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_store_listing(character varying, character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_store_listing(character varying, character varying, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_store_listing(p_state character varying, p_city character varying, p_result refcursor, p_store_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
  
  v_state zeven.zeven_partner_store_info.state%type = upper(p_state);
  v_city zeven.zeven_partner_store_info.city%type = upper(p_city);
  
begin

  open p_store_cur for
  select *
  from zeven.zeven_partner_store_info
  where upper(state) = coalesce(v_state,upper(state))
  and upper(city) = coalesce(v_city,upper(city))
  order by state, city;
  
  open p_result for select 1 as p_result;
  
exception
  when others then
    open p_result for select -1 as p_result;
    
end;

$$;


--
