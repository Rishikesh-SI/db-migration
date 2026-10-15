-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_search_venue(character varying, character varying, numeric, numeric, numeric, numeric, character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_search_venue(character varying, character varying, numeric, numeric, numeric, numeric, character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_search_venue(p_value character varying, p_location character varying, p_is_event numeric, p_order numeric, p_page_number numeric, p_items_number numeric, p_filter_values character varying, p_cur_venue_count refcursor, p_cur_venue_list refcursor, p_cur_venue_event refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_from_row_number numeric;
    v_to_row_number numeric;
    v_sportexists numeric;
    v_valuefilterquery1 text := ' ';
    v_valuefilterquery2 text := ' ';
    v_locationfilterquery1 text := ' ';
    v_locationfilterquery2 text := ' ';
    v_venueidjson json;
    v_ist_time timestamp(0) := current_timestamp + interval '690'  minute;
    
begin
    
    v_from_row_number := (p_items_number * p_page_number - (p_items_number - 1));
  	v_to_row_number := (p_items_number * p_page_number);
    
    if p_value is not null then
    	
        execute 'select count(1)
        			from zeven.zeven_sport_master
                    where upper(sport_name) like ''%''||'||'$1'||'||''%'' '
		into v_sportexists
        using upper(p_value);
        
        if v_sportexists = 0 then
        	v_valuefilterquery1 := ' left join zeven.zeven_venue_master zvm2
            							on zvm.venue_masterid = zvm2.venue_masterid
                                        where (upper(zvm.venue_name) like upper(''%'||p_value||'%'') 
            								or upper(zvm.address) like upper(''%'||p_value||'%''))
										and zvm.is_active = 1 ';
			
			v_valuefilterquery2 := ' left join zeven.zeven_venue_master zvm2
            							on zvm1.venue_masterid = zvm2.venue_masterid
                                        where (upper(zvm1.venue_name) like upper(''%'||p_value||'%'') 
                                        	or upper(zvm1.address) like upper(''%'||p_value||'%''))
										and zvm1.is_active = 1 ';
        else
        	v_valuefilterquery1 := ' join zeven.zeven_sport_master zsm
            							on zvm.sport_master_id = zsm.sport_master_id
                                        where ((upper(zsm.sport_name) like upper(''%'||p_value||'%'')) 
                                        		or upper(zvm.venue_name) like upper(''%'||p_value||'%''))
										and zvm.is_active = 1 ';
			
			v_valuefilterquery2 := ' join zeven.zeven_sport_master zsm
            							on zvm1.sport_master_id = zsm.sport_master_id
                                        where ((upper(zsm.sport_name) like upper(''%'||p_value||'%'')) 
                                        		or upper(zvm1.venue_name) like upper(''%'||p_value||'%''))
										and zvm1.is_active = 1 ';
        end if;
        
    end if;
    
    if p_location is not null then
    	v_locationfilterquery1 := ' and upper(zvm.address) like upper(''%'||p_location||'%'') ';
        v_locationfilterquery2 := ' and upper(zvm1.address) like upper(''%'||p_location||'%'') ';
	end if;
    
    execute 'with recursive a(venue_id)
    			as
                (
                	select zvm.venue_masterid
                    from zeven.zeven_venue_master zvm '
                    ||v_valuefilterquery1
                    ||v_locationfilterquery1
                    ||' union
                    select zvm1.venue_masterid
                    from zeven.zeven_venue_master zvm1
                    join a
                    on a.venue_id = zvm1.venue_parentid '
                    ||v_valuefilterquery2
                    ||v_locationfilterquery2
				||' )
                select (''{"venue":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
                from (select venue_id
                		from a) row'
	into v_venueidjson;
    
    open p_cur_venue_count for
    select coalesce(json_array_length((a->>'venue')::json),0) counts
    from (select v_venueidjson as a) b;
    
    open p_cur_venue_list for
    select *
    from (select vm.venue_masterid, vm.venue_name, vm.shortname, vm.display_name, vm.known_as, vm.email_id, vm.pincode, vm.latitude, vm.longitude, 
          			vm.description, vm.mobile_no, vm.mobile_no1, vm.telephone_no, vm.address, 
          			row_number() over(order by vm.venue_masterid desc) order_no, vm.created_date, vm.venue_type, vm.sport_master_id, 
          			coalesce(rating.counts, 0) total_ratings, coalesce(review.counts, 0) total_reviews, coalesce(facility_view.counts, 0) total_views, 
          			coalesce(facility_checkin.counts, 0) total_checkins, coalesce(want_to_play.counts, 0) as want_to_play, vm.updated_date modified_date
          from zeven.zeven_venue_master vm
          left join (select count(1) as counts, venue_masterid
                     from zeven.zeven_rating zcr
                     group by venue_masterid) review
          on review.venue_masterid = vm.venue_masterid
          left join (select round(avg(ratings),0) as counts, venue_masterid
                     from zeven.zeven_rating zr
                     group by venue_masterid) rating
          on rating.venue_masterid = vm.venue_masterid
          left join (select count(1) as counts, articleid
                     from zeven.zeven_track_user_activity ztua
                     where asset_type_id = 0
                     and activityid = 13
                     group by articleid)facility_view
          on facility_view.articleid = vm.venue_masterid
          left join (select count(1) as counts, venue_masterid
                     from zeven.zeven_venue_checkins
                     group by venue_masterid)facility_checkin
          on facility_checkin.venue_masterid = vm.venue_masterid
          left join (select count(1) counts, venue_masterid
                     from zeven.zeven_want_to_play
                     where user_id in(select user_id from zeven.zeven_web_user)
                     group by venue_masterid)want_to_play
          on want_to_play.venue_masterid = vm.venue_masterid
          where vm.venue_masterid in(select (json_array_elements(a->'venue')->>'venue_id')::numeric
                                     from (select v_venueidjson as a) b)) a
	where order_no between v_from_row_number and v_to_row_number;
    
    open p_cur_venue_event for
    select zeven_eventid, event_name, event_date, registration_fee, winning_prize, event_type, venue_masterid
    from zeven.zeven_event
    where venue_masterid in(select (json_array_elements(a->'venue')->>'venue_id')::numeric
                            from (select v_venueidjson as a) b)
    and is_published = 1
    and is_deleted = 0
    and event_date >= v_ist_time;
    
end;

$_$;


--
