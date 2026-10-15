-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_get_my_journey_data()
-- Type: FUNCTION

-- Name: labrao_get_my_journey_data(); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_get_my_journey_data(OUT p_journey_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
v_total_distance numeric:=400714;
v_total_fund_raised numeric;---:=26603517;
v_total_registrations numeric;
v_total_smiles numeric;
begin

select raised_amount  ---+v_extra_amount
from labrao.labrao_overall_fund
into v_total_fund_raised;

 select count(1) 
from labrao.labrao_user_master
where payment_status =1
into v_total_registrations;
v_total_registrations:=v_total_registrations+4757;

v_total_smiles:=4*(v_total_registrations) + v_total_fund_raised + v_total_distance;

with user_max_run as (select max(distance) as max_distance,user_id
				 from labrao.labrao_user_activity_detail  
				  group by user_id
				 ),
				 user_max_run_date as
				 ( select user_id,distance,activity_date
					 from(
				 select bk.user_id,round(bk.distance) as distance,bk.activity_date,
					 row_number()over(partition by bk.user_id order by bk.activity_date asc ) as sl_no
					 from labrao.labrao_user_activity_detail bk
					 join user_max_run bb
					 on bb.user_id=bk.user_id
					 where bk.distance=bb.max_distance) kb
					 where kb.sl_no=1
				  ),
 
cte as (
select  tb.user_name as username,
	tb.user_id,
	tb.pledged_distance::numeric as pledgeddistance,
    round(tc.distance) as completeddistance, 
	tb.user_guid as guid,
	tb.bib_no as bibno,
	---tb.email_id,
case when tb.pledged_distance::numeric(10,2)<=tc.distance then 1 else 0 end as completedpledgeddistance,
	tb.created_date::date as startdate,
	'2020-09-13' as enddate,
	 v_total_distance as totalkms,
	v_total_fund_raised as totalfunds,
	v_total_smiles as smiles,
	tb.group_name,
	tb.category
	from labrao.labrao_user_master tb
	join labrao.labrao_user_activity_report tc
	on tc.user_id=tb.useR_id
	 where tb.category in ('Change Leader','Change Champion')
	and tc.distance>0
	and tb.payment_status=1
) 
select array_to_json(array_agg(row))
from (
select td.username,
td.completedpledgeddistance,
td.guid,
td.bibno,
 --td.email_id,
null as bibpath,
null as certificatepath,
td.pledgeddistance,
td.completeddistance,
td.startdate,
td.enddate,
td.totalkms,
td.totalfunds,
td.smiles,
round(tk.distance) as longestrundistance,
tk.activity_date as longestrundate,
	td.group_name,
	td.category,
case when tk.distance>=td.pledgeddistance  then 1 else 0 end as samedaycompleted
from cte as td
join user_max_run_date as tk
on tk.user_id=td.user_id
) as row
into p_journey_json;

end;
$$;


--
