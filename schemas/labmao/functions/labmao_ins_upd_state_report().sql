-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_ins_upd_state_report()
-- Type: FUNCTION

-- Name: labmao_ins_upd_state_report(); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_ins_upd_state_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_distance numeric(10,4);
v_pledged_distance numeric;
v_curr_rank numeric;
v_prev_rank numeric;
v_state_name varchar(500);
i varchar(500);
begin

	delete from labmao.labmao_state_activity_report;

	     insert into labmao.labmao_state_activity_report
		(activity_report_id,state_name,pledged_distance,total_participation,type)
		select
		nextval('labmao.seq_labmao_state_activity_report'),state_name,
		  coalesce(pledged_distance,0),
		  cnt,type
			from (  
				     select distinct a.*,b.type from		
					(select   coalesce(replace(pledged_state,'-',null),state_name)  as state_name,count(1) as cnt,
				              ROUND(sum(CAST(coalesce(NULLIF(regexp_replace(pledged_distance,'\D','','g'), ''), '0') AS numeric )),4 )as pledged_distance
				     from labmao.labmao_user_master as	 tb
				     where not exists(select 1 from labmao.labmao_state_activity_report tk
								where   tk.state_name=tb.state_name )	
				    and tb.state_name is not null
				    and tb.payment_status=1
				    group by coalesce(replace(pledged_state,'-',null),state_name)  ) as a
		  			left join labmao.labmao_user_activity_detail b on a.state_name = b.state_name  
			 
			 
			 )as tc;
			  

	update  labmao.labmao_state_activity_report  as tc
	 set
	distance =coalesce(tb.distance,0) 
	from  
	(select sum(distance) as distance ,
	 coalesce(replace(state_name,'-',null),state_name) as state_name ,
	 type
	from labmao.labmao_user_activity_detail
	 group by coalesce(replace(state_name,'-',null),state_name) ,type
	) as tb
	where  tc.state_name=tb.state_name
	and tc.type=tb.type;
/*
update  labmao.labmao_state_activity_report  as tc
 set
prev_rank=coalesce(tb.curr_rank,0),
curr_rank=coalesce(tb.rnk,0) ,
updated_date=current_timestamp
from  
(select distance,curr_rank,rank()over(order by distance desc) as rnk,state_name
from labmao.labmao_state_activity_report
) as tb
where  tc.state_name=tb.state_name;*/

p_out:=1;
end;
$$;


--
