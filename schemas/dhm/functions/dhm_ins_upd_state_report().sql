-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ins_upd_state_report()
-- Type: FUNCTION

-- Name: dhm_ins_upd_state_report(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ins_upd_state_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_distance numeric(10,4);
v_pledged_distance numeric(10,4);
v_curr_rank numeric;
v_prev_rank numeric;
v_state_name varchar(500);
i varchar(500);
begin

 insert into dhm.dhm_state_activity_report
	(activity_report_id,state_name,total_participation)
	select
	nextval('dhm.seq_dhm_state_activity_report'),state_name,
	  
      cnt
	from (  select   
			 state_name ,count(1) as cnt
		 
		from dhm.dhm_user_master as	 tb
		where 
		   tb.state_name is not null
		  and tb.payment_status=1 
		  group by state_name    )as tc
		  where state_name <> '';

update  dhm.dhm_state_activity_report  as tc
 set
distance =coalesce(tb.distance,0) 
from  
(select sum(distance) as distance ,
 state_name 
from dhm.dhm_user_activity_detail
 group by  state_name)
  as tb
where  tc.state_name=tb.state_name;

 
p_out:=1;
end;
$$;


--
