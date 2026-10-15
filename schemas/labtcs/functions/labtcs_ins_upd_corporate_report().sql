-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_upd_corporate_report()
-- Type: FUNCTION

-- Name: labtcs_ins_upd_corporate_report(); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_upd_corporate_report(OUT p_out numeric) RETURNS numeric
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

insert into labtcs.labtcs_corporate_activity_report
	(activity_report_id,group_name,total_participation)
	select
	nextval('labtcs.seq_labtcs_corporate_activity_report'),group_name,
	   cnt
	from (  select    group_name,
			 count(1) as cnt
		 from labtcs.labtcs_user_master as tb
		where 
		   tb.group_name is not null
		   and tb.payment_status =1
		   group by group_name  )as tc
		   where  group_name <> '';			   
				   
				 

update  labtcs.labtcs_corporate_activity_report  as tc
 set
distance =coalesce(tb.distance,0) 
from  
(select sum(distance) as distance ,
 group_name
from labtcs.labtcs_user_activity_detail
 group by group_name
) as tb
where  tc.group_name=tb.group_name;

 

p_out:=1;
end;
$$;


--
