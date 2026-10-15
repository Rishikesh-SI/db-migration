-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_mentor_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_mentor_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_mentor_slot(p_json jsonb, OUT p_out numeric, OUT p_mentor_slot_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
 
v_mentor_id numeric;
v_session_date date;
v_session_slot varchar(500);
v_module_name varchar(500);
v_session_name varchar(500);
v_current_timestamp timestamp := current_timestamp at time zone 'utc';
v_status numeric;
v_session_id numeric;
v_slot_id numeric;
v_slot_exists numeric;
v_session_slot_json jsonb;
i varchar(500);
v_slot varchar(500);

begin

select 
       p_json->>'mentor_id' ,
	   p_json->>'session_date' ,
	   p_json->>'session_slot_json' ,
	     p_json->>'session_name' ,
	   p_json->>'module_name'
 into
 v_mentor_id,
 v_session_date,
 v_session_slot_json,
 v_session_name,
 v_module_name
 
 ;
 

for i in (select  *
		  --- value->>'status' as status
		  from jsonb_array_elements_text(v_session_slot_json))
loop		
 /* select i->>'session_slot',
   i->>'status'
   into v_slot,
   v_status;*/

 
if not exists(select 1 from labbsc_dev.labbsc_dev_mentor_slot
where   mentor_id =v_mentor_id
and session_date=v_session_date
and module_name=v_module_name
and session_name=v_session_name
and session_slot=i ) 
then

raise notice '%',i ;
--select 1/0;
v_slot_id:=nextval('labbsc_dev.seq_labbsc_dev_mentor_slot_id');

insert into labbsc_dev.labbsc_dev_mentor_slot
(slot_id ,
 mentor_id ,
 session_date ,
 session_slot ,
 status ,
 module_name,
 session_name,
 created_date)
 select v_slot_id ,
 v_mentor_id ,
 v_session_date ,
 i  ,
 0,
 v_module_name,
 v_session_name,
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
 from  labbsc_dev.labbsc_dev_mentor_slot cs
where  cs.mentor_id=v_mentor_id	
and cs.session_date=v_session_date	
and cs.module_name=v_module_name
and cs.session_name=v_session_name
) as row
into v_session_slot_json;

select row_to_json(row)
		from (select 
v_mentor_id as mentor_id,
v_session_date as session_date,
 v_module_name as module_name,
v_session_name as session_name,			  
v_session_slot_json as session_slot_json
 
) as row
into p_mentor_slot_json;
end if;
	
	
end;
$$;


--
