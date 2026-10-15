-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_get_user_activity(numeric)
-- Type: FUNCTION

-- Name: upstox_get_user_activity(numeric); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_get_user_activity(p_user_id numeric, OUT p_user_activity_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 

begin

select array_to_json(array_agg(row))
from(
select  user_activity_id,
	activity_time,
	distance, 
	run_id,
	runner_id,
	datasource,
	activity_link,
	activity_date,
activity_start_time_epoch as activity_start_time
	
	from upstox.upstox_user_activity_detail
	where user_id=p_user_id
	order by activity_start_time_epoch desc
) as row
into p_user_activity_json;

end;
$$;


--
