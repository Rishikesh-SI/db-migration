-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_bib_collection_slot(jsonb)
-- Type: FUNCTION

-- Name: labtcs_ins_bib_collection_slot(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_bib_collection_slot(p_json jsonb, OUT p_result jsonb, OUT p_result_status numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_count numeric;
v_slot_date character varying;
v_slot_time character varying;
v_user_guid character varying;
v_slot_time_id numeric;
v_city_name character varying;
v_bib_coll_id numeric;
v_user_id numeric;
v_city_name1 character varying;
v_no numeric;
v_event_id numeric;
v_orderid character varying;
v_slot_timings character varying;
v_category character varying;
v_bib_no numeric;
v_applicationid numeric;
v_email_id character varying;
v_first_name character varying;
v_last_name character varying;
v_user_name character varying;
v_dob character varying;
v_gender character varying;
v_race_name character varying;
v_count_slotid numeric;
v_expo_name character varying;
v_expo_address character varying;
v_years_participated character varying;
v_categoryid numeric;
v_short_name character varying;
v_slot_day_id numeric;
v_slot_day_count numeric;
v_collectiontype character varying;
v_slot_time_count numeric;
v_applicationstatus character varying;
v_email_subject character varying;
begin

select p_json->>'slot_date',
	   p_json->>'slot_time_id',
	   p_json->>'slot_time',
	   p_json->>'user_guid',
	   p_json->>'slot_date_id'
--	   p_json->>'user_guid',
	   
into
		v_slot_date,
		v_slot_time_id,
		v_slot_time,
		v_user_guid,
		v_slot_day_id;

/*
1-23
2-24
3-25
4-26
*/

v_short_name:= 'Majja Run';
v_expo_name:='To be added';
v_expo_address:='Jayamahal Palace - 1, Jayamahal Main Rd, near Cantonment Railway Station Road, Nandi Durga Road Extension, Jayamahal, Bengaluru, Karnataka 560046.';
v_email_subject:='TCSW10K | Bib Collection Slot Booking Confirmation';

select collectiontype,application_status,categoryid
into v_collectiontype,v_applicationstatus,v_categoryid
from labtcs.labtcs_user_master
where user_guid=v_user_guid
and race_type='on_ground';
--and slot_date_id=v_slot_date_id;

if v_categoryid = 27 then
	v_short_name:='Open 10K';

elseif v_categoryid = 28 then
	v_short_name:='Majja Run';

elseif v_categoryid = 29 then
	v_short_name:='Senior Citizens Run';

elseif v_categoryid = 30 then
	v_short_name:='Champions with Disability';

end if;	

if v_user_guid = (select distinct(user_guid) from labtcs.labtcs_bib_collection_slots
				 where user_guid=v_user_guid
				 ) then 
		p_result:='{
					"status":"0",
					"message":"Slot already booked for this user."
					}';
		
		p_result_status:=0;
		 
else		 

select count(1)
into v_slot_day_count
from labtcs.labtcs_bib_collection_slots
where slot_day_id=v_slot_day_id;

select count(1)
into v_slot_time_count
from labtcs.labtcs_bib_collection_slots
where slot_time_id=v_slot_time_id;

raise notice 'v_slot_time_count %',v_slot_time_count;

if (v_collectiontype in ('Self','self','SELF') and v_applicationstatus = 'CONFIRMED') then

if (v_slot_day_count < 8000 ) then
	if ((v_slot_day_id in (1,2) and v_slot_time_id in (10,11,12)) or (v_slot_day_id = 3 and v_slot_time_id in (13,14,15))) then
		if (((v_slot_time_id in (10,11,13,14)) and (v_slot_time_count < 2667)) or ((v_slot_time_id in (12,15)) and (v_slot_time_count < 2666))) then
 
	
		v_bib_coll_id:= nextval('labtcs.seq_labtcs_bib_coll_id');
		
		insert into labtcs.labtcs_bib_collection_slots(bib_slot_id,slot_date,user_guid,created_date,updated_date,slot_time,slot_day_id,slot_time_id)
		values(v_bib_coll_id,v_slot_date,v_user_guid,current_timestamp,current_timestamp,v_slot_time,v_slot_day_id,v_slot_time_id);

		select row_to_json(row) 
			from (
			select addons->>'eventId' as event_id,order_id,external_user_id as user_id,bib_no,applicationid as application_id,lineupsection as line_up_section,
				email_id::text,firstname as first_name,lastname as last_name,
				user_name as user_name,dob as dob,gender as gender,v_slot_date as slot_date,yearband as year_participated,
				v_slot_time as slot_time,v_slot_time_id as slot_time_id,v_expo_name as expo_name,v_expo_address as expo_address,
				v_short_name as race_short_name,race_name as race_category,v_email_subject as email_subject
				from labtcs.labtcs_user_master a
				where user_guid=v_user_guid
				and race_type='on_ground') row
				into p_result;
					--_result:=  jsonb_set(p_result,('"'||v_1||'"')::jsonb, true);	

				p_result:=  jsonb_set(p_result,'{short_name}',('"'||v_short_name||'"')::jsonb, true);	
	
		
					raise notice '%',p_result;

					p_result_status:=1;

					else 

					p_result:='{
							"status":"0",
							"message":"Slots Full."
							}';
					p_result_status:=0;
					end if;
else
p_result:='{
		"status":"0",
		"message":"Invalid Slot."
		}';
p_result_status:=0;
end if;	
else
p_result:='{
		"status":"0",
		"message":"Slot Full For A Day."
		}';
p_result_status:=0;
end if;
end if;
end if;
--p_result:=  jsonb_set((p_result),'{tshirt_size}', ('"'||v_tee_size2||'"')::jsonb, true);

end;
$$;


--
