-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_ins_upd_corporate_report()
-- Type: FUNCTION

-- Name: labrao_ins_upd_corporate_report(); Type: FUNCTION; Schema: labrao; Owner: -
--

CREATE FUNCTION labrao.labrao_ins_upd_corporate_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
v_distance numeric(10,6);
v_pledged_distance numeric(10,6);
v_curr_rank numeric;
v_prev_rank numeric; 
i varchar(500);
v_total_participation numeric;
begin

insert into labrao.labrao_corporate_activity_report
	(activity_report_id,group_id,group_name,pledged_distance,total_participation)
	select
	nextval('labrao.seq_labrao_corporate_activity_report'),group_id,group_name,
	  pledged_distance,
      cnt
	from (  select   group_id ,group_name,
			 count(1) as cnt,
		   sum(CAST(coalesce(NULLIF(pledged_distance, ''), '0') AS numeric )) as pledged_distance
		from labrao.labrao_user_master as	 tb
		where not exists(select 1 from labrao.labrao_corporate_activity_report tk
						where tk.group_id=tb.group_id
						 )	
		  and tb.group_name is not null
		  and tb.group_id is not null
		  and tb.payment_status =1
		   group by group_id ,group_name  )as tc;			   
				   
				   

update  labrao.labrao_corporate_activity_report  as tc
 set
distance =coalesce(tb.distance,0) 
from  
(select sum(distance) as distance ,
 group_name
from labrao.labrao_user_activity_report
 group by group_name
) as tb
where  tc.group_name=tb.group_name;

update  labrao.labrao_corporate_activity_report  as tc
 set
prev_rank=coalesce(tb.curr_rank,0),
curr_rank=coalesce(tb.rnk,0)  ,
updated_date = current_timestamp
from  
(select distance,curr_rank,rank()over(order by distance desc) as rnk,group_name
from labrao.labrao_corporate_activity_report
) as tb
where  tc.group_name=tb.group_name;

p_out:=1;
end;
$$;


--
