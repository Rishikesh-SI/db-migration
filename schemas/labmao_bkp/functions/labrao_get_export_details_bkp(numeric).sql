-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_get_export_details_bkp(numeric)
-- Type: FUNCTION

-- Name: labrao_get_export_details_bkp(numeric); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_get_export_details_bkp(p_opt_type numeric, OUT p_count_json jsonb, OUT p_export_json jsonb) RETURNS record
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
from labrao.labrao_group
where group_id>=11030
into v_group_count;

select count(1)
from labrao.labrao_user_master
where coalesce(payment_status,0) =0 
into v_payment_pending;

select count(1)
from labrao.labrao_user_master
where coalesce(payment_status,0) =1
into v_payment_complete;
select count(1)
from labrao.labrao_user_activity_report
where group_name is not null and group_id is not null
into v_group_user_count;

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
		select group_name ,
no_of_runners,
pledged_distance ,
ind_1_50km  as Indian_change_maker,
ind_51_100km as Indian_change_leader,
ind_101_above  as Indian_change_champion,
ov_1_50km as overseas_change_maker,
ov_51_100km  as overseas_change_leader,
ov_101_above as overseas_change_champion ,
total_fees ,
invoice_address ,
group_contact_name ,
group_contact_email ,
group_contact_number ,
group_pancard_number ,
group_gst_number ,
state_name ,
corporate_type
			from   labrao.labrao_group	
			where group_id>=11030
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
group_name
from labrao.labrao_user_master
where coalesce(payment_status,0) =0) as row
			into p_export_json;

end if;

if p_opt_type=3 then
select array_to_json(array_agg(row))
		from
		(
		select
tb.email_id, 
			tb.user_guid,
	tb.payment_status, 
	 tb.payment_amount,
	tb.category, 
	tb.pledged_distance, 
	tb.group_id, 
	tb.user_name, 
	tb.city, 
	tb.state_name, 
	tb.pincode, 
	tb.bib_no,
	tb.height,
	tb.weight,
	tb.mobile_no, 
	tb.external_user_id,
    tb.dob,
    tb.charity_amount,
tb.nationality,
tb.gender,
tb.pledged_state,
tb.pledged_city,
tb.group_name,
 round(tc.distance,2) as distance,
 "2020-08-15", 
 "2020-08-16", 
"2020-08-17",
"2020-08-18",
"2020-08-19",
"2020-08-20",
"2020-08-21", 
"2020-08-22",
"2020-08-23",
"2020-08-24",
"2020-08-25", 
"2020-08-26",
"2020-08-27", 
"2020-08-28", 
"2020-08-29",
"2020-08-30", 
"2020-08-31", 
"2020-09-01", 
"2020-09-02", 
"2020-09-03", 
"2020-09-04",
"2020-09-05",
"2020-09-06", 
"2020-09-07", 
"2020-09-08", 
"2020-09-09", 
"2020-09-10", 
"2020-09-11", 
"2020-09-12",
"2020-09-13"

from labrao.labrao_user_master tb
left join labrao.labrao_user_activity_report tc
			on tc.user_id=tb.user_id
where coalesce(tb.payment_status,0) =1) as row
into p_export_json;

end if;			
			

if p_opt_type =4 then  --- corporate users
  select array_to_json(array_agg(row))
		 
	 from (
	  select  
 tb.user_name,
 tb.email_id,
 u.mobile_no,
 tb.distance,
 tb.bib_no,
  tb.group_id,
 tb.group_name,
 coalesce(tb.pledged_city ,tb.city) as city,
coalesce(tb.pledged_state ,tb.state_name) as state_name,
  tb.runner_id,
  tb.pledged_distance 
 from  labrao.labrao_user_activity_report tb
		 join labrao.labrao_user_master u
		 on u.user_id=tb.user_id
 where   tb.group_name is not null
		 and tb.group_id is not null
	order by tb.user_name	 
	    ) as row
		into p_export_json;
  
end if;
end;

 $$;


--
