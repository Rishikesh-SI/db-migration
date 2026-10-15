-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_user_detail(text, numeric)
-- Type: FUNCTION

-- Name: dhm_get_user_detail(text, numeric); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_user_detail(p_email_id text, p_bib_no numeric, OUT p_user_json jsonb) RETURNS jsonb
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
	run_club_name
	from dhm.dhm_user_master
	where  ( (upper(email_id) =case when p_email_id is not null then
		   upper(p_email_id) else '' end )
	or bib_no=coalesce(p_bib_no,0))
	 and payment_status=1
	 ) row
	into p_user_json;
	
	
	end;
$$;


--
