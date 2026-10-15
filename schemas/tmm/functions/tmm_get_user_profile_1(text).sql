-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_user_profile_1(text)
-- Type: FUNCTION

-- Name: tmm_get_user_profile_1(text); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_user_profile_1(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
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
	v_addons2_array jsonb[];
	v_tee_size2 character varying[];
	v_addons3 jsonb;
	v_tickets jsonb;
	v_tickets5 character varying[];
	v_tickets1 jsonb;
	v_tickets2 jsonb;
	v_tickets3 jsonb;
	v_tickets4 character varying;
begin

	select category,case race_type when 'virtual' then 1 end as virtual
	from tmm.tmm_user_master	  
	where  user_guid = p_user_guid and race_type = 'virtual'
	into v_category,v_virtual;

   select category,case race_type when 'on_ground' then 1 end as virtual
	from tmm.tmm_user_master	  
	where  user_guid = p_user_guid and race_type = 'on_ground'
	into v_category,v_onground ;
    --raise notice '%,%' , v_onground,v_virtual;
----

select addons->'tickets' 
into v_tickets 
from tmm.tmm_user_master
where  user_guid = p_user_guid and 
category LIKE '42%';

raise notice 'v_tickets %' , v_tickets;

for v_addons1 in select * from jsonb_array_elements(v_tickets::jsonb)
      loop
        select v_addons1->>'questions'
	   into
	   v_addons2;	 
---	   
	   for v_addons3 in (select * from jsonb_array_elements(v_addons2))
      loop
        select v_addons3->>'answer'
	   into
	   v_tee_size1;	
	   raise notice 'v_tee_size1 %' , v_tee_size1;
	v_tee_size2:= (array_append(v_tee_size2,v_tee_size1))::text[];   
 
	end loop;
	   
	   raise notice 'v_tee_size2 = %' , v_tee_size2;
	   end loop;
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
		coalesce (v_onground,0) as onground , coalesce(v_virtual,0) as virtual ,um.category
	from tmm.tmm_user_master um
	left join tmm.tmm_web_user wu on um.user_guid = wu.user_guid
	where um.user_guid = p_user_guid)row
	into p_user_json;
	
--p_user_json:=jsonb_set(p_user_json, '{data,tee_size}',coalesce(v_tee_size1,'null'), true);
	
	end;
$$;


--
