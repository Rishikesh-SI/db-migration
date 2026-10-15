-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ins_upd_corporate_report()
-- Type: FUNCTION

-- Name: dhm_ins_upd_corporate_report(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ins_upd_corporate_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_distance numeric(10,4);
v_pledged_distance numeric(10,4);
v_curr_rank numeric;
v_prev_rank numeric; 
i varchar(500);
v_total_participation numeric;
begin

insert into dhm.dhm_corporate_activity_report
	(activity_report_id,group_name,total_participation)
	select
	nextval('dhm.seq_dhm_corporate_activity_report'),group_name,
	   cnt
	from (  select    group_name,
			 count(1) as cnt
		 from dhm.dhm_user_master as tb
		where 
		   tb.group_name is not null
		   and tb.payment_status =1
		   group by group_name  )as tc
		   where  group_name <> '';			   
				   
				 

update  dhm.dhm_corporate_activity_report  as tc
 set
distance =coalesce(tb.distance,0) 
from  
(select sum(distance) as distance ,
 group_name
from dhm.dhm_user_activity_detail
 group by group_name
) as tb
where  tc.group_name=tb.group_name;

 

p_out:=1;
end;
$$;


--
