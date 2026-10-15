-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_similar_venues_niu(numeric, character varying, character varying, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_similar_venues_niu(numeric, character varying, character varying, numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_similar_venues_niu(p_sport_id numeric, p_latitude character varying, p_longitude character varying, p_distance numeric, p_items_number numeric, p_similar_venue_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin
	
	open p_similar_venue_cursor for
    execute 'select * from(select cc.*, row_number() over (order by case when distance <= '||p_distance||' then 1 else distance end) rn
    		 from (select bb.*, (round(p.distance_unit * rad2deg * (acos(cos(deg2rad * (p.latpoint)) * cos(deg2rad * (bb.latitude))
             	   		  * cos(deg2rad * (p.longpoint - bb.longitude)) + sin(deg2rad * (p.latpoint)) * sin(deg2rad * (bb.latitude)))))::numeric,2) distance
				   from (select vm2.venue_masterid, vm2.venue_name, vm.shortname, vm.display_name, vm.known_as, vm.email_id, vm.pincode, vm.latitude,
                                vm.longitude, vm.description, vm.mobile_no, vm.mobile_no1, vm.telephone_no, vm.address,
                                row_number() over (order by vm.created_date desc) order_no, vm.created_date, vm2.venue_type,
                                coalesce(rating.counts,0) total_ratings, coalesce(review.counts,0) total_reviews, null as venue_img,
                                null as total_checkin, null as want_to_play, vm.short_address
						 from zeven.zeven_venue_master vm
                         join zeven.zeven_venue_master vm2
                         on vm.venue_masterid = vm2.venue_parentid
                         join zeven.zeven_sport_master zsm
                         on vm2.sport_master_id = zsm.sport_master_id
                         and vm2.sport_master_id = '||p_sport_id||'
                         left join (select count(1) as counts, venue_masterid
                         			from zeven.zeven_rating zcr
                                    group by venue_masterid)review
						on review.venue_masterid = vm2.venue_masterid
                        left join (select round(avg(ratings),0) as counts, venue_masterid
                        		   from zeven.zeven_rating zr
                                   group by venue_masterid)rating
                        on rating.venue_masterid = vm2.venue_masterid
                        where vm2.is_active = 1
                       ) bb
                   join (select '||p_latitude||' as latpoint, '||p_longitude||' as longpoint, 50.0 as radius, 111.045 as distance_unit,
                   				57.2957795 as rad2deg, 0.0174532925 as deg2rad)p 
				   on 1 = 1
                   order by distance) cc) a
			 where rn <= '||p_items_number||'';
	
end;
$$;


--
