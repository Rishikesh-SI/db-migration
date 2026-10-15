-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ins_upd_counseller_slot(jsonb)
-- Type: FUNCTION

-- Name: dhm_ins_upd_counseller_slot(jsonb); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ins_upd_counseller_slot(p_json jsonb, OUT p_out numeric, OUT p_counseller_slot_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
 
v_event_id numeric;
v_session_date date;
v_session_slot varchar(500);
 
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
v_status numeric;
v_session_id numeric;
v_slot_id numeric;
v_slot_exists numeric;
v_session_slot_json jsonb;
i varchar(500);
begin

select 
       p_json->>'counseller_id' ,
	   p_json->>'session_date' ,
	   p_json->>'session_slot_json' 
 into
 v_event_id,
 v_session_date,
 v_session_slot_json
 
 ;
 

for i in (select * from jsonb_array_elements_text(v_session_slot_json))
loop		
 

---raise notice '%',i;
 
if not exists(select 1 from dhm.dhm_event_slot
where   event_user_id =v_event_id
and session_date=v_session_date
and session_slot=i) 
then
v_slot_id:=nextval('dhm.seq_dhm_event_slot_id');

insert into dhm.dhm_event_slot
(slot_id ,
 event_user_id ,
 session_date ,
 session_slot ,
 status ,
 created_date)
 select v_slot_id ,
 v_event_id ,
 v_session_date ,
 i ,
 0 ,
 v_current_timestamp
 ;
  
 end if;

end loop;
 p_out =1;
 
if p_out =1
then

select array_to_json(array_agg(row))
		from (select 
cs.session_slot,
cs.status
 from  dhm.dhm_event_slot cs
where  cs.event_user_id=v_event_id	
and cs.session_date=v_session_date			  
) as row
into v_session_slot_json;

select row_to_json(row)
		from (select 
v_event_id as counseller_id,
v_session_date as session_date,
v_session_slot_json as session_slot_json
 
) as row
into p_counseller_slot_json;
end if;
	
	
end;
$$;


--
