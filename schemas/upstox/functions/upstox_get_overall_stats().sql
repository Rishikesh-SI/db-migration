-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_get_overall_stats()
-- Type: FUNCTION

-- Name: upstox_get_overall_stats(); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_get_overall_stats(OUT p_overall_stat_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
v_total_registrations numeric;
v_total_pledged_distance numeric;
v_total_fund_raised numeric;
v_total_distance_covered numeric(10,6);
begin

select count(1),sum(pledged_distance::numeric(20,2))
from upstox.upstox_user_master
where payment_status=1
and length(pledged_distance)>0 
into v_total_registrations,v_total_pledged_distance ;

select sum(distance)
from upstox.upstox_user_activity_report
into v_total_distance_covered;

select raised_amount
from upstox.upstox_overall_fund
into v_total_fund_raised;

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
