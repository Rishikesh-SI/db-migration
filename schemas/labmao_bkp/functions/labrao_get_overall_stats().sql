-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_get_overall_stats()
-- Type: FUNCTION

-- Name: labrao_get_overall_stats(); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_get_overall_stats(OUT p_overall_stat_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
v_total_registrations numeric;
v_total_pledged_distance numeric;
v_total_fund_raised numeric:= 15583594;  ----31251468 ;
v_total_distance_covered numeric:=400714;
v_participation_slot numeric:=4757;
v_extra_amount numeric:=7400000;
begin

select count(1),  sum(CAST(coalesce(NULLIF(pledged_distance, ''), '0') AS numeric))
from labrao.labrao_user_master
where payment_status =1
into v_total_registrations,v_total_pledged_distance ;
 /*
select raised_amount  ---+v_extra_amount
from labrao.labrao_overall_fund
into v_total_fund_raised;

select sum(distance)
from labrao.labrao_user_activity_report
into v_total_distance_covered;*/

select row_to_json(row)
from (select 
	 --- v_total_registrations+v_participation_slot 
	  15415 as total_participation,
	  round(v_total_pledged_distance) as total_pledged_distance,
	  v_total_fund_raised as total_fund_raised,
	  coalesce(round(v_total_distance_covered),0) as total_distance_covered

) as row
into p_overall_stat_json;

end;
$$;


--
