-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_upd_badge_detail(text)
-- Type: FUNCTION

-- Name: labmao_upd_badge_detail(text); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_upd_badge_detail(p_email_id text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
 v_curr_date date:=current_date;
 v_days3 numeric;
 v_days5 numeric;
 v_days7 numeric;
 p_user_id numeric;
 v_last_badge_date timestamp;
 v_date timestamp;
 v_week_1 numeric;
 v_week_2 numeric;
  v_week_3 numeric;
 v_week_4 numeric;
begin
 

v_date:=current_timestamp - interval '2 hour';

select user_id,coalesce(last_updated_badge_date,v_date)
from labmao.labmao_user_activity_report
where   email_id=p_email_id
into p_user_id,v_last_badge_date;

if (coalesce(p_user_id,0)<>0 and v_last_badge_date<=v_date) then

insert into labmao.labmao_user_badge_detail
(user_id,activity_date)
select p_user_id as user_id, activity_date
from labmao.labmao_activity_date  
where activity_date<=v_curr_date;

update labmao.labmao_user_badge_detail tb
set curr_activity_date=  tb.activity_date 
from (select distinct activity_date
	 from labmao.labmao_user_activity_detail
	 where user_id = p_user_id) as tc
	 where tb.activity_date=tc.activity_date;
	 
	  
update labmao.labmao_user_badge_detail as tb 
set last_activity_date=  case when (select count(1) from labmao.labmao_user_badge_detail as tc
	  where  curr_activity_date = tk.last_activity_date)  =0 then null else  tk.last_activity_date end   
  
from ( select  
	   activity_date,
	  lag( activity_date,1)over(order by  activity_date asc) as last_activity_date
	  from  labmao.labmao_activity_date  
	   where  activity_date<=v_curr_date
	 ) as tk
	 where tb.activity_date=tk.activity_date;
	 
	update labmao.labmao_user_badge_detail as tb 
set  first_activity_date=case when  last_activity_date is null  then  curr_activity_date end;
	 
 with cte as(
 select first_activity_date,curr_activity_date from labmao.labmao_user_badge_detail
	 where first_activity_date is not null
 ),
   cte2 as
 (select   tb.curr_activity_date,
 case when (tb.curr_activity_date is not null or
			tb.first_activity_date=tc.curr_activity_date
			)  
			then  tc.first_activity_date  end as abc
  from labmao.labmao_user_badge_detail tb
  left join cte tc
  on tc.first_activity_date<=tb.curr_activity_date
  order by tb.curr_activity_date),
    cte3 as
  (select curr_activity_date,abc,row_number()over(partition by curr_activity_date order by abc desc) rnk
  from cte2
    )
  update labmao.labmao_user_badge_detail as tb
  set first_activity_date= tc.abc
  from (select curr_activity_date,abc,rnk
  from cte3
	   where rnk =1) as tc
  where tc.curr_activity_date=tb.curr_activity_date
 ;	 
 
 with cte as(
  select first_activity_date,count(1) cnt
  from labmao.labmao_user_badge_detail
	 where first_activity_date is not null
 group by first_activity_date) 
 select sum(day_3), sum(day_5),sum(day_7)
 from (select  cnt/3 as day_3, cnt/5 as day_5, cnt/7 as day_7
		  from cte
	 ) as tb
  into v_days3,v_days5,v_days7;
 
 
  with cte as  (
select  activity_date, week_no
	from labmao.labmao_activity_date 
),
cte_usr AS
(select  distinct activity_date
from labmao.labmao_user_activity_detail 
 where user_id=p_user_id
)
insert into labmao.labmao_user_week_activity
(user_id,week_no,activity_count )
select p_user_id,week_no,cnt
from (
select tb.week_no,count(1) as cnt
from cte tb
join cte_usr tc
on tc.activity_date=tb.activity_Date
group by tb.week_no) rn;

begin
select case when (select count(1) from labmao.labmao_user_week_activity
				  where week_no=1)>0 then 1 else 0 end,
case when  (select count(1) from labmao.labmao_user_week_activity
				  where week_no=2)>0 then 1 else 0 end,
case when (select count(1) from labmao.labmao_user_week_activity
				  where week_no=3)>0 then 1 else 0 end,
case when (select count(1) from labmao.labmao_user_week_activity
				  where week_no=4)>0 then 1 else 0 end

into v_week_1,v_week_2,v_week_3,v_week_4;
exception when no_data_found then
null;
 end;
---  raise notice '%,%,%',v_days3,v_days5,v_days7;
	 
	 update labmao.labmao_user_activity_report
	 set days_3=v_days3,days_5=v_days5,days_7=v_days7,
	 last_updated_badge_date=current_timestamp,
	 bronze_medal=case when distance>=50 then 1 else 0 end,
	 silver_medal=case when distance>=100 then 1 else 0 end,
	 gold_medal=case when distance>=150 then 1 else 0 end,
	 platinum_medal=case when distance>=200 then 1 else 0 end,
	 weeks_2= case when (coalesce(v_week_1,0)=1 and coalesce(v_week_2,0)=1)
	                or (coalesce(v_week_2,0)=1 and coalesce(v_week_3,0)=1)
						or (coalesce(v_week_3,0)=1 and coalesce(v_week_4,0)=1)
						then 1 else 0 end,
	 weeks_3= case when (coalesce(v_week_1,0)=1 and coalesce(v_week_2,0)=1 and coalesce(v_week_3,0)=1)
	                or (coalesce(v_week_2,0)=1 and coalesce(v_week_3,0)=1 and coalesce(v_week_4,0)=1)
					then 1 else 0 end,
	 weeks_4=case when (coalesce(v_week_1,0)=1 and coalesce(v_week_2,0)=1 and coalesce(v_week_3,0)=1
					   and coalesce(v_week_4,0)=1) then 1 else 0 end
	 where user_id=p_user_id;
	 
	 delete from labmao.labmao_user_badge_detail;
	  delete from labmao.labmao_user_week_activity;
   end if;
p_out:=1;
exception when no_data_found then 
null;

end;
$$;


--
