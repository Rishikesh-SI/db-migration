-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_ins_upd_session_request(jsonb)
-- Type: FUNCTION

-- Name: labbsc_ins_upd_session_request(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_ins_upd_session_request(p_json jsonb, OUT p_out numeric, OUT p_session_request_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 
v_user_slot_exists numeric;
v_user_id numeric;
v_counseller_id numeric;
v_session_date date;
v_session_slot varchar(500);
v_req_id numeric;
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
v_user_guid text;
v_user_name text;
v_user_email_id text;
v_counseller_name varchar(500);
v_counseller_email_id text;
v_first_name text;
v_last_name text;
v_cart_id numeric;
begin
select p_json->>'user_guid' ,
       p_json->>'counseller_id' ,
	   p_json->>'session_date' ,
	   p_json->>'session_slot' 
 into
 v_user_guid,
 v_counseller_id,
 v_session_date,
 v_session_slot
 ;
---raise notice '%',v_counseller_id;
select full_name,email_id 
from labbsc.labbsc_user 
where user_id=v_counseller_id
into v_counseller_name,v_counseller_email_id ;

select  user_full_name,email_id ,user_id,first_name,last_name
from labbsc.labbsc_web_user 
where user_guid=v_user_guid
into v_user_name,v_user_email_id,v_user_id ,v_first_name,v_last_name;

select max(cart_id)
from labbsc.labbsc_cart
where user_id=v_user_id
and activity_id=3
and  status=2
and counseller_id=v_counseller_id
and coalesce(session_id,0) =0 and coalesce(request_id,0) =0
into v_cart_id;

select count(1)
from labbsc.labbsc_user_slot_request
where user_id=v_user_id
and  counseller_user_id =v_counseller_id
and session_date=v_session_date
and session_slot=v_session_slot
into v_user_slot_exists;

if v_user_slot_exists =0 then
v_req_id:=nextval('labbsc.seq_labbsc_user_slot_request_id');

insert into   labbsc.labbsc_user_slot_request
(slot_request_id,
 counseller_user_id  ,
 user_id  ,
 session_date  ,
 session_slot ,
 status,
 created_date)
 select v_req_id,
 v_counseller_id,
 v_user_id,
 v_session_date,
 v_session_slot,
 0,
 v_current_timestamp;
 
 
update labbsc.labbsc_cart
set request_id=v_req_id
where cart_id=v_cart_id;
 
 p_out:=1;
 end if;
 
 if p_out =1 then
  select '{"data":'||row_to_json(row)||'}'
		from (select 
v_user_id as user_id,
v_counseller_id as counseller_id,
v_session_date as session_date,
v_session_slot as session_slot,
0 as status,
1 as is_requested,
 
 v_user_email_id  as user_email,
v_counseller_email_id  as counseller_email,
v_counseller_name  as counseller_name,
v_first_name as first_name,
v_last_name as last_name
) as row
into p_session_request_json;
 
 end if;
 exception when no_data_found then
 p_out:=2;
 --when others then 
--- p_out:=-1;
end;

 $$;


--
