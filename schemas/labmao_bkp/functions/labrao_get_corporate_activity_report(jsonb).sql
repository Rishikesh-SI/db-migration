-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_get_corporate_activity_report(jsonb)
-- Type: FUNCTION

-- Name: labrao_get_corporate_activity_report(jsonb); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_get_corporate_activity_report(p_json jsonb, OUT p_report_json jsonb) RETURNS jsonb
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
v_group_id varchar(500);
v_group_name varchar(500);
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
from labrao.labrao_corporate_activity_report
into
v_torownumber;
end if;

if v_user_id is not null then
begin
select group_id,
       group_name
	   from labrao.labrao_user_master
	   where external_user_id=v_user_id
	   and group_name <>'PhonePe'
	   into v_group_id,
	   v_group_name;
	  exception when no_data_found then 
	  null;
	  end;
end if;	  

if (v_distance_asc =1 or v_total_participation_asc=1 or v_funds_raised_asc=1 ) then 
 select array_to_json(array_agg(row))
 from (
	 
	 select  group_name,
 floor(distance) as distance,
 round(fund_raised) as fund_raised,
total_participation,
curr_rank,
 prev_rank,
 round(pledged_distance) as pledged_distance,
	 sl_no
	 from(
	 select tb.group_name,
 tb.distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
 tb.pledged_distance,
 row_number()over(order by case when coalesce(v_funds_raised_asc,0) =1 then coalesce(raised_amount,0)
					   when coalesce(v_total_participation_asc,0)=1 then coalesce(total_participation,0)
						when coalesce(v_distance_asc,0)=1 then coalesce(distance,0) 
						  end ) as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
		 where tb.group_id <>coalesce(v_group_id,'X')
   ) as tm
 where sl_no between v_fromrownumber and v_torownumber
	 union
	  select tb.group_name,
 floor(tb.distance) as distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
 round(tb.pledged_distance) as pledged_distance,
 0 as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
	 where tb.group_id=v_group_id
	 and tb.group_name =v_group_name
	 order by sl_no
	 ) as row
 into p_report_json;
  end if;
  
  if (v_distance_asc =0 or v_total_participation_asc=0 or v_funds_raised_asc=0 ) then 
 select array_to_json(array_agg(row))
 from (
	 
	 select  group_name,
 floor(distance) as distance,
round(fund_raised) as  fund_raised,
total_participation,
curr_rank,
 prev_rank,
 round(pledged_distance) as pledged_distance,
	 sl_no
	 from(
	 select tb.group_name,
 tb.distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
 tb.pledged_distance,
 row_number()over(order by case when coalesce(v_funds_raised_asc,1) =0 then coalesce(raised_amount,0)
					   when coalesce(v_total_participation_asc,1)=0 then coalesce(total_participation,0)
						when coalesce(v_distance_asc,1)=0 then coalesce(distance,0) 
						  end desc) as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
		  where tb.group_id <>coalesce(v_group_id,'X')
   ) as tm
 where sl_no between v_fromrownumber and v_torownumber
	 union
	  select tb.group_name,
floor(tb.distance) as distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
 round(tb.pledged_distance) as pledged_distance,
  0 as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
	 where tb.group_id=v_group_id
	 and tb.group_name =v_group_name
	  order by sl_no
	 ) as row
 into p_report_json;
  end if;
  
  
  
  if (v_distance_asc is null and  v_total_participation_asc is null and v_funds_raised_asc is null) then 
 select array_to_json(array_agg(row))
 from (
	 
	 select  group_name,
 floor(distance) as distance,
 round(fund_raised) as fund_raised,
total_participation,
curr_rank,
 prev_rank,
round(pledged_distance) as pledged_distance,
	 sl_no
	 from(
	 select tb.group_name,
 tb.distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
 tb.pledged_distance,
 row_number()over(order by tb.group_name) as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
		  where tb.group_id <>coalesce(v_group_id,'X')
   ) as tm
 where sl_no between v_fromrownumber and v_torownumber
	 union
	  select tb.group_name,
 floor(tb.distance) as distance,
tc.raised_amount as fund_raised,
tb.total_participation,
 tb.curr_rank,
 tb.prev_rank,
round(tb.pledged_distance) as pledged_distance,
 0 as sl_no
 from  labrao.labrao_corporate_activity_report tb
	  left join labrao.labrao_corporate_fund tc
	   on tc.group_name=tb.group_id
	 where tb.group_id=v_group_id
	 and tb.group_name =v_group_name
	  order by sl_no
	 ) as row
 into p_report_json;
  end if;
 
 end;
  $$;


--
