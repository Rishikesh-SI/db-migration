-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_user_profile(text)
-- Type: FUNCTION

-- Name: labtcs_get_user_profile(text); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_user_profile(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
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
	v_vaccinationtype character varying;
	v_bib_no_og numeric;
	v_bib_no_virt numeric;
	v_virtual_appstatus character varying;
	v_onground_appstatus character varying;
	v_application_status character varying;
	v_avgPace_vir  character varying;
	v_finishStatus_vir  character varying;
	v_activeTimeinSec_vir character varying;
	v_distanceCovered_vir  character varying;
	v_elapsedTimeinSec_vir	character varying;
	v_avgPace_ong  character varying;
	v_finishStatus_ong  character varying;
	v_activeTimeinSec_ong character varying;
	v_distanceCovered_ong  character varying;
	v_elapsedTimeinSec_ong	character varying;

begin

	select case race_type when 'virtual' then 1 end as virtual,race_name,bib_no,order_id,application_status,
	v_avgPace_vir,v_finishStatus_vir,v_activeTimeinSec_vir,v_distanceCovered_vir,v_elapsedTimeinSec_vir
	from labtcs.labtcs_user_master	  
	where  user_guid = p_user_guid and race_type = 'virtual'
	and is_deleted=0
	into v_virtual,v_vir_race_name,v_bib_no_virt,v_vir_orderid,v_virtual_appstatus;

   select category,case race_type when 'on_ground' then 1 end as virtual,race_name,addons->'extraDetails'->>'vaccinationType',
   bib_no,order_id,application_status
	from labtcs.labtcs_user_master	  
	where  user_guid = p_user_guid and race_type = 'on_ground'
		and is_deleted=0
	into v_category,v_onground,v_ong_race_name,v_vaccinationtype,v_bib_no_og,v_ong_orderid,v_onground_appstatus;
----

	select avgpace,finishstatus,activetimeinsec,distance_class,elapsedtimeinsec
	into v_avgPace_ong,v_finishStatus_ong,v_activeTimeinSec_ong,v_distanceCovered_ong,v_elapsedTimeinSec_ong
	from labtcs.labtcs_user_race_challange
	where user_guid = p_user_guid and race_type = 'on_ground';

	select avgpace,finishstatus,activetimeinsec,distance_class,elapsedtimeinsec
	into v_avgPace_vir,v_finishStatus_vir,v_activeTimeinSec_vir,v_distanceCovered_vir,v_elapsedTimeinSec_vir
	from labtcs.labtcs_user_race_challange
	where user_guid = p_user_guid and race_type = 'virtual';

	if v_ong_race_name is not null then
		-- v_ong_race_name :=v_race_name;
		v_race1 := ' {
		"type":"onground",
		"name" : "'|| v_ong_race_name || '",
		"bib_no" : "'|| coalesce(v_bib_no_og,0) || '",
		"avgPace" : "'|| coalesce(v_avgPace_ong,'') || '",
		"finishStatus" : "'|| coalesce(v_finishStatus_ong,'') || '",
		"activeTimeinSec" : "'|| coalesce(v_activeTimeinSec_ong,'') || '",
		"distanceCovered" : "'|| coalesce(v_distanceCovered_ong,'') || '",
		"elapsedTimeinSec" : "'|| coalesce(v_elapsedTimeinSec_ong,'') || '"		
	}';
	
	end if;
	
	if v_vir_race_name is not null then
	
		-- v_vir_race_name :=v_race_name;
		v_race2 := ' {
		"type":"virtual",
		"name" : "'|| v_vir_race_name || '",
		"bib_no" : "'|| coalesce(v_bib_no_virt,0) || '",
		"avgPace" : "'|| coalesce(v_avgPace_vir,'') || '",
		"finishStatus" : "'|| coalesce(v_finishStatus_vir,'') || '",
		"activeTimeinSec" : "'|| coalesce(v_activeTimeinSec_vir,'') || '",
		"distanceCovered" : "'|| coalesce(v_distanceCovered_vir,'') || '",
		"elapsedTimeinSec" : "'|| coalesce(v_elapsedTimeinSec_vir,'') || '"		
	}';
	end if;	

	if ((v_onground=0 or v_onground is null) and (v_virtual=1)) then
		v_application_status:=v_virtual_appstatus; -- v_onground_appstatus
	else
		v_application_status:=v_onground_appstatus; -- v_onground_appstatus
	end if;

--	 v_race11 := jsonb_set(v_race11, '{on_ground}',coalesce(v_race1,'null'), true);
raise notice 'v_race %' , v_race;

-----------------------------------------------------------------

    select row_to_json(row) 
	from(
	select distinct um.email_id ,um.mobile_no,um.dob as dateOfBirth,um.gender,
		wu.first_name as firstName,wu.last_name as lastName,v_application_status as application_status,
		um.applicationid,um.lineupsection,
		um.yearband as years_participated,
		addons->>'eventId' as event_id,um.city,um.state_name,
		addons->'extraDetails'->>'vaccinationCertificateUploaded' as vaccinationCertificateUploaded,
		--addons->'extraDetails'->>'vaccinationType' as vaccinationtype,
		v_vaccinationtype as vaccinationtype ,um.group_name,um.rejectionremarks,um.run_club_name,
		v_ong_orderid as onground_orderid,v_vir_orderid as virtual_orderid,
		--addons->>'status' as status,
		--case um.category when '25K Run (25 Km)' then v_tee_size2 end,
		--case um.category when '25K Run (25 Km)' then v_tickets5 end,
		--v_tee_size2 as tshirt_size,
		--v_racedetails_array1 as RaceDetails,--v_tickets5 as event_dates,
		coalesce (v_onground,0) as onground , coalesce(v_virtual,0) as virtual ,
		wu.coupon_code,collectiontype,a.slot_date as bib_slot_date ,a.slot_time as bib_slot_time
	from labtcs.labtcs_user_master um
	left join labtcs.labtcs_web_user wu on um.user_guid = wu.user_guid
	left join labtcs.labtcs_bib_collection_slots a on wu.user_guid=a.user_guid
	left join labtcs.labtcs_user_race_challange b on wu.user_guid=b.user_guid
	where um.user_guid = p_user_guid
	--and um.is_deleted=0
	)row
	into p_user_json;
	
p_user_json:=jsonb_set(p_user_json, '{onground_racedetails}',coalesce(v_race1,'null'), true);
p_user_json:=jsonb_set(p_user_json, '{virtual_racedetails}',coalesce(v_race2,'null'), true);
	end;
$$;


--
