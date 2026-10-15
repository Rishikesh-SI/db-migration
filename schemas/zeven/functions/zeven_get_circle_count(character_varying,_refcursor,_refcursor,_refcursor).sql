-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_circle_count(character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_circle_count(character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_circle_count(p_circle character varying, p_return refcursor, p_circlecount refcursor, p_totalcount refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
  v_total_count numeric;
  v_likes_count numeric;

begin

  
  open p_circlecount for
  select upper(telo_circle)telo_circle,count(*)total_count
  from zeven.zeven_misscall_pledge_detail
  where upper(telo_circle) = coalesce(upper(p_circle),upper(telo_circle))
  and telo_circle is not null
  group by upper(telo_circle)
  order by upper(telo_circle);
  
  select count(*)
  into v_total_count
  from zeven.zeven_misscall_pledge_detail
  where telo_circle is not null;
  
  select coalesce(sum(likes),0)
  into v_likes_count
  from zeven.zeven_pledge_fblike;
  
  v_total_count := v_total_count + v_likes_count;
  
  open p_totalcount for
  select v_total_count as p_totalcount;
  
  open p_return for select 1 as p_return;
exception
  when others then
    open p_return for select -1 as p_return;
end;

$$;


--
