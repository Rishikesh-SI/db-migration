-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_overall_stats()
-- Type: FUNCTION

-- Name: labirao_get_overall_stats(); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_overall_stats(OUT p_overall_stat_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
v_total_registrations numeric;
v_total_pledged_distance numeric;
v_total_fund_raised numeric;
v_total_distance_covered numeric(10,4);
v_participation_slot numeric:=4757;
v_extra_amount numeric:=7400000;
begin

select count(1),  sum(CAST(coalesce(NULLIF(pledged_distance, ''), '0') AS numeric))
from labirao.labirao_user_master
where payment_status =1
into v_total_registrations,v_total_pledged_distance ;

select raised_amount+v_extra_amount
from labirao.labirao_overall_fund
into v_total_fund_raised;

select sum(distance)
from labirao.labirao_user_activity_report
into v_total_distance_covered;

select row_to_json(row)
from (select 
	  v_total_registrations+v_participation_slot as total_participation,
	  round(v_total_pledged_distance) as total_pledged_distance,
	  v_total_fund_raised as total_fund_raised,
	  coalesce(round(v_total_distance_covered),0) as total_distance_covered

) as row
into p_overall_stat_json;

end;
$$;


--
