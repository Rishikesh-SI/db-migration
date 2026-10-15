-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_counseller_slot(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_counseller_slot(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_counseller_slot(p_input_json jsonb, OUT p_counseller_slot_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$ 
declare
v_session_date date;
v_couseller_id numeric;
begin
select p_input_json->>'session_date',
       p_input_json->>'counseller_id'
	   into
	   v_session_date,
	   v_couseller_id;
 
 execute '
select ''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
		from (select 
s.session_slot,
cs.status,
s.slot_id
 from labbsc_dev.labbsc_dev_slot s
left join labbsc_dev.labbsc_dev_counseller_slot cs
on cs.session_slot=s.session_slot
and cs.counseller_user_id=$1
and cs.session_date=$2	
order by s.slot_id
) as row '
into p_counseller_slot_json
using v_couseller_id,v_session_date;
 
	
end;

 $_$;


--
