-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_search_venue_niu(character varying, character varying, numeric, numeric, numeric, numeric, character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_search_venue_niu(character varying, character varying, numeric, numeric, numeric, numeric, character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_search_venue_niu(p_value character varying, p_location character varying, p_is_event numeric, p_order numeric, p_page_number numeric, p_items_number numeric, p_filter_values character varying, p_cur_venue_count refcursor, p_cur_venue_list refcursor, p_cur_venue_event refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_from_row_number numeric;
    v_to_row_number numeric;
    v_sql_event varchar(100) := '';
    v_identifier_flag numeric;
    v_sql text;
    v_sport numeric;
    v_arr_venue_id numeric[];
    v_arr_parent_id numeric[];
    v_identifier_flag_old numeric;
    v_identifier_filter numeric;
    v_arr_filter_venue_id numeric[];
    v_arr_filter_parent_id numeric[];
    v_ist_time timestamp(0) := (current_timestamp) + interval '690'  minute;
    
begin
	
    create temp table if not exists t_table
    (
        c_venue_childid numeric,
        c_venue_parentid numeric
    );
    
    v_from_row_number := (p_items_number * p_page_number - (p_items_number - 1));
  	v_to_row_number := (p_items_number * p_page_number);
    
    if coalesce(p_is_event, 0) = 1 then
    	v_sql_event := ' and length(coalesce(zvm.event,'''')) > 0 ';
  	end if;
    
    v_identifier_flag := nextval('zeven.seq_gtt_wafid');
    
   	if (p_location is not null and p_value is null) then
		
        v_sql := 'with recursive a(venue_childid, venue_parentid) as
        	      (select zvm.venue_masterid, coalesce(zvm.venue_parentid, zvm.venue_masterid)
                   from zeven.zeven_venue_master zvm
                   where zvm.is_active = 1
                   and upper(zvm.address) like upper(''%'||p_location||'%'')
                   '||v_sql_event||'
                   union
                   select zvm1.venue_masterid, coalesce(zvm1.venue_parentid, zvm1.venue_masterid)
                   from zeven.zeven_venue_master zvm1
                   join a
                   on a.venue_childid = zvm1.venue_parentid
                   where zvm1.is_active = 1
                   and upper(zvm1.address) like upper(''%'||p_location||'%'')
                   '||v_sql_event||')
                  insert into t_table
                  select venue_childid, venue_parentid
                  from a';
        
  	end if;
    
    if (p_location is null and p_value is not null) then
        
        execute 'select count(1)
        		 from zeven.zeven_sport_master zsm
                 where upper(sport_name) like coalesce(upper(''%'||p_value||'%''),upper(sport_name))'
        into v_sport;
        
        if v_sport > 0 then
            
			v_sql := 'with recursive a(venue_childid, venue_parentid) as
            		 (select coalesce(zvm.venue_masterid, 0), zvm.venue_parentid
                      from zeven.zeven_venue_master zvm
                      inner join zeven.zeven_sport_master zsm
                      on zvm.sport_master_id = zsm.sport_master_id
                      where zvm.is_active = 1
                      and ((upper(zsm.sport_name) like coalesce(upper(''%'||p_value||'%''),upper(zsm.sport_name)))
                      	   or upper(zvm.venue_name) like upper(''%'||p_value||'%''))
                      '||v_sql_event||'
                      union
                      select coalesce(zvm1.venue_masterid, 0), zvm1.venue_parentid
                      from zeven.zeven_venue_master zvm1
                      inner join zeven.zeven_sport_master zsm1
                      on zvm1.sport_master_id = zsm1.sport_master_id
                      join a
                      on a.venue_childid = zvm1.venue_parentid
                      where zvm1.is_active = 1
                      and ((upper(zsm1.sport_name) like coalesce(upper(''%'||p_value||'%''),upper(zsm1.sport_name)))
                      	   or upper(zvm1.venue_name) like upper(''%'||p_value||'%''))
                      '||v_sql_event||'
                     )
                     insert into t_table
                     select venue_childid, venue_parentid
                     from a';
            
        end if;
        
        if v_sport = 0 then
        	
            v_sql := 'with recursive a(venue_childid, venue_parentid) as
            		  (select coalesce(zvm.venue_masterid, 0), coalesce(zvm.venue_parentid, zvm.venue_masterid)
                       from zeven.zeven_venue_master zvm
                       where zvm.is_active = 1
                       and (upper(zvm.venue_name) like upper(''%'||p_value||'%'')
                       		or upper(zvm.address) like upper(''%'||p_value||'%''))
                       '||v_sql_event||'
                       union
                       select coalesce(zvm1.venue_masterid, 0), coalesce(zvm1.venue_parentid, zvm1.venue_masterid)
                       from zeven.zeven_venue_master zvm1
                       join a
                       on a.venue_childid = zvm1.venue_parentid
                       where zvm1.is_active = 1
                       and (upper(zvm1.venue_name) like upper(''%'||p_value||'%'')
                       		or upper(zvm1.address) like upper(''%'||p_value||'%''))
                       '||v_sql_event||'
                      )
                      insert into t_table
                      select venue_childid, venue_parentid
                      from a';
            
        end if;
        
	end if;
    
    if (p_location is not null and p_value is not null) then
    	
        execute 'select count(1)
        		 from zeven.zeven_sport_master zsm
                 where upper(sport_name) like coalesce(upper(''%'||p_value||'%''),upper(sport_name))'
		into v_sport;
        
        if v_sport > 0 then
        	
            v_sql := 'with recursive a(venue_childid, venue_parentid, address) as
            		  (select coalesce(zvm.venue_masterid, 0), zvm.venue_parentid, zvm.address
                       from zeven.zeven_venue_master zvm
                       inner join zeven.zeven_sport_master zsm
                       on zvm.sport_master_id = zsm.sport_master_id
                       where zvm.is_active = 1
                       and (upper(zsm.sport_name) like coalesce(upper(''%'||p_value||'%''),upper(zsm.sport_name))
                      	    or upper(zvm.venue_name) like upper(''%'||p_value||'%''))
                       '||v_sql_event||'
                       union
                       select coalesce(zvm1.venue_masterid, 0), zvm1.venue_parentid, zvm1.address
                       from zeven.zeven_venue_master zvm1
                       inner join zeven.zeven_sport_master zsm1
                       on zvm1.sport_master_id = zsm1.sport_master_id
                       join a
                       on a.venue_childid = zvm1.venue_parentid
                       where zvm1.is_active = 1
                       and (upper(zsm1.sport_name) like coalesce(upper(''%'||p_value||'%''),upper(zsm1.sport_name))
                      	    or upper(zvm1.venue_name) like upper(''%'||p_value||'%''))
                       '||v_sql_event||')
                       insert into t_table
                       select venue_childid, venue_parentid
                       from a
                       where upper(address) like upper(''%'||p_location||'%'')';
            
		end if;
        
        if v_sport = 0 then
        	
            v_sql := 'with recursive a(venue_childid, venue_parentid, address) as
            		  (select coalesce(zvm.venue_masterid, 0), coalesce(zvm.venue_parentid, zvm.venue_masterid), zvm.address
                       from zeven.zeven_venue_master zvm
                       where  zvm.is_active = 1
                       and (upper(zvm.venue_name) like upper(''%'||p_value||'%'')
                       		or upper(zvm.address) like upper(''%'||p_value||'%''))
                       '||v_sql_event||'
                       union
                       select coalesce(zvm1.venue_masterid, 0), coalesce(zvm1.venue_parentid, zvm1.venue_masterid), zvm1.address
                       from zeven.zeven_venue_master zvm1
                       join a
                       on a.venue_childid = zvm1.venue_parentid
                       where  zvm1.is_active = 1
                       and (upper(zvm1.venue_name) like upper(''%'||p_value||'%'')
                       		or upper(zvm1.address) like upper(''%'||p_value||'%''))
                       '||v_sql_event||'
                      )
                      insert into t_table
                      select venue_childid, venue_parentid
                      from a
                      where upper(address) like upper(''%'||p_location||'%'')';
            
		end if;
        
	end if;
    
    execute v_sql;
    -- into v_arr_venue_id, v_arr_parent_id;
    
    /*for i in 1..array_length(v_arr_venue_id, 1)
    loop
    	insert into zeven.gtt_waf (col1_seqid, col2_numeric, col3_numeric)
        select  v_identifier_flag, v_arr_venue_id[i], v_arr_parent_id[i];
    end loop;*/
    
    insert into zeven.gtt_waf (col1_seqid, col2_number, col3_number)
    select v_identifier_flag, c_venue_childid, c_venue_parentid
    from t_table;
    
    perform 1;
    
    if p_filter_values is not null then
    	
        v_identifier_flag_old := v_identifier_flag;
    	v_identifier_flag := nextval('zeven.seq_gtt_wafid');
        v_identifier_filter := nextval('zeven.seq_gtt_wafid');
        
    	insert into zeven.gtt_waf(col1_seqid, col2_number) 
    	select distinct v_identifier_filter, parent_filter_id
    	from zeven.zeven_filter_master
        where zeven_filter_masterid =any(('{'||p_filter_values||'}')::numeric[]);
        
    	execute 'insert into t_table
        		 select venue_id, parent_id
        		 from (select venue_masterid as venue_id, coalesce(venue_parentid, 0) as parent_id, latitude, longitude
                 	   from zeven.zeven_venue_master vp
                       join zeven.gtt_waf gw
                       on gw.col2_number = vp.venue_masterid
                       and col1_seqid = '||v_identifier_flag_old||'
                       where exists (select ''x'' 
                       				 from (select count(1), fm.parent_filter_id, vfv.venue_masterid
                                     	   from zeven.zeven_venue_filter_values vfv
                                           join  zeven.zeven_filter_master fm
                                           on  vfv.venue_filter_value::numeric = fm.zeven_filter_masterid
                                           where vfv.venue_filter_value::numeric in ('||p_filter_values||')
                                           group by fm.parent_filter_id, vfv.venue_masterid
                                          )vm
                                          where vm.venue_masterid::numeric = vp.venue_masterid
                                          group by vm.venue_masterid 
                                          having count(1) = (select count(1)
                                          					 from zeven.gtt_waf
                                                             where col1_seqid = '||v_identifier_filter||'
                                                            )
									)
					   union all
                       select vc.venue_masterid as venue_id, vc.venue_parentid as parent_id, latitude, longitude
                       from zeven.zeven_venue_master vc
                       inner join zeven.gtt_waf gw
                       on gw.col2_number = vc.venue_parentid
                       and col1_seqid = '||v_identifier_flag_old||'
                       where exists (select ''x''
                       				 from (select count(1), fm.parent_filter_id, vfv.venue_masterid
                                     	   from zeven.zeven_venue_filter_values vfv
                                           join zeven.zeven_filter_master fm
                                           on vfv.venue_filter_value::numeric = fm.zeven_filter_masterid
                                           where vfv.venue_filter_value::numeric in ('||p_filter_values||')
                                           group by fm.parent_filter_id, vfv.venue_masterid
                                          )vm
                                          where vm.venue_masterid::numeric = vc.venue_masterid
                                          group by vm.venue_masterid
                                          having count(1) = (select count(1)
                                          					 from zeven.gtt_waf
                                                             where col1_seqid = '||v_identifier_filter||'
                                                            )
									)
					  ) cte';
    	-- into v_arr_filter_venue_id, v_arr_filter_parent_id;
        
    	/*for i in 1..array_length(v_arr_filter_venue_id)
        loop
        	
            if not exists(select 1
                          from zeven.gtt_waf
                          where col2_numeric = v_arr_filter_venue_id[i]
                          and col1_seqid = v_identifier_flag) then
				
				insert into zeven.gtt_waf(col1_seqid, col2_numeric, col3_numeric)
            	select v_identifier_flag, v_arr_filter_venue_id[i], v_arr_filter_parent_id[i];
                
            end if;
            
        end loop;*/
        
        insert into zeven.gtt_waf
        select t.c_venue_childid, t.c_venue_parentid
        from t_table t
        where not exists(select 1
                         from zeven.gtt_waf
                         where col2_number = t.c_venue_childid
                         and col1_seqid = v_identifier_flag);
        
        perform 1;
		
  	end if;
    
    open p_cur_venue_count for
   	select count(1) as counts
    from (select col2_number
          from zeven.gtt_waf gt
          where col1_seqid = v_identifier_flag
          and col3_number is not null)a;
	
    open  p_cur_venue_list for
    select *
    from (select vm.venue_masterid, vm.venue_name, vm2.shortname, vm2.display_name, vm2.known_as, vm2.email_id, vm2.pincode, vm2.latitude,
          	     vm2.longitude, vm2.description, vm2.mobile_no, vm2.mobile_no1, vm2.telephone_no, vm2.address,
          	     row_number() over(order by case when p_order = 1 then coalesce(rating.counts, 0)
                                   				 when p_order = 2 then coalesce(facility_checkin.counts, 0)
                                   				 when p_order = 3 then coalesce(review.counts, 0)
                                   				 when p_order = 4 then coalesce(facility_view.counts, 0)
                                   				 else vm.venue_masterid
                                   			end desc) order_no, vm.created_date, vm.venue_type, vm.sport_master_id,
          	     coalesce(rating.counts, 0) total_ratings, coalesce(review.counts, 0) total_reviews, coalesce(facility_view.counts, 0) total_views,
          		 coalesce(facility_checkin.counts, 0) total_checkins, coalesce(want_to_play.counts, 0) as want_to_play, vm.updated_date modified_date
          from zeven.zeven_venue_master vm
          left join zeven.zeven_venue_master vm2
          on vm.venue_parentid = vm2.venue_masterid
          join zeven.gtt_waf gt
          on gt.col2_number = vm.venue_masterid
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
          where col1_seqid = v_identifier_flag
          order by case when p_order = 1 then coalesce(rating.counts, 0)
          				when p_order = 2 then coalesce(facility_checkin.counts, 0)
          				when p_order = 3 then coalesce(review.counts, 0)
          				when p_order = 4 then coalesce(facility_view.counts, 0)
          				else vm.venue_masterid
          			end desc) a
	where order_no between v_from_row_number and v_to_row_number;
    
    open p_cur_venue_event for
    select e.zeven_eventid, e.event_name, e.event_date, e.registration_fee, e.winning_prize, e.event_type, e.venue_masterid
    from zeven.zeven_event e
    join zeven.gtt_waf gt
    on gt.col2_number = e.venue_masterid
    where col1_seqid = v_identifier_flag
    and e.is_published = 1
    and e.is_deleted = 0
    and event_date >= v_ist_time;
    
    delete from zeven.gtt_waf where col1_seqid = v_identifier_flag;
    delete from zeven.gtt_waf where col1_seqid = v_identifier_flag_old;
    
    perform 1;
    
    drop table t_table;
    
end;

$$;


--
