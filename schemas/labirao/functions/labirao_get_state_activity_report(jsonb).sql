-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_state_activity_report(jsonb)
-- Type: FUNCTION

-- Name: labirao_get_state_activity_report(jsonb); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_state_activity_report(p_json jsonb, OUT p_report_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
  declare
  v_page_number numeric;
  v_item_number numeric;
  
  v_fromrownumber numeric;
v_torownumber numeric; 
v_user_id numeric;
v_funds_raised_asc numeric;
v_total_participation_asc numeric;
v_distance_asc numeric;
 
v_state_name varchar(500);
 begin
 
 
select  p_json->>'page_number',
        p_json->>'item_number',
		p_json->>'funds_raised_asc',
		p_json->>'total_participation_asc',
		p_json->>'distance_asc',
		p_json->>'user_id'
		into
		v_page_number,
		v_item_number,
		v_funds_raised_asc,
		v_total_participation_asc,
		v_distance_asc,
		v_user_id;
 if v_page_number is not null then
v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);
else
v_fromrownumber:=1;
select count(1)
from labirao.labirao_state_activity_report
into
v_torownumber;
end if;

if v_user_id is not null then
begin
select  
       coalesce(replace(pledged_state,'-',null),state_name)
	   from labirao.labirao_user_master
	   where external_user_id=v_user_id
	   into  
	   v_state_name;
	exception when no_data_found then 
	null;
	
end;	   
	   
end if;	  

if (v_distance_asc =1 or v_total_participation_asc=1 or v_funds_raised_asc=1 ) then  
with fund_raise as
(select sum(raised_amount) as raised_amount,state_name
from  labirao.labirao_city_state_fund 
 group by state_name
)
select array_to_json(array_agg(row))
 from ( 
	 select * from (
select 	  
	 state_name,
 round(distance) as distance,
 total_participation,
 curr_rank,
  round(pledged_distance) as pledged_distance,
	 round(raised_amount) as raised_amount,
	case when  state_name=coalesce(v_state_name,'X') then 0 else curr_rank end  sl_no
	 from (
	 
 select 
	 tb.state_name,
 tb.distance,
 tb.total_participation,
  
 tb.prev_rank,
 tb.pledged_distance,
	 tc.raised_amount ,
	   row_number()over(order by case when coalesce(v_funds_raised_asc,0) =1 then coalesce(raised_amount,0)
					   when coalesce(v_total_participation_asc,0)=1 then coalesce(total_participation,0)
						when coalesce(v_distance_asc,0)=1 then coalesce(distance,0) 
						  end  ) as curr_rank
 from  labirao.labirao_state_activity_report tb
	   left join fund_raise tc
	 on tc.state_name=tb.state_name
		 
	) as tm ) as tk
	  where  (sl_no between v_fromrownumber and v_torownumber) or sl_no=0
 
	 order by sl_no
 ) as row

 into p_report_json;
 
 end if;
 
 
 
 
if (v_distance_asc =0 or v_total_participation_asc=0 or v_funds_raised_asc=0 ) then  

with fund_raise as
(select sum(raised_amount) as raised_amount,state_name
from  labirao.labirao_city_state_fund 
 group by state_name
)
select array_to_json(array_agg(row))
 from ( 
select * from (
select 	  
	 state_name,
 round(distance) as distance,
 total_participation,
 curr_rank,
  round(pledged_distance) as pledged_distance,
	 round(raised_amount) as raised_amount,
	case when  state_name=coalesce(v_state_name,'X') then 0 else curr_rank end  sl_no
	 from (
	 
 select 
	 tb.state_name,
 tb.distance,
 tb.total_participation,
  
 tb.prev_rank,
 tb.pledged_distance,
	 tc.raised_amount ,
	   row_number()over(order by case when coalesce(v_funds_raised_asc,1) =0 then coalesce(raised_amount,0)
					   when coalesce(v_total_participation_asc,1)=0 then coalesce(total_participation,0)
						when coalesce(v_distance_asc,1)=0 then coalesce(distance,0)
						  end desc ) as curr_rank
 from  labirao.labirao_state_activity_report tb
	   left join fund_raise tc
	 on tc.state_name=tb.state_name
		 
	) as tm ) as tk
	  where  (sl_no between v_fromrownumber and v_torownumber) or sl_no=0
 
	 order by sl_no
 ) as row
into p_report_json;
 
 end if;
 
 
 
 
if (v_distance_asc is null and v_total_participation_asc is null and v_funds_raised_asc is null )
then

with fund_raise as
(select sum(raised_amount) as raised_amount,state_name
from  labirao.labirao_city_state_fund 
 group by state_name
)
select array_to_json(array_agg(row))
 from ( 
select * from (
select 	  
	 state_name,
 round(distance) as distance,
 total_participation,
 curr_rank,
  round(pledged_distance) as pledged_distance,
	 round(raised_amount) as raised_amount,
	case when  state_name=coalesce(v_state_name,'X') then 0 else curr_rank end  sl_no
	 from (
	 
 select 
	 tb.state_name,
 tb.distance,
 tb.total_participation,
  
 tb.prev_rank,
 tb.pledged_distance,
	 tc.raised_amount ,
	   row_number()over(order by coalesce(tb.distance,0) desc ) as curr_rank
 from  labirao.labirao_state_activity_report tb
	   left join fund_raise tc
	 on tc.state_name=tb.state_name
		 
	) as tm ) as tk
	  where  (sl_no between v_fromrownumber and v_torownumber) or sl_no=0
 
	 order by sl_no
 ) as row
 into p_report_json;
 
 end if;
 
 end;
  $$;


--
