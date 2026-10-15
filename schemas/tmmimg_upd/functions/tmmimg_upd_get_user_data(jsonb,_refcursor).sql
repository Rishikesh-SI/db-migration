-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: tmmimg_upd_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 if v_opt_type = 1 then
	open p_user_cursor for
	
   
select 
social_user_name,
msg_text,
pubisher,
msg_id,
created_date,
url,
media_type,
email_id
 from (
select 
a.social_user_id  as social_user_name,
a.msg_text,
a.pubisher,
a.msg_id,
a.created_date,
a.url,
a.media_type,
b.email_id
from tmmimg_upd.tmmimg_upd_tigertrack_data a
left join tmmimg_upd.tmmimg_upd_web_user b on  a.social_user_id = b.social_user_name
where (a.created_date )::date between v_start_date_time and v_end_date_time) tab;

elseif v_opt_type = 2 then

	/*open p_user_cursor for
	select b.email_id,b.dob,b.user_guid,a.user_id,b.user_full_name
	from tmmimg_upd.tmmimg_upd_user_transaction a
	left join tmmimg_upd.tmmimg_upd_web_user b on a.user_guid=b.user_guid
	where lower(a.transaction_status) =lower('Success') and a.total_payment = 99;*/
	
	open p_user_cursor for
	select b.user_full_name,b.email_id,b.dob,b.gender,b.mobile_no,s.name as user_state,
		d.name as user_city,b.address,b.pincode,c.race_category_name,a.transaction_status,a.transaction_date,
		a.total_payment,a.user_guid
	from tmmimg_upd.tmmimg_upd_user_transaction a
	left join tmmimg_upd.tmmimg_upd_web_user b on a.user_guid=b.user_guid
	left join tmmimg_upd.tmmimg_upd_race_category c on b.race_category_id = c.race_category_id
	left join waf_master.waf_states s on b.state_id= s.state_id
	left join waf_master.waf_cities d on b.city_id= d.city_id;
	--where (a.transaction_date )::date between v_start_date_time and v_end_date_time 
	--and a.transaction_status is not null
	
elseif v_opt_type = 3 then	

		open p_user_cursor for
	select b.user_full_name,b.email_id,b.dob,b.gender,b.mobile_no,s.name as user_state,
		d.name as user_city,b.address,b.pincode,c.race_category_name
	from tmmimg_upd.tmmimg_upd_web_user b
	left join tmmimg_upd.tmmimg_upd_race_category c on b.race_category_id = c.race_category_id
	left join waf_master.waf_states s on b.state_id= s.state_id
	left join waf_master.waf_cities d on b.city_id= d.city_id
	where b.client_id= 7;
	
elseif v_opt_type = 4 then	

	open p_user_cursor for
	select b.user_full_name,b.email_id,b.dob,b.gender,b.mobile_no,s.name as user_state,
		d.name as user_city,b.address,b.pincode,c.race_category_name,
		r.hash_email_address,r.actual_distance_in_meters,r.actual_elapsed_time_in_seconds, 
		r.average_pace_minutes_per_mile,r.average_pace_minutes_per_km,r.race_type,
		r.qualifying_trip_activity_id,r.date_completed,r.approximate_distance_completed,r.avg_pace_min_per_miles,
		r.cadence_steps_per_min,r.time_spent_paused_in_seconds
	from tmmimg_upd.tmmimg_upd_user_transaction a
	join tmmimg_upd.tmmimg_upd_user_race_challange r on a.user_guid=r.user_guid
	left join tmmimg_upd.tmmimg_upd_web_user b on a.user_guid=b.user_guid
	left join tmmimg_upd.tmmimg_upd_race_category c on b.race_category_id = c.race_category_id
	left join waf_master.waf_states s on b.state_id= s.state_id
	left join waf_master.waf_cities d on b.city_id= d.city_id
	where lower(a.transaction_status) =lower('Success') and r.actual_elapsed_time_in_seconds is not null;

end if;
 
end;

$$;


--
