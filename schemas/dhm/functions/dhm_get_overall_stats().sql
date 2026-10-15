-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_overall_stats()
-- Type: FUNCTION

-- Name: dhm_get_overall_stats(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_overall_stats(OUT p_overall_stat_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_total_registrations numeric;
v_total_pledged_distance numeric;
v_total_fund_raised numeric;
v_total_distance_covered numeric(10,6);
begin

select count(1),sum(pledged_distance::numeric(20,2))
from dhm.dhm_user_master
where payment_status=1
into v_total_registrations,v_total_pledged_distance ;

select sum(distance)
from dhm.dhm_user_activity_detail
into v_total_distance_covered;
 

select row_to_json(row)
from (select 
	  v_total_registrations as total_participation,
	  v_total_pledged_distance as total_pledged_distance,
	  v_total_fund_raised as total_fund_raised,
	  coalesce(v_total_distance_covered,0) as total_distance_covered

) as row
into p_overall_stat_json;

end;
$$;


--
