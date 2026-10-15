-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: tmm_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
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
    
 if v_opt_type = 3 then
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
from tmm.tmm_tigertrack_data a
left join tmm.tmm_web_user b on  a.social_user_id = b.social_user_name
where (a.created_date )::date between v_start_date_time and v_end_date_time) tab;

elseif v_opt_type = 2 then

	open p_user_cursor for
	select b.user_full_name,b.email_id,b.dob,b.gender,b.mobile_no,s.name as user_state,
		d.name as user_city,b.address,b.pincode,c.race_category_name,a.transaction_status,a.transaction_date,
		a.total_payment
	from tmm.tmm_user_transaction a
	left join tmm.tmm_web_user b on a.user_guid=b.user_guid
	left join tmm.tmm_race_category c on b.race_category_id = c.race_category_id
	left join waf_master.waf_states s on b.state_id= s.state_id
	left join waf_master.waf_cities d on b.city_id= d.city_id
	--where (a.transaction_date )::date between v_start_date_time and v_end_date_time 
	--and a.transaction_status is not null
	;
elsif v_opt_type = 1 then
     open p_user_cursor for
	 select u.user_guid,u.user_id,u.email_id,u.dob
		 from tmm.tmm_web_user u  ;

elsif v_opt_type = 4  then
	open p_user_cursor for
	select * from tmm.tmm_group
	where (created_date+ '5.5 hours' ::interval)::date >= v_start_date_time
	and (created_date+ '5.5 hours' ::interval)::date <= v_end_date_time;

end if;
 
end;
$$;


--
