-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_export_details(numeric)
-- Type: FUNCTION

-- Name: labtcs_get_export_details(numeric); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_export_details(p_opt_type numeric, OUT p_count_json jsonb, OUT p_export_json jsonb) RETURNS record
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

select count(1)
from labtcs.labtcs_group
into v_group_count; 

select count(1)
from labtcs.labtcs_user_master
where coalesce(payment_status,0) =0 
into v_payment_pending;

select count(1)
from labtcs.labtcs_user_master
where coalesce(payment_status,0) =1
into v_payment_complete;
/*
select count(1)
from labtcs.labtcs_user_activity_report
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

if p_opt_type =1 then
 

select array_to_json(array_agg(row))
		from
		(
		select  
group_name,
open10k_registrants,
open5k_registrants,
open10k_registrants_overseas,
open5k_registrants_overseas,
invoice_company_name,
invoice_address ,
group_contact_name,
group_contact_email,
group_contact_number,
group_pancard_number,
group_gst_number,
no_of_runners,
total_fees,
state_id,
state_name,
group_pancard_name,
corporate_type,
chosen_distance,
participation_format
			from   labtcs.labtcs_group	
			)
			as row
			into p_export_json;

end if;

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
  case when group_name ='Airtel Thanks App' then '' else group_name end as group_name,
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
from labtcs.labtcs_user_master
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
  case when group_name ='Airtel Thanks App' then '' else group_name end as group_name,
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
from labtcs.labtcs_user_master
where coalesce(payment_status,0) =1) as row
into p_export_json;

end if;		

if p_opt_type=5 then
select array_to_json(array_agg(row))
  from (
		select
 
 um.bib_no as Bib	,
  um.user_id as ParticipantID,
 case when  position(' ' in   ltrim(user_name)) > 0 then
initcap(rtrim(substring( ltrim(user_name),1,position(' ' in   ltrim(user_name)))))
	  else
	initcap(rtrim(substring( ltrim(user_name),1,length(user_name))))
	end  as "First Name",
	   case when  position(' ' in   ltrim(user_name)) > 0 then
initcap(ltrim(substring( ltrim(user_name),position(' ' in  ltrim(user_name)),length(user_name)))) 
	 else  
	    ''
	  end as  "Last Name",
um.gender as "Gender",
 
um.category as "Contest" ,
----to_char(cast(um.dob as date ),'DD-MM-YYYY') as birthdate,
date_part('year',current_timestamp)-date_part('year',um.dob) as  "Age"

from labtcs.labtcs_user_master um
where um.payment_status=1
  ) as row
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
 from  labtcs.labtcs_user_activity_report
 where   group_name is not null
		 and group_id is not null
	order by user_name	 
	    ) as row
		into p_export_json;
  
end if;*/
			

end;
$$;


--
