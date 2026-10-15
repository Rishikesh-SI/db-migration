-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_mentor_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_mentor_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_mentor_slot(p_json jsonb, OUT p_out numeric, OUT p_user_slot_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
v_user_slot_exists numeric;
v_user_id numeric;
v_mentor_id numeric;
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
v_mentor_email_id text;
v_mentor_name text;
v_user_name text;
v_user_guid text;
v_first_name text;
v_last_name text;
v_meet_link_info jsonb;
v_module_name varchar(500);
v_session_name varchar(500);
v_merchant_name varchar(500);
begin
select p_json->>'user_guid' ,
       p_json->>'mentor_id' ,
	   p_json->>'session_date' ,
	   p_json->>'session_slot' ,
	   --p_json->>'is_rescheduled' ,
	  --- p_json->>'is_requested' ,
	   p_json->>'session_id',
	   p_json->>'session_name',
	   p_json->>'module_name'
		  
 into
 v_user_guid,
 v_mentor_id,
 v_session_date,
 v_session_slot,
--- v_is_rescheduled,
 ---v_is_requested,
 v_session_id,
 v_session_name,
 v_module_name
  ;
 
 
begin
select full_name,email_id 
from labbsc_dev.labbsc_dev_user 
where user_id=v_mentor_id
into v_mentor_name,v_mentor_email_id ;

select  user_full_name,email_id ,user_id,first_name,last_name
from labbsc_dev.labbsc_dev_web_user 
where user_guid=v_user_guid
into v_user_name,v_user_email_id,v_user_id,v_first_name,v_last_name ;

exception when others then
p_out:=-1;

end;

 
 if p_out is null then
select count(1)
from  labbsc_dev.labbsc_dev_user_mentor_session
where user_id=v_user_id
and mentor_id =v_mentor_id
and status =0
and module_name=v_module_name
and session_name=v_session_name
into v_user_slot_exists;

select count(1)
from  labbsc_dev.labbsc_dev_mentor_slot
where   mentor_id =v_mentor_id
and session_date=v_session_date
and session_slot=v_session_slot
and module_name=v_module_name
and session_name=v_session_name
and status=0
into v_slot_exists;

if (v_user_slot_exists =0  and v_slot_exists >0) then
 
v_session_id:= nextval('labbsc_dev.seq_labbsc_dev_session_id');
 
insert into labbsc_dev.labbsc_dev_user_mentor_session
(session_id,
 user_id,
 mentor_id,
 session_date,
 session_slot,
 status ,
is_requested,
created_date,
  module_name ,
  session_name )
select
v_session_id,
v_user_id,
v_mentor_id,
v_session_date,
v_session_slot,
0,
v_is_requested,
v_current_timestamp,
v_module_name ,
v_session_name;
 
p_out:=1;

update labbsc_dev.labbsc_dev_mentor_slot
set status=1,updated_date=v_current_timestamp
where mentor_id=v_mentor_id
and session_date=v_session_date
and session_slot=v_session_slot
and module_name=v_module_name
and session_name=v_session_name
and status =0;

else
 
p_out:=3; ------ slot already occupied

end if;

 end if; 
 
 
 select da.merchant_name into v_merchant_name from labbsc_dev.labbsc_dev_user_mentor_mapping um 
 left join labbsc_dev.labbsc_dev_cart c on um.cart_id=c.cart_id
 left join labbsc_dev.labbsc_dev_journey_activity da on c.activity_id = da.activity_id 
 where c.user_id = v_user_id and um.mentor_id = v_mentor_id;
 
 

 
select '{"data":'||row_to_json(row)||'}'
		from (select v_session_id as session_id,
v_user_id as user_id,
v_mentor_id as mentor_id,
v_session_date as session_date,
v_session_slot as session_slot,
0 as status,
--v_is_requested as is_requested,
--v_is_rescheduled as is_rescheduled,
 v_user_email_id  as user_email,
v_mentor_email_id  as mentor_email,
v_mentor_name  as mentor_name,
v_user_name as user_name,
 v_first_name as first_name,
 v_last_name as last_name,
 v_meet_link_info as meet_link_info,
 v_module_name as module_name,
 v_session_name as session_name	,
  v_merchant_name as merchant_name			  
) as row
into p_user_slot_json;
 
	
	
end;
$$;


--
