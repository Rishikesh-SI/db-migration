-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_upd_badge_detail(numeric)
-- Type: FUNCTION

-- Name: labupstox_upd_badge_detail(numeric); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_upd_badge_detail(p_user_id numeric, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
 v_curr_date date:=current_date;
 v_days3 numeric;
 v_days5 numeric;
 v_days7 numeric;
begin

insert into labupstox.labupstox_user_badge_detail
(user_id,activity_date)
select p_user_id as user_id, activity_date
from labupstox.labupstox_activity_date  
where activity_date<=v_curr_date;

update labupstox.labupstox_user_badge_detail tb
set curr_activity_date=  tb.activity_date 
from (select distinct activity_date
	 from labupstox.labupstox_user_activity_detail
	 where user_id = p_user_id) as tc
	 where tb.activity_date=tc.activity_date;
	 
	  
update labupstox.labupstox_user_badge_detail as tb 
set last_activity_date=  case when (select count(1) from labupstox.labupstox_user_badge_detail as tc
	  where  curr_activity_date = tk.last_activity_date)  =0 then null else  tk.last_activity_date end   
  
from ( select  
	   activity_date,
	  lag( activity_date,1)over(order by  activity_date asc) as last_activity_date
	  from  labupstox.labupstox_activity_date  
	   where  activity_date<=v_curr_date
	 ) as tk
	 where tb.activity_date=tk.activity_date;
	 
	update labupstox.labupstox_user_badge_detail as tb 
set  first_activity_date=case when  last_activity_date is null  then  curr_activity_date end;
	 
 with cte as(
 select first_activity_date,curr_activity_date from labupstox.labupstox_user_badge_detail
	 where first_activity_date is not null
 ),
   cte2 as
 (select   tb.curr_activity_date,
 case when (tb.curr_activity_date is not null or
			tb.first_activity_date=tc.curr_activity_date
			)  
			then  tc.first_activity_date  end as abc
  from labupstox.labupstox_user_badge_detail tb
  left join cte tc
  on tc.first_activity_date<=tb.curr_activity_date
  order by tb.curr_activity_date),
    cte3 as
  (select curr_activity_date,abc,row_number()over(partition by curr_activity_date order by abc desc) rnk
  from cte2
    )
  update labupstox.labupstox_user_badge_detail as tb
  set first_activity_date= tc.abc
  from (select curr_activity_date,abc,rnk
  from cte3
	   where rnk =1) as tc
  where tc.curr_activity_date=tb.curr_activity_date
 ;	 
 
 with cte as(
  select first_activity_date,count(1) cnt
  from labupstox.labupstox_user_badge_detail
	 where first_activity_date is not null
 group by first_activity_date) 
 select sum(day_3), sum(day_5),sum(day_7)
 from (select  cnt/3 as day_3, cnt/5 as day_5, cnt/7 as day_7
		  from cte
	 ) as tb
  into v_days3,v_days5,v_days7;
 
---  raise notice '%,%,%',v_days3,v_days5,v_days7;
	 
	 update labupstox.labupstox_user_activity_report
	 set days_3=v_days3,days_5=v_days5,days_7=v_days7,
	 last_updated_badge_date=current_timestamp,
	 bronze_medal=case when distance>=50 then 1 else 0 end,
	 silver_medal=case when distance>=100 then 1 else 0 end,
	 gold_medal=case when distance>=150 then 1 else 0 end,
	 platinum_medal=case when distance>=200 then 1 else 0 end
	 where user_id=p_user_id;
	 
	 delete from labupstox.labupstox_user_badge_detail;
   
p_out:=1;
end;
$$;


--
