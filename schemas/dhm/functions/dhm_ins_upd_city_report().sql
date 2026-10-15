-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ins_upd_city_report()
-- Type: FUNCTION

-- Name: dhm_ins_upd_city_report(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ins_upd_city_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_distance numeric(10,4);
v_curr_rank numeric;
v_prev_rank numeric;
i varchar(500);
v_pledged_distance numeric(10,4);
v_total_participation numeric;
begin
 	 
			 
	insert into dhm.dhm_city_activity_report
	(activity_report_id,city,state_name,total_participation)
	select
	nextval('dhm.seq_dhm_city_activity_report'),city,state_name,
	
      cnt
	from (  select    city ,
		state_name,count(1) as cnt
		from dhm.dhm_user_master as	 tb
		where  
		     tb.state_name  is not null
		  and  tb.city  is not null
		  and tb.payment_status =1
		   group by city,
		  state_name   )as tc
		  where state_name <>''
		  and city <>'';
		 
 
update  dhm.dhm_city_activity_report  as tc
  set
distance =coalesce(tb.distance ,0) 

from  
(select sum(distance) as distance ,city ,
		state_name
  
from dhm.dhm_user_activity_detail
 group by city  ,
		 state_name
) as tb
where  tc.city=tb.city
and tc.state_name=tb.state_name;

 

p_out:=1;
end;
$$;


--
