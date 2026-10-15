-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_export_details(numeric)
-- Type: FUNCTION

-- Name: dhm_get_export_details(numeric); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_export_details(p_opt_type numeric, OUT p_count_json jsonb, OUT p_export_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
v_group_count numeric;
v_payment_complete numeric;
v_payment_pending numeric;
v_group_user_count numeric;
begin

if p_opt_type is null
then
/*
select count(1)
from dhm.dhm_group
into v_group_count;*/

select count(1)
from dhm.dhm_user_master
where coalesce(payment_status,0) =0 
into v_payment_pending;

select count(1)
from dhm.dhm_user_master
where coalesce(payment_status,0) =1
into v_payment_complete;
/*
select count(1)
from dhm.dhm_user_activity_report
where group_name is not null and group_id is not null
into v_group_user_count;*/

select  row_to_json(row)
		from(
		select v_group_count as group_count,
			v_payment_pending as user_payment_pending,
			v_payment_complete as user_payment_complete,
			v_group_user_count as group_user_count
		) as row
		into p_count_json;

end if;

/*if p_opt_type =1 then
 

select array_to_json(array_agg(row))
		from
		(
		select group_name ,
no_of_runners,
pledged_distance ,
ind_1_50km ,
ind_51_100km ,
ind_101_above  ,
ov_1_50km ,
ov_51_100km ,
ov_101_above  ,
total_fees ,
invoice_address ,
group_contact_name ,
group_contact_email ,
group_contact_number ,
group_pancard_number ,
group_gst_number ,
state_name ,
corporate_type
			from   dhm.dhm_group	
			)
			as row
			into p_export_json;

end if;*/

if p_opt_type=2 then
select array_to_json(array_agg(row))
		from
		(
		select
email_id, 
	payment_status, 
	payment_amount,
	category, 
	pledged_distance, 
	group_id, 
	user_name, 
	city, 
	state_name, 
	pincode, 
	bib_no,
	height,
	weight,
	mobile_no, 
	external_user_id,
    dob,
    charity_amount,
nationality,
gender,
pledged_state,
pledged_city,
group_name,
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
where coalesce(payment_status,0) =0) as row
			into p_export_json;

end if;

if p_opt_type=3 then
select array_to_json(array_agg(row))
		from
		(
		select
email_id, 
	payment_status, 
	payment_amount,
	category, 
	pledged_distance, 
	group_id, 
	user_name, 
	city, 
	state_name, 
	pincode, 
	bib_no,
	height,
	weight,
	mobile_no, 
	external_user_id,
    dob,
    charity_amount,
nationality,
gender,
pledged_state,
pledged_city,
group_name,
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
			user_id,
			user_guid
from dhm.dhm_user_master
where coalesce(payment_status,0) =1) as row
into p_export_json;

end if;		

if p_opt_type=5 then
select array_to_json(array_agg(row))
		from
		(
		select
  um.user_id as reg_id,
 um.bib_no as bib	,
 null as tag,
rtrim(substring( user_name,1,position(' ' in  user_name) )) as fname,
 ltrim(substring( user_name,position(' ' in  user_name),length(user_name))) as lname,
um.gender as sex,
'Open' as Class,
null as course,
um.category as race,
null as	division,
um.city,
um.country,
null as team,
um.email_id as email,
1 as gps_remote,
um.dob as birthdate,
null as age

from dhm.dhm_user_master um
where payment_status =1) as row
into p_export_json;

end if;
 
 

/*
if p_opt_type =4 then  --- corporate users
  select array_to_json(array_agg(row))
		 
	 from (
	  select  
 user_name,
 distance,
 bib_no,
  group_id
 group_name,
 coalesce(pledged_city ,city) as city,
coalesce(pledged_state ,state_name) as state_name,
  runner_id,
  pledged_distance 
 from  dhm.dhm_user_activity_report
 where   group_name is not null
		 and group_id is not null
	order by user_name	 
	    ) as row
		into p_export_json;
  
end if;*/
			

end;
$$;


--
