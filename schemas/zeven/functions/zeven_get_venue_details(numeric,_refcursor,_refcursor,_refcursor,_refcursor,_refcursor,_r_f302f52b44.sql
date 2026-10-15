-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_venue_details(numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_venue_details(numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_venue_details(p_venue_masterid numeric, p_cur_venue refcursor, p_cur_venue_amenities refcursor, p_cur_venue_sport refcursor, p_cur_venue_rating refcursor, p_cur_venue_comment refcursor, p_cur_venue_event refcursor, p_cur_venue_checkins refcursor, p_want_to_play_cnt refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
v_ist_time timestamp(0) = (current_timestamp) + interval '690'  minute;

begin

  
  open p_cur_venue for
      select  vm.venue_masterid, vm.venue_name, vm.shortname, vm.display_name, vm.known_as, vm.venue_type, vm.venue_parentid, vm.email_id, vm.city_id,city_name, 
              vm.state_id,state_name, vm.country_id, country_name,
              vm.pincode, vm.google_map, vm.description, vm.sport_master_id, vm.capacity, vm.dress_code, vm.price, vm.mobile_no, vm.mobile_no1, vm.telephone_no, 
              vm.timings, vm.is_active, 
              vm.created_date, vm.updated_date, vm.is_featured,vm.address,vm.longitude,vm.latitude,vm.short_address
      from    zeven.zeven_venue_master vm
      left join zeven.zeven_city sc
            on  sc.cityid = vm.city_id
      left join zeven.zeven_state ss
            on  ss.stateid = vm.state_id
      left join zeven.zeven_country sct
            on  sct.countryid = vm.country_id
      where   venue_masterid  = p_venue_masterid;
    
    
    open p_cur_venue_amenities for
      select  distinct vfv.venue_masterid,vfv.zeven_filter_masterid,ft.filter_name ,vfv.venue_filter_value
      from    zeven.zeven_venue_filter_values vfv
      join  zeven.zeven_venue_master g
              on  g.venue_masterid = vfv.venue_masterid::numeric
      join  zeven.zeven_filter_master ft
              on  ft.zeven_filter_masterid = vfv.venue_filter_value::numeric
      where   g.venue_masterid  = p_venue_masterid and vfv.zeven_filter_masterid::numeric = 5 ;
      
    open p_cur_venue_sport for
     select  vc.venue_masterid as venue_id,vc.venue_name as venue_name,vc.venue_parentid as parent_id,vc.sport_master_id,sp.sport_name,reviews,rate
      from    zeven.zeven_venue_master vc
      inner join zeven.zeven_venue_master vp
              on  vp.venue_masterid = vc.venue_parentid
      inner join  zeven.zeven_sport_master sp
              on  sp.sport_master_id = vc.sport_master_id
      left join ( select  count(1) as reviews,venue_masterid 
                  from    zeven.zeven_rating cr
                  group by venue_masterid
                 )cr
              on  cr.venue_masterid = vc.venue_masterid
      left join ( select  round(avg(ratings),2) as rate,venue_masterid 
                  from    zeven.zeven_rating
                  group by venue_masterid
                 )r
              on  r.venue_masterid = vc.venue_masterid 
      where   vp.venue_masterid  = p_venue_masterid;  
    
    open p_cur_venue_rating for
      select round(avg(ratings),0) as rate
      from    zeven.zeven_rating r
      where   venue_parentid = p_venue_masterid
      group by venue_parentid;
    
    open  p_cur_venue_comment for
      select  count(1) as reviews 
      from    zeven.zeven_rating cr
      where   venue_parentid = p_venue_masterid
      group by venue_parentid;
    
    open p_cur_venue_event for 
      select  e.zeven_eventid,e.event_name,e.event_date,e.event_desc,vm.sport_master_id
      from    zeven.zeven_event e
      inner join  zeven.zeven_venue_master vm 
              on e.venue_masterid = vm.venue_masterid
      where   vm.venue_parentid = p_venue_masterid 
              and
              is_published = 1
              and
              is_deleted = 0
              and
              event_date >= v_ist_time
      order by  event_date;
      
    open p_cur_venue_checkins for
      select  count(1) as checkins
      from    zeven.zeven_venue_checkins 
      where   venue_parentid = p_venue_masterid ;
      
      open p_want_to_play_cnt for
    select  count(1)
    from    zeven.zeven_want_to_play wp
    inner join zeven.zeven_venue_master vm
            on  vm.venue_masterid = wp.venue_masterid
    where   venue_parentid = p_venue_masterid;

end;
$$;


--
