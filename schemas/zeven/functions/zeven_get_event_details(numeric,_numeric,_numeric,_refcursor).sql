-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_event_details(numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_event_details(numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_event_details(p_venue_masterid numeric, p_page_number numeric, p_item_count numeric, p_cur_event refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
v_from_row_number	numeric = 0;
v_to_row_number	numeric = 0;
v_ist_time timestamp(0) = (current_timestamp) + interval '690'  minute;

begin

  v_from_row_number := (p_item_count * p_page_number - (p_item_count-1));
  v_to_row_number := (p_item_count * p_page_number);
  
  open p_cur_event for
    select  zeven_eventid,event_name,event_date,event_desc,start_time,event_end_date,end_time,image_path
    from    (
              select  row_number () over ( order by event_date desc) order_no,
                      zeven_eventid,event_name,event_date,event_desc,start_time,event_end_date,end_time,image_path
              from    zeven.zeven_event 
              where   venue_masterid = p_venue_masterid 
                      and
                      is_published = 1
                      and
                      is_deleted = 0
                      and
                      event_end_date >= v_ist_time
            )a
    where order_no between v_from_row_number and v_to_row_number 
    order by  event_date desc;

end;
$$;


--
