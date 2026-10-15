-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_mentor_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_mentor_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_mentor_slot(p_input_json jsonb, OUT p_mentor_slot_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
v_session_date date;
v_mentor_id numeric;
v_session_name varchar(500);
v_module_name varchar(500);
begin
select p_input_json->>'session_date',
       p_input_json->>'mentor_id',
	   p_input_json->>'session_name', 
	   p_input_json->>'module_name'
	   into
	   v_session_date,
	   v_mentor_id,
	   v_session_name,
	   v_module_name;
	   
	   
if v_module_name is not null then	   
 
 execute '
select ''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
		from (select 
s.session_slot,
cs.status
 from labbsc_dev.labbsc_dev_slot s
left join labbsc_dev.labbsc_dev_mentor_slot cs
on cs.session_slot=s.session_slot
and cs.mentor_id=$1
and cs.session_date=$2	
and cs.session_name=$3
and cs.module_name=$4
) as row '
into p_mentor_slot_json
using v_mentor_id,v_session_date,v_session_name,v_module_name;

else

	execute '
select ''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
		from (select 
s.session_slot,
cs.status
 from labbsc_dev.labbsc_dev_slot s
left join labbsc_dev.labbsc_dev_mentor_slot cs
on cs.session_slot=s.session_slot
and cs.mentor_id=$1
and cs.session_date=$2	
and cs.session_name=$3

) as row '
into p_mentor_slot_json
using v_mentor_id,v_session_date,v_session_name;

end if;
 
	
end;
$_$;


--
