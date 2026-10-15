-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_user_profile(text)
-- Type: FUNCTION

-- Name: tmm_get_user_profile(text); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_user_profile(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
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
	v_race_category character varying;
	v_tshirt_ques character varying;
	v_question character varying;
	v_racedetails jsonb;
	v_race_name character varying;
	v_race_type character varying;
	v_racedetails_array1 character varying[];
	v_race1 jsonb;
	v_race jsonb;
	v_race2 jsonb;
	v_race3 jsonb;
	v_ong_race_name character varying;
	v_vir_race_name character varying;
	p_user_json2 jsonb;
	p_user_json1 jsonb;
	v_vir_orderid character varying;
	v_ong_orderid character varying;
begin

	select case race_type when 'virtual' then 1 end as virtual,race_name
	from tmm.tmm_user_master	  
	where  user_guid = p_user_guid and race_type = 'virtual'
	into v_virtual,v_vir_race_name;

   select category,case race_type when 'on_ground' then 1 end as virtual,race_name
	from tmm.tmm_user_master	  
	where  user_guid = p_user_guid and race_type = 'on_ground'
	into v_category,v_onground,v_ong_race_name ;
----

select addons->'tickets'
into v_tickets
from tmm.tmm_user_master
where  user_guid = p_user_guid;

for v_addons1 in select * from jsonb_array_elements(v_tickets::jsonb)
      loop
        select v_addons1->>'questions',
				v_addons1->>'name'
	   into
	   v_addons2,
	   v_race_category;	 
   
	   for v_addons3 in (select * from jsonb_array_elements(v_addons2))
      loop
        select v_addons3->>'answer',
			   v_addons3->>'question'
	   into
	   v_tee_size1,
	   v_tshirt_ques;	
	   raise notice 'v_tshirt_ques %' , v_tshirt_ques;
	 
	 if v_tshirt_ques in ('T-Shirt Size') then
	v_tee_size2:= (array_append(v_tee_size2,v_tee_size1))::text[];   
 	end if;
	
	end loop;
	   
	   
	   end loop;

	if v_ong_race_name is not null then
		-- v_ong_race_name :=v_race_name;
		v_race1 := ' {
		"type":"onground",
		"name" : "'|| v_ong_race_name || '"
	}';
	
	end if;
	
	if v_vir_race_name is not null then
	
		-- v_vir_race_name :=v_race_name;
		v_race2 := ' {
		"type":"virtual",
		"name" : "'|| v_vir_race_name || '"
	}';
	end if;	

	raise notice 'v_race %' , v_race1;
	raise notice 'v_race %' , v_race2;
 --v_race := v_race1 || v_race2 ;
	

--	 v_race11 := jsonb_set(v_race11, '{on_ground}',coalesce(v_race1,'null'), true);
raise notice 'v_race %' , v_race;
 
if v_onground=1  then
	
	select order_id into v_ong_orderid from tmm.tmm_user_master
	where  user_guid = p_user_guid 
	and race_type='on_ground';
end if;	
--	else 
if v_virtual=1  then	
	select order_id into v_vir_orderid from tmm.tmm_user_master
	where  user_guid = p_user_guid 
	and race_type='virtual';
	
	end if;
-----------------------------------------------------------------

    select row_to_json(row) 
	from(
	select distinct um.email_id ,um.mobile_no,um.dob as dateOfBirth,um.gender,
		wu.first_name as firstName,wu.last_name as lastName,um.application_status as application_status,
		um.applicationid,um.lineupsection,
		um.yearband as years_participated,
		v_vir_orderid::text as virtual_orderid,
		v_ong_orderid::text as onground_orderid,
		addons->>'eventId' as event_id,um.city,um.state_name,um.bib_no,
		addons->'extraDetails'->>'vaccinationCertificateUploaded' as vaccinationCertificateUploaded,
		addons->'extraDetails'->>'vaccinationType' as vaccinationtype,
		um.group_name,um.rejectionremarks,um.run_club_name,
		
		--addons->>'status' as status,
		--case um.category when '25K Run (25 Km)' then v_tee_size2 end,
		--case um.category when '25K Run (25 Km)' then v_tickets5 end,
		v_tee_size2 as tshirt_size,
		--v_racedetails_array1 as RaceDetails,--v_tickets5 as event_dates,
		coalesce (v_onground,0) as onground , coalesce(v_virtual,0) as virtual ,um.category
	from tmm.tmm_user_master um
	left join tmm.tmm_web_user wu on um.user_guid = wu.user_guid
	where um.user_guid = p_user_guid)row
	into p_user_json;
	
p_user_json:=jsonb_set(p_user_json, '{onground_racedetails}',coalesce(v_race1,'null'), true);
p_user_json:=jsonb_set(p_user_json, '{virtual_racedetails}',coalesce(v_race2,'null'), true);
	end;
$$;


--
