-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_zeven_event(numeric, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, numeric, numeric, numeric, character varying, numeric, numeric, character varying, character varying, numeric)
-- Type: FUNCTION

-- Name: zeven_set_zeven_event(numeric, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, numeric, numeric, numeric, character varying, numeric, numeric, character varying, character varying, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_zeven_event(p_zeven_eventid numeric, p_event_name character varying, p_event_date timestamp without time zone, p_start_time character varying, p_event_end_date timestamp without time zone, p_end_time character varying, p_is_published numeric, p_is_deleted numeric, p_registration_fee numeric, p_winning_prize character varying, p_event_type numeric, p_venue_masterid numeric, p_event_desc character varying, p_image_path character varying, p_opt_type numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_sysdate timestamp(0) = current_timestamp;
v_zeven_eventid zeven.zeven_event.zeven_eventid%type;
v_venue_parentid numeric;
v_filterid numeric;
v_venue_masterid numeric;

begin

--------opt type 1 for insert data into table -------
  begin
  select  venue_parentid
  into  strict  v_venue_parentid
  from    zeven.zeven_venue_master 
  where   venue_masterid = p_venue_masterid;
   exception 
    when no_data_found then
    v_venue_parentid := 0; 
  end;
if p_opt_type = 1 then

    v_zeven_eventid := nextval('zeven.seq_zeven_eventid');
    
    insert into zeven.zeven_event
    (zeven_eventid,event_name,event_date,is_published,is_deleted,registration_fee,winning_prize,event_type,created_date,updated_date,venue_masterid,event_desc,venue_parentid,event_end_date,start_time,end_time,
    image_path)
    values
    (
    v_zeven_eventid,p_event_name,p_event_date,p_is_published,p_is_deleted,p_registration_fee,p_winning_prize,p_event_type,v_sysdate,v_sysdate,p_venue_masterid,p_event_desc,v_venue_parentid,p_event_end_date,
    p_start_time,p_end_time,p_image_path
    );
  
    update  zeven.zeven_venue_master
    set     event = coalesce(event::numeric,0) + 1
    where   venue_masterid = p_venue_masterid;
    
    v_filterid := nextval('zeven.seq_zeven_venue_filter_values_id');
    insert into zeven.zeven_venue_filter_values
    (
      zeven_venue_filter_valuesid,venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,created_date,updated_date                   
    )
    select  v_filterid,p_venue_masterid,7,7,0,1,v_sysdate,v_sysdate;
	
    p_ret_type :=v_zeven_eventid;
end if;
--------opt type 2 for update table -------
if p_opt_type = 2 then

    update zeven.zeven_event
    set    event_name       = coalesce(p_event_name, event_name) ,
           event_date       = coalesce(p_event_date, event_date),
           event_end_date   = coalesce(p_event_end_date, event_date),
           start_time       = coalesce(p_start_time, start_time),
           end_time         = coalesce(p_end_time, end_time),
           is_published     = coalesce(p_is_published, is_published),
           is_deleted       = coalesce(p_is_deleted, is_deleted) ,
           registration_fee = coalesce(p_registration_fee, registration_fee),
           winning_prize    = coalesce(p_winning_prize, winning_prize) ,
           event_type       = coalesce(p_event_type, event_type),
           updated_date     = v_sysdate,
           event_desc       = coalesce(p_event_desc, event_desc),
           image_path       = coalesce(p_image_path, image_path)
    where  zeven_eventid    = p_zeven_eventid;
     p_ret_type := 1;
end if;
-----------opt type 3 for delete------
if p_opt_type = 3 then

    delete from zeven.zeven_event
    where  zeven_eventid=p_zeven_eventid;
     p_ret_type := 1;
end if;

 

  
exception 
when others then 

p_ret_type := -1;

end;

$$;


--
