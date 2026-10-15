-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_user_counseller_slot(jsonb)
-- Type: FUNCTION

-- Name: dhm_get_user_counseller_slot(jsonb); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_user_counseller_slot(p_input_json jsonb, OUT p_user_slot_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
v_session_date date;
v_couseller_id numeric;
begin
select p_input_json->>'session_date' 
	   into
	   v_session_date;
 
 execute '
select ''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
		from (select 
s.session_slot,
cs.status,
s.slot_id,
u.user_id as counseller_user_id,
u.display_name,
u.bio
 from dhm.dhm_slot s
 left join dhm.dhm_event_slot cs
on cs.session_slot=s.session_slot
and cs.session_date=$1
left join dhm.dhm_user u
on u.user_id=cs.event_user_id
where u.is_active=1
order by s.slot_id
) as row '
into p_user_slot_json
using v_session_date;
 
	
end;
$_$;


--
