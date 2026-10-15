-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_user_profile(text)
-- Type: FUNCTION

-- Name: labirao_get_user_profile(text); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_user_profile(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
 v_curr_date date:=current_date;
 v_total_distance_covered numeric(10,4);
 v_reached_pledged_distance numeric;
 v_first_activity  numeric;
	v_reached_30km  numeric;
	v_3_days  numeric;
	v_5_days  numeric;
	v_7_days  numeric;
	v_2_weeks numeric;
	v_3_weeks numeric;
	v_4_weeks numeric;
	v_bronze_medal numeric;
	v_silver_medal numeric;
	v_gold_medal numeric;
	v_platinum_medal numeric;
	v_badge_out numeric;
begin

select * from labirao.labirao_upd_badge_detail(p_user_guid)
into v_badge_out;

begin
select distance,first_activity,reached_30km,weeks_2,weeks_3,weeks_4,
days_3,days_5,days_7,reached_pledged_distance,bronze_medal,silver_medal,gold_medal,platinum_medal
from labirao.labirao_user_activity_report
where upper(email_id)=upper(p_user_guid)
into v_total_distance_covered,
v_first_activity,
v_reached_30km,v_2_weeks,v_3_weeks,v_4_weeks,
v_3_days,v_5_days,v_7_days,v_reached_pledged_distance,
v_bronze_medal,v_silver_medal,v_gold_medal,v_platinum_medal;

exception when no_data_found then
v_total_distance_covered:=0;
end;

v_bronze_medal:= case when coalesce(v_silver_medal,0)=1 then null else v_bronze_medal end;
v_silver_medal:= case when coalesce(v_gold_medal,0)=1 then null else v_silver_medal end;
v_gold_medal:= case when coalesce(v_platinum_medal,0)=1 then null else v_gold_medal end;
 
 
 
update labirao.labirao_user_master
set  group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE')
and payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid));

update labirao.labirao_user_activity_report
set group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE')
and upper(email_id) =upper(p_user_guid);

  
update labirao.labirao_user_master
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme')
and   payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid));

update labirao.labirao_user_activity_report
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme')
and  upper(email_id) =upper(p_user_guid);
 

update labirao.labirao_user_master
set old_group_id=group_id,
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid))
and group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');

update labirao.labirao_user_activity_report
set  
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where  upper(email_id) =upper(p_user_guid)
and group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');

select row_to_json(row) 
from (
	select user_id,
	email_id,
	 
	user_guid, 
	payment_status, 
	payment_amount,
	category, 
	replace(pledged_distance,'.0000','') as pledged_distance, 
	group_id, 
	initcap(user_name) as user_name, 
	city, 
	state_name, 
	pincode, 
	bib_no,
	height,
	weight,
	mobile_no, 
	external_user_id,
	dob,
	charity_amount ,
	nationality,
	gender,
    pledged_state,
    pledged_city,
    case when group_name ='PhonePe' then '' else group_name end as group_name,
	case when  activity_date=v_curr_date then 1 else 0 end as  is_one_time,
	v_total_distance_covered as total_distance_covered,
	v_first_activity as first_activity,
	case when v_total_distance_covered>=30 then 1 else v_reached_30km end as reached_30km,
	v_reached_pledged_distance as reached_pledged_distance,
	v_2_weeks as weeks_2,
	v_3_weeks as weeks_3,
	v_4_weeks as weeks_4,
	v_3_days as days_3,
	v_5_days as days_5,
	v_7_days as days_7,
	v_bronze_medal as bronze_medal,
	v_silver_medal as silver_medal,
	v_gold_medal as gold_medal,
	v_platinum_medal as platinum_medal
	from labirao.labirao_user_master
	where (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid)
	-- email_id = case when p_user_guid ='praveen22100@gmail.com' then 'sunil.chainani@gmail.com'
	---else p_user_guid end
		  )
	and payment_status=1
	 ) row
	into p_user_json;
	
	
	end;
	$$;


--
