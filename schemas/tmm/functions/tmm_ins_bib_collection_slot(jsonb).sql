-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_ins_bib_collection_slot(jsonb)
-- Type: FUNCTION

-- Name: tmm_ins_bib_collection_slot(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_ins_bib_collection_slot(p_json jsonb, OUT p_result jsonb, OUT p_result_status numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_count numeric;
v_slot_date character varying;
v_slot_time character varying;
v_user_guid character varying;
v_slot_date_id numeric;
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
begin

select p_json->>'slot_date',
	   p_json->>'slot_date_id',
	   p_json->>'slot_time',
	   p_json->>'user_guid'
into
		v_slot_date,
		v_slot_date_id,
		v_slot_time,
		v_user_guid;

/*
1-23
2-24
3-25
4-26
*/

select categoryid into v_categoryid
from tmm.tmm_user_master
where user_guid=v_user_guid
and race_type='on_ground';
--and slot_date_id=v_slot_date_id;

if v_categoryid = 15 then
	v_short_name:='Marathon';

elseif v_categoryid = 16 then
	v_short_name:='Half Marathon';

elseif v_categoryid = 17 then
	v_short_name:='Open 10K-10km';

elseif v_categoryid = 18 then
	v_short_name:='Dream Run-7 km';

elseif v_categoryid = 23 then
	v_short_name:='Senior Citizens’ Run';

elseif v_categoryid = 24 then
	v_short_name:='Champions with Disability';
	
end if;	

	raise notice 'v_short_name 1 % ',v_short_name;

if v_user_guid = (select distinct(user_guid) from tmm.tmm_bib_collection_slots
				 where user_guid=v_user_guid
				 ) then 
		p_result:='{
		"status":"0",
		"message":"Slot already booked for this user."
		}';
		
		p_result_status:=0;
		 
else		 


select count(1) 
into v_count_slotid
from tmm.tmm_bib_collection_slots
where --user_guid=v_user_guid
slot_date_id=v_slot_date_id
and slot_time=v_slot_time;

 
if (v_categoryid in (16,17)) and (v_slot_date_id in (1,2,3)) or
	((v_categoryid in (15,18)) and (v_slot_date_id in (1,2,3,4)))then
	if v_count_slotid < 3000 then
	
		v_bib_coll_id:= nextval('tmm.seq_tmm_bib_coll_id');
		
		insert into tmm.tmm_bib_collection_slots
		values(v_bib_coll_id,v_slot_date,v_user_guid,current_timestamp,current_timestamp,v_slot_time,v_slot_date_id,v_categoryid);

select row_to_json(row) 
	from (
	select addons->>'eventId' as event_id,order_id,external_user_id as user_id,bib_no,applicationid as application_id,
		email_id::text,firstname as first_name,lastname as last_name,
		user_name as user_name,dob as dob,gender as gender,v_slot_date as slot_date,
		v_slot_time as slot_time,v_slot_date_id as slot_date_id
		from tmm.tmm_user_master a
		where user_guid=v_user_guid
		and race_type='on_ground') row
		into p_result;
			--_result:=  jsonb_set(p_result,('"'||v_1||'"')::jsonb, true);	
		
		raise notice 'v_short_name 2 % ',v_short_name;
		
			if v_categoryid = 15 then
				p_result:=  jsonb_set(p_result,'{short_name}',('"'||v_short_name||'"')::jsonb, true);	

			elseif v_categoryid = 16 then
				p_result:=  jsonb_set(p_result,'{short_name}', ('"'||v_short_name||'"')::jsonb, true);	

			elseif v_categoryid = 17 then
				p_result:=  jsonb_set(p_result,'{short_name}', ('"'||v_short_name||'"')::jsonb, true);	

			elseif v_categoryid = 18 then
				p_result:=  jsonb_set(p_result,'{short_name}', ('"'||v_short_name||'"')::jsonb, true);	

			elseif v_categoryid = 23 then
				p_result:=  jsonb_set(p_result,'{short_name}', ('"'||v_short_name||'"')::jsonb, true);	

			elseif v_categoryid = 24 then
				p_result:=  jsonb_set(p_result,'{short_name}', ('"'||v_short_name||'"')::jsonb, true);	

			end if;		
		
	
		
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
		"message":"Cannot book slot."
		}';
p_result_status:=0;
end if;	
end if;	

--p_result:=  jsonb_set((p_result),'{tshirt_size}', ('"'||v_tee_size2||'"')::jsonb, true);

end;
$$;


--
