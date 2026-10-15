-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_user_profile_backup(text)
-- Type: FUNCTION

-- Name: tmm_get_user_profile_backup(text); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_user_profile_backup(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
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
	v_user_json jsonb;
	v_user_referral_code varchar(500);
	v_virtual_profile jsonb;
	v_og_profile jsonb;
begin

select used_referral_code
from tmm.tmm_user_master
where email_id =p_user_guid
into v_user_referral_code;
if v_user_referral_code is not null then
select  array(select row_to_json(row) 
from ( select email_id
	 from tmm.tmm_user_master
	 where payment_status=1
	 and reg_referral_code=v_user_referral_code) as row)
into v_user_json;
  end if;

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
	v_platinum_medal as platinum_medal,
	ngo_name,
	donation_amount,
	ticket_amount,
	race_tee_amount,
	medal_amount,
	gst_amount,
	address,
	country,
	tee_size,
	run_club_name,
	elite_athlete,
	used_referral_code,
	reg_referral_code,
	v_user_json as referral_user_json,
	referral_reg_name
	from tmm.tmm_user_master
	where (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid)
	-- email_id = case when p_user_guid ='praveen22100@gmail.com' then 'sunil.chainani@gmail.com'
	---else p_user_guid end
		  )
	and payment_status=1  and race_type = 'virtual') as row
	into v_virtual_profile;
	
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
	v_platinum_medal as platinum_medal,
	ngo_name,
	donation_amount,
	ticket_amount,
	race_tee_amount,
	medal_amount,
	gst_amount,
	address,
	country,
	tee_size,
	run_club_name,
	elite_athlete,
	null as used_referral_code,
	null as reg_referral_code,
	null as referral_user_json
	--app_status
	from tmm.tmm_user_master
	where (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid)
	-- email_id = case when p_user_guid ='praveen22100@gmail.com' then 'sunil.chainani@gmail.com'
	---else p_user_guid end
		  )
	and payment_status=1 and race_type = 'onground'
	 ) row
	into v_og_profile;
	
	select row_to_json(row) 
from (
	select v_virtual_profile as virtual_profile,
	v_og_profile as onground_profile) as row
	into p_user_json;
	
	
	end;
$$;


--
