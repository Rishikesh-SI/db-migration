-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_ins_upd_state_report()
-- Type: FUNCTION

-- Name: labirao_ins_upd_state_report(); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_ins_upd_state_report(OUT p_out numeric) RETURNS numeric
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

delete from labirao.labirao_state_activity_report;

 insert into labirao.labirao_state_activity_report
	(activity_report_id,state_name,pledged_distance,total_participation)
	select
	nextval('labirao.seq_labirao_state_activity_report'),state_name,
	  coalesce(pledged_distance,0),
      cnt
	from (  select   
			coalesce(replace(pledged_state,'-',null),state_name)  as state_name,count(1) as cnt,
		   sum(CAST(coalesce(NULLIF(pledged_distance, ''), '0') AS numeric )) as pledged_distance
		from labirao.labirao_user_master as	 tb
		where not exists(select 1 from labirao.labirao_state_activity_report tk
						where   tk.state_name=tb.state_name )	
		  and tb.state_name is not null
		  and tb.payment_status=1
		  group by coalesce(replace(pledged_state,'-',null),state_name)    )as tc;

update  labirao.labirao_state_activity_report  as tc
 set
distance =coalesce(tb.distance,0) 
from  
(select sum(distance) as distance ,
 coalesce(replace(pledged_state,'-',null),state_name) as state_name 
from labirao.labirao_user_activity_report
 group by coalesce(replace(pledged_state,'-',null),state_name) 
) as tb
where  tc.state_name=tb.state_name;
/*
update  labirao.labirao_state_activity_report  as tc
 set
prev_rank=coalesce(tb.curr_rank,0),
curr_rank=coalesce(tb.rnk,0) ,
updated_date=current_timestamp
from  
(select distance,curr_rank,rank()over(order by distance desc) as rnk,state_name
from labirao.labirao_state_activity_report
) as tb
where  tc.state_name=tb.state_name;*/

p_out:=1;
end;
$$;


--
