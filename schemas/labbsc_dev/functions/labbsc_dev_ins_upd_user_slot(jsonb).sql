-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_slot(p_json jsonb, OUT p_out numeric, OUT p_user_slot_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 
v_user_slot_exists numeric;
v_user_id numeric;
v_counseller_id numeric;
v_session_date date;
v_session_slot varchar(500);
v_is_rescheduled numeric;
v_is_requested numeric;
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
v_status numeric;
v_session_id numeric;
v_slot_id numeric;
v_slot_exists numeric;
v_user_email_id text;
v_counseller_email_id text;
v_counseller_name text;
v_user_name text;
v_user_guid text;
v_first_name text;
v_last_name text;
v_meet_link_info jsonb;
v_cart_id numeric;
begin
select p_json->>'user_guid' ,
       p_json->>'counseller_id' ,
	   p_json->>'session_date' ,
	   p_json->>'session_slot' ,
	   p_json->>'is_rescheduled' ,
	   p_json->>'is_requested' ,
	    p_json->>'session_id' 
 into
 v_user_guid,
 v_counseller_id,
 v_session_date,
 v_session_slot,
 v_is_rescheduled,
 v_is_requested,
 v_session_id
 ;
 
 
begin
select full_name,email_id 
from labbsc_dev.labbsc_dev_user 
where user_id=v_counseller_id
into v_counseller_name,v_counseller_email_id ;

select  user_full_name,email_id ,user_id,first_name,last_name
from labbsc_dev.labbsc_dev_web_user 
where user_guid=v_user_guid
into v_user_name,v_user_email_id,v_user_id,v_first_name,v_last_name ;

select max(cart_id)
from labbsc_dev.labbsc_dev_cart
where user_id=v_user_id
and activity_id=3
and  status=2
and counseller_id=v_counseller_id
and coalesce(session_id,0) =0 and coalesce(request_id,0) =0
into v_cart_id;
 
exception when others then
p_out:=-1; 

end;

 
 if p_out is null then
select count(1)
from  labbsc_dev.labbsc_dev_user_counselling_session
where user_id=v_user_id
and counseller_id =v_counseller_id
and status =0
into v_user_slot_exists;

select count(1)
from  labbsc_dev.labbsc_dev_counseller_slot
where   counseller_user_id =v_counseller_id
and session_date=v_session_date
and session_slot=v_session_slot
and status=0
into v_slot_exists;

if ((v_user_slot_exists =0  and v_slot_exists >0) or (v_user_slot_exists =0  and v_slot_exists =0 and v_is_requested=1)) then
 
v_session_id:= nextval('labbsc_dev.seq_labbsc_dev_session_id');
 
insert into labbsc_dev.labbsc_dev_user_counselling_session
(session_id,
 user_id,
 counseller_id,
 session_date,
 session_slot,
 status ,
is_requested,
created_date)
select
v_session_id,
v_user_id,
v_counseller_id,
v_session_date,
v_session_slot,
0,
v_is_requested,
v_current_timestamp;
 
p_out:=1;

update labbsc_dev.labbsc_dev_counseller_slot
set status=1,updated_date=v_current_timestamp
where counseller_user_id=v_counseller_id
and session_date=v_session_date
and session_slot=v_session_slot
and status =0;

update labbsc_dev.labbsc_dev_cart
set session_id=v_session_id
where cart_id=v_cart_id;

else

if v_is_rescheduled =1 then

update labbsc_dev.labbsc_dev_user_counselling_session
set prev_date =session_date,
prev_slot=session_slot,
session_date = v_session_date,
 session_slot = v_session_slot,
 is_rescheduled = v_is_rescheduled,
 before_48=null,
 before_1=null
where counseller_id=v_counseller_id
and user_id =v_user_id
and status=0
and session_id=v_session_id;

update labbsc_dev.labbsc_dev_counseller_slot
set status=1,updated_date=v_current_timestamp
where counseller_user_id=v_counseller_id
and session_date=v_session_date
and session_slot=v_session_slot
and status =0;

select schedule_json
from labbsc_dev.labbsc_dev_user_counselling_session
where session_id=v_session_id
into v_meet_link_info;

p_out:=1;
else
p_out:=3; ------ slot already occupied

end if;

if p_out =1 then
if v_is_requested=1 
then 
if  not exists(select 1 from labbsc_dev.labbsc_dev_counseller_slot 
			  where counseller_user_id =v_counseller_id
and session_date=v_session_date
and session_slot=v_session_slot) then
v_slot_id:=nextval('labbsc_dev.seq_labbsc_dev_counseller_slot_id');

insert into labbsc_dev.labbsc_dev_counseller_slot
(slot_id ,
 counseller_user_id ,
 session_date ,
 session_slot ,
 status ,
 created_date)
 select v_slot_id ,
 v_counseller_id ,
 v_session_date ,
 v_session_slot ,
 1 ,
 v_current_timestamp
 ;
 
 else
 p_out:=2; -----invalid request 
 end if;
 update labbsc_dev.labbsc_dev_user_slot_request
 set status=1
 where user_id=v_user_id
 and counseller_user_id=v_counseller_id
 and session_date=v_session_date
 and session_slot=v_session_slot
 and status=0;

end if;

end if;

end if;
end if;
if p_out is null
then
p_out:=0;

end if;

 
select '{"data":'||row_to_json(row)||'}'
		from (select v_session_id as session_id,
v_user_id as user_id,
v_counseller_id as counseller_id,
v_session_date as session_date,
v_session_slot as session_slot,
0 as status,
v_is_requested as is_requested,
v_is_rescheduled as is_rescheduled,
 v_user_email_id  as user_email,
v_counseller_email_id  as counseller_email,
v_counseller_name  as counseller_name,
v_user_name as user_name,
 v_first_name as first_name,
 v_last_name as last_name,
 v_meet_link_info as meet_link_info
) as row
into p_user_slot_json;
 
	
	
end;

 $$;


--
