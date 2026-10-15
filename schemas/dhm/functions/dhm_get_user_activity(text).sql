-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_user_activity(text)
-- Type: FUNCTION

-- Name: dhm_get_user_activity(text); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_user_activity(p_email_id text, OUT p_user_activity_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 

begin

select array_to_json(array_agg(row))
from(
select  activity_detail_id as user_activity_id,
    user_id,
	distance, 
	run_date as activity_date,
	run_start_time as activity_start_time,
	run_end_time,
	time_taken
 
	
	from dhm.dhm_user_activity_detail
	where -- user_id =p_user_id
	 email_id=  p_email_id  
	order by run_start_time desc
) as row
into p_user_activity_json;

end;
$$;


--
