-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_ins_bib_collection_slot(jsonb)
-- Type: FUNCTION

-- Name: tsk_ins_bib_collection_slot(jsonb); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_ins_bib_collection_slot(p_json jsonb, OUT p_result jsonb, OUT p_result_status numeric) RETURNS record
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
v_orderid numeric;
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
v_addons jsonb;
	v_addons1 jsonb;
	v_addons2 jsonb;
	v_tee_size2 character varying[];
	v_addons3 jsonb;
	v_tickets jsonb;
	v_tee_size1 character varying;
v_expo_name character varying;
v_expo_address character varying;
v_years_participated character varying;

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

if v_user_guid = (select distinct(user_guid) from tsk.tsk_bib_collection_slots
				 where user_guid=v_user_guid) then 
		p_result:='{
		"status":"0",
		"message":"Slot already booked for this user."
		}';
		
		p_result_status:=0;
		 
else		 

v_expo_name:='To be added';
v_expo_address:='To be added';
v_years_participated:='To be added';

select addons->'tickets' 
into v_tickets 
from tsk.tsk_user_master
where  user_guid = v_user_guid and 
category LIKE '25%';

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
	   
--	v_tee_size2:= (array_append(v_tee_size2,v_tee_size1))to_jsonb;   
 
end loop;

----------------------------

select user_id,addons->>'eventId',addons->>'orderId',category,bib_no,applicationid,email_id,firstname,lastname,user_name,dob,gender
into v_user_id,v_event_id,v_orderid,v_category,v_bib_no,v_applicationid,v_email_id,v_first_name,v_last_name,v_user_name,v_dob,v_gender
from tsk.tsk_user_master
where user_guid=v_user_guid;

/*
select email_id,first_name,last_name,user_full_name,dob,gender
into v_email_id,v_first_name,v_last_name,v_user_full_name,v_dob,v_gender
from tsk.tsk_web_user
where user_guid=v_user_guid;  */

select city into v_city_name
from tsk.tsk_user_master
where user_guid=v_user_guid;

select count(1) into v_count 
from tsk.tsk_bib_collection_slots
where slot_id = v_slot_date_id;

select city into v_city_name1
from tsk.tsk_user_master
where user_guid=v_user_guid
and city LIKE 'Kolkata%';

if v_city_name1 is not null then
v_no:=1;
end if;

if v_no is null  and v_count < 2100 then
	
	v_bib_coll_id:= nextval('tsk.seq_tsk_bib_coll_id');
	 
	 insert into tsk.tsk_bib_collection_slots
	 values(v_bib_coll_id,v_slot_date,v_user_guid,v_city_name,current_timestamp,current_timestamp,v_slot_time,v_slot_date_id);
	

--v_slot_timings:= v_slot_date || ' ' || v_slot_time;

p_result:='{
"user_id":"'||v_user_id||'",
"slot_date":"'||v_slot_date||'",
"slot_time":"'||v_slot_time||'",
"slot_id":"'||v_slot_date_id||'",
"event_id":"'||v_event_id||'",
"order_id":"'||v_orderid||'",
"category":"'||v_category||'",
"bib_no":"'||v_bib_no||'",
"application_id":"'||coalesce(v_applicationid,0)||'",
"email_id":"'||coalesce(v_email_id,'')||'",
"first_name":"'||coalesce(v_first_name,'')||'",
"last_name":"'||coalesce(v_last_name,'')||'",
"user_name":"'||coalesce(v_user_name,'')||'",
"dob":"'||coalesce(v_dob,'')||'",
"gender":"'||coalesce(v_gender,'')||'",
"tshirt_size":"'||coalesce(v_tee_size1,'')||'",
"expo_name":"'||coalesce(v_expo_name,'')||'",
"expo_address":"'||coalesce(v_expo_address,'')||'",
"years_participated":"'||coalesce(v_years_participated,'')||'",
"email_subject":"TSK  =  {0}: Tata Steel Kolkata 25K 2021 | Bib Collection Date And Slot"
}';

--p_result:=  jsonb_set((p_result),'{tshirt_size}', ('"'||v_tee_size2||'"')::jsonb, true);
--"slot_date":"'||v_slot_date||'",
--"slot_time":"'||v_slot_time||'",

p_result_status:=1;

	 else 
if v_no is not null and ( v_slot_date_id = 1 or v_slot_date_id = 2) and  v_count < 2100 then
	 
	 v_bib_coll_id:= nextval('tsk.seq_tsk_bib_coll_id');
	 
	 insert into tsk.tsk_bib_collection_slots
	 values(v_bib_coll_id,v_slot_date,v_user_guid,v_city_name,current_timestamp,current_timestamp,v_slot_time,v_slot_date_id);

--v_slot_timings:= v_slot_date || ' ' || v_slot_time;

p_result:='{
"user_id":"'||v_user_id||'",
"slot_date":"'||v_slot_date||'",
"slot_time":"'||v_slot_time||'",
"slot_id":"'||v_slot_date_id||'",
"event_id":"'||v_event_id||'",
"order_id":"'||v_orderid||'",
"category":"'||v_category||'",
"bib_no":"'||v_bib_no||'",
"application_id":"'||coalesce(v_applicationid,0)||'",
"email_id":"'||coalesce(v_email_id,'')||'",
"first_name":"'||coalesce(v_first_name,'')||'",
"last_name":"'||coalesce(v_last_name,'')||'",
"user_name":"'||coalesce(v_user_name,'')||'",
"dob":"'||coalesce(v_dob,'')||'",
"gender":"'||coalesce(v_gender,'')||'",
"tshirt_size":"'||coalesce(v_tee_size1,'')||'",
"expo_name":"'||coalesce(v_expo_name,'')||'",
"expo_address":"'||coalesce(v_expo_address,'')||'",
"years_participated":"'||coalesce(v_years_participated,'')||'",
"email_subject":"TSK  =  {0}: Tata Steel Kolkata 25K 2021 | Bib Collection Date And Slot"
}';

--p_result:=  jsonb_set((p_result),'{tshirt_size}', ('"'||v_tee_size2||'"')::jsonb, true);

--"slot_date":"'||v_slot_date||'",
--"slot_time":"'||v_slot_time||'",

p_result_status:=1;

else 

p_result:='{
"status":"0",
"message":"Invalid Slots/Slots full"
}';

p_result_status:=0;

	 end if;
end if;
end if;
end;
$$;


--
