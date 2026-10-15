-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_facility_details(numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_facility_details(numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_facility_details(p_venue_masterid numeric, p_cur_facility refcursor, p_cur_facility_amenities refcursor, p_cur_facility_add_info refcursor, p_cur_facility_rating refcursor, p_cur_facility_comment refcursor, p_cur_facility_review_detail refcursor, p_cur_facility_event refcursor, p_cur_facility_checkins refcursor, p_cur_facility_photos refcursor, p_cur_facility_img_cnt refcursor, p_want_to_play_cnt refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin
  
  open p_cur_facility for
      select  vmp.venue_masterid parent_venue_id, vmp.venue_name parent_venue_name,vmc.venue_masterid, vmc.venue_name, vmc.shortname, vmc.display_name, vmc.known_as, vmc.venue_type, vmc.venue_parentid, vmp.venue_name as parent_venue_name,vmp.email_id, vmp.city_id,city_name, 
              vmp.state_id,state_name, vmp.country_id, country_name,
              vmp.pincode, vmp.google_map, vmp.description, vmc.sport_master_id,sm.sport_name, vmc.capacity, vmc.dress_code, vmc.price, vmp.mobile_no, vmp.mobile_no1, vmp.telephone_no, 
              vmc.timings, vmc.is_active, 
              vmc.created_date, vmc.updated_date, vmp.is_featured,vmp.address,vmp.longitude,vmp.latitude,vmc.short_address
      from    zeven.zeven_venue_master vmc
      inner join  zeven.zeven_venue_master vmp
              on  vmp.venue_masterid = vmc.venue_parentid
      left join zeven.zeven_city sc
            on  sc.cityid = vmp.city_id
      left join zeven.zeven_state ss
            on  ss.stateid = vmp.state_id
      left join zeven.zeven_country sct
            on  sct.countryid = vmp.country_id
      left join zeven.zeven_sport_master sm
            on  vmc.sport_master_id = sm.sport_master_id
      where   vmc.venue_masterid  = p_venue_masterid;
    
    
    open p_cur_facility_amenities for
      select  distinct vfv.venue_masterid,vfv.zeven_filter_masterid,ft.filter_name ,vfv.venue_filter_value
      from    zeven.zeven_venue_filter_values vfv
      inner join  zeven.zeven_venue_master vmc
              on  vmc.venue_parentid = vfv.venue_masterid::numeric
      inner join  zeven.zeven_filter_master ft
              on  ft.zeven_filter_masterid = vfv.venue_filter_value::numeric
      where   vmc.venue_masterid  = p_venue_masterid and vfv.zeven_filter_masterid::numeric = 5 ;
      
    open p_cur_facility_add_info for
      select parentid,parent_name,string_agg(filter_name,', ') as filter_value-- listagg(filter_name,', ') within group(order by parentid) as filter_value
      from(
           select   distinct vfv.venue_masterid,coalesce(ftp.zeven_filter_masterid,vfv.zeven_filter_masterid::numeric) as parentid,coalesce(ftp.filter_name,ft1.filter_name) as parent_name ,
                    vfv.zeven_filter_masterid,
                    case when ft.filter_name is null then vfv.venue_filter_value else ft.filter_name end filter_name ,vfv.venue_filter_value
            from    zeven.zeven_venue_filter_values vfv
            left  join  zeven.zeven_filter_master ft1
                    on  ft1.zeven_filter_masterid = vfv.zeven_filter_masterid::numeric
            left join  zeven.zeven_filter_master ft
                    on  ft.zeven_filter_masterid::varchar = vfv.venue_filter_value
            left join    zeven.zeven_filter_master ftp
                    on   ftp.zeven_filter_masterid = ft.parent_filter_id
            where   vfv.venue_masterid::numeric = p_venue_masterid and ft1.is_venue_lvl_filter = 0
          )a
      group by    parentid,parent_name   ;
      
    open p_cur_facility_rating for
      select round(avg(ratings),0) as rate
      from    zeven.zeven_rating r
      where   venue_masterid = p_venue_masterid;
    
    open  p_cur_facility_comment for
      select  count(1) as reviews 
      from    zeven.zeven_rating cr
      where   venue_masterid = p_venue_masterid ;
    
   -- open p_cur_facility_review_detail for 
    perform zeven.zeven_get_review_details (null,p_venue_masterid,1,10,1,p_cur_facility_review_detail);
      
    perform zeven.zeven_get_event_details(p_venue_masterid,1,5,p_cur_facility_event);
      
    open p_cur_facility_checkins for
      select  count(1) as checkins
      from    zeven.zeven_venue_checkins 
      where   venue_masterid = p_venue_masterid ;
      
    perform zeven.zeven_get_image_details (null,p_venue_masterid,1,null,null,1,1,25,p_cur_facility_photos,p_cur_facility_img_cnt);
	
	open p_want_to_play_cnt for
    select  count(1)
    from    zeven.zeven_want_to_play zwtp
    inner join zeven.zeven_user zu
    on zwtp.user_id = zu.user_id
    where   venue_masterid = p_venue_masterid;
end;

$$;


--
