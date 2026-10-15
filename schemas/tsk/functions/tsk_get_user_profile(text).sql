-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_user_profile(text)
-- Type: FUNCTION

-- Name: tsk_get_user_profile(text); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_user_profile(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
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
	v_virtual numeric;
	v_onground  numeric;
	v_category varchar(500);
	v_tee_size jsonb;
	v_tee_size1 character varying;
	v_addons jsonb;
	v_addons1 jsonb;
	v_addons2 jsonb;
	v_tee_size2 character varying[];
	v_addons3 jsonb;
	v_tickets jsonb;
	v_tickets5 character varying[];
	v_tickets1 jsonb;
	v_tickets2 jsonb;
	v_tickets3 jsonb;
	v_tickets4 character varying;
begin

	select case race_type when 'virtual' then 1 end as virtual
	from tsk.tsk_user_master	  
	where  user_guid = p_user_guid and race_type = 'virtual'
	into v_virtual;

   select category,case race_type when 'on_ground' then 1 end as virtual
	from tsk.tsk_user_master	  
	where  user_guid = p_user_guid and race_type = 'on_ground'
	into v_category,v_onground ;
    --raise notice '%,%' , v_onground,v_virtual;
----

select addons->'tickets' 
into v_tickets 
from tsk.tsk_user_master
where  user_guid = p_user_guid and 
category LIKE '25%';

raise notice 'v_addons %' , v_addons;

for v_addons1 in select * from jsonb_array_elements(v_tickets::jsonb)
      loop
        select v_addons1
	   into
	   v_addons2;	 
	   
	   end loop;
--raise notice 'v_addons2 %' , v_addons2;

select v_addons2->>'questions' into v_addons3;

 --raise notice 'v_addons3 %' , v_addons3;

	   for v_addons3 in (select * from jsonb_array_elements(v_addons3::jsonb))
      loop
        select v_addons3->>'answer'
	   into
	   v_tee_size1;	
	   
	v_tee_size2:= (array_append(v_tee_size2,v_tee_size1))::text[];   
 
end loop;
 -- v_tee_size2:=v_tee_size1::text;
 
--raise notice 'v_tee_size1 %' , v_tee_size1;	

-----------------------------------------------------------------

    select row_to_json(row) 
	from(
	select distinct um.email_id ,um.mobile_no,um.dob as dateOfBirth,um.gender,
		wu.first_name as firstName,wu.last_name as lastName,um.applicationstatus,
		um.applicationid,um.lineupsection,
		um.order_id::text,addons->>'eventId' as event_id,um.city,um.state_name,um.bib_no,
		addons->'extraDetails'->>'vaccinationCertificateUploaded' as vaccinationCertificateUploaded,
		addons->'extraDetails'->>'vaccinationType' as vaccinationtype,
		--addons->>'status' as status,
		--case um.category when '25K Run (25 Km)' then v_tee_size2 end,
		--case um.category when '25K Run (25 Km)' then v_tickets5 end,
		v_tee_size2 as tshirt_size,--v_tickets5 as event_dates,
		coalesce (v_onground,0) as onground , coalesce(v_virtual,0) as virtual ,v_category as category
	from tsk.tsk_user_master um
	left join tsk.tsk_web_user wu on um.user_guid = wu.user_guid
	where um.user_guid = p_user_guid)row
	into p_user_json;
	
--p_user_json:=jsonb_set(p_user_json, '{data,tee_size}',coalesce(v_tee_size1,'null'), true);
	
	end;
$$;


--
