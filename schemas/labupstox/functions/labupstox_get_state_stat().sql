-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_state_stat()
-- Type: FUNCTION

-- Name: labupstox_get_state_stat(); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_state_stat(OUT p_state_stat_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
v_total_registrations numeric;
v_total_pledged_distance numeric;
v_total_fund_raised numeric;
v_total_distance_covered numeric(10,6);
begin
 

with reg as(
select count(1) as reg_count,sum(pledged_distance::numeric(10,4)) as pledged_distance,state_name
from labupstox.labupstox_user_master
where payment_status=1
group by state_name ),
fund_raise as
(select sum(raised_amount) as raised_amount,state_name
from  labupstox.labupstox_city_state_fund 
 group by state_name
)
select  array_to_json(array_agg(row))
from (
select tb.state_name,tc.reg_count,tc.pledged_distance,
td.raised_amount
from labupstox.labupstox_state_master tb
left join reg tc
on tc.state_name=tb.state_name
left join fund_raise td
on td.state_name=tb.state_name) as row
into p_state_stat_json;

 

end;
$$;


--
