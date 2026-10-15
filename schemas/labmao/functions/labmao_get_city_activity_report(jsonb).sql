-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_get_city_activity_report(jsonb)
-- Type: FUNCTION

-- Name: labmao_get_city_activity_report(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_get_city_activity_report(p_json jsonb, OUT p_report_json jsonb) RETURNS jsonb
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
v_city varchar(500);
v_state_name varchar(500);
v_category varchar(500);

/*

SELECT * from labmao.labmao_get_city_activity_report(
	
	'
	{
  "page_number": "1",
  "item_number": "10",
  "funds_raised_asc": "0",
  "total_participation_asc": "0",
  "distance_asc": "0",
  "user_id": "2161",
  "category": null
}
	'
)
*/
 begin
 
 
select  p_json->>'page_number',
        p_json->>'item_number',
		p_json->>'funds_raised_asc',
		p_json->>'total_participation_asc',
		p_json->>'distance_asc',
		p_json->>'user_id',
		p_json->>'category'
		
		into
		v_page_number,
		v_item_number,
		v_funds_raised_asc,
		v_total_participation_asc,
		v_distance_asc,
		v_user_id,
		v_category;
		
	 if v_page_number is not null then
		v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
		v_torownumber   := (v_page_number * v_item_number);
		
	else
		v_fromrownumber:=1;
		
		select count(1)
		from labmao.labmao_city_activity_report
		into v_torownumber;
		
	end if;

	if v_user_id is not null then
		begin
			select coalesce(replace(pledged_city,'-',null),city),
				   coalesce(replace(pledged_state,'-',null),state_name)
				   from labmao.labmao_user_master
				   where external_user_id=v_user_id
				   into v_city,
				   v_state_name;
				   
				exception when no_data_found then 
				null;

		end;	   
	   
	end if;	  
	
	if v_category is null then

		if (v_distance_asc =1 or v_total_participation_asc=1 or v_funds_raised_asc=1 ) then 

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
								from  labmao.labmao_city_state_fund 
								group by city,state_name)

			select array_to_json(array_agg(row))
			from ( select * from (select city,state_name,round(distance,2) as distance,
										total_participation,curr_rank,round(pledged_distance) as pledged_distance,
										round(raised_amount) as raised_amount,
								  case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
								  then 0 else curr_rank end sl_no
								  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,
										tc.raised_amount,row_number()over(order by case when coalesce(v_funds_raised_asc,0) =1 then coalesce(raised_amount,0)
																		  when coalesce(v_total_participation_asc,0)=1 then coalesce(total_participation,0)
																		  when coalesce(v_distance_asc,0)=1 then coalesce(distance,0)
																		  end  ) as curr_rank
										from  (select a.*,coalesce (b.distance,0) distance from 
											   (select distinct tb.city,tb.state_name,tb.total_participation,tb.pledged_distance
												from  labmao.labmao_city_activity_report tb)a
											   join (select city,state_name,sum(distance) distance from
													 labmao.labmao_city_activity_report
													 group by city,state_name ) b on a.city=b.city and  a.state_name = b.state_name) tb
										left join fund_raise tc
										on tc.state_name=tb.state_name
										and tc.city=tb.city
									   ) as tm
								 ) as tk
				  where (sl_no between  v_fromrownumber and v_torownumber)
				  or sl_no=0 
				  order by sl_no) as row
				  into p_report_json;

		 end if;

		if (v_distance_asc =0 or v_total_participation_asc=0 or v_funds_raised_asc=0 ) then  

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
							   from  labmao.labmao_city_state_fund group by city,state_name)

		select array_to_json(array_agg(row))
		from ( select * from (select city,state_name,round(distance,2) as distance,
							  total_participation,curr_rank,round(pledged_distance) as pledged_distance,
							  round(raised_amount) as raised_amount,case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
							  then 0 else curr_rank end sl_no
							  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,tc.raised_amount,
									row_number()over(order by case when coalesce(v_funds_raised_asc,1) =0 then coalesce(raised_amount,0)
													 when coalesce(v_total_participation_asc,1)=0 then coalesce(total_participation,0)
													 when coalesce(v_distance_asc,1)=0 then coalesce(distance,0)
													 end desc ) as curr_rank
									from  (select a.*,coalesce (b.distance,0) distance from 
											   (select distinct tb.city,tb.state_name,tb.total_participation,tb.pledged_distance
												from  labmao.labmao_city_activity_report tb)a
											   join (select city,state_name,sum(distance) distance from
													 labmao.labmao_city_activity_report
													 group by city,state_name ) b on a.city=b.city and  a.state_name = b.state_name) tb
									left join fund_raise tc 
									on tc.state_name=tb.state_name
									and tc.city=tb.city) as tm 
							 ) as tk
			  where  (sl_no between  v_fromrownumber and v_torownumber)
			  or sl_no=0
			  order by sl_no
			 ) as row
			into p_report_json;

		 end if;

		if (v_distance_asc is null and v_total_participation_asc is null and v_funds_raised_asc is null )
		then

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
							   from  labmao.labmao_city_state_fund 
							   group by city,state_name)

			select array_to_json(array_agg(row))
			from ( select * from (select city,state_name,round(distance,2) as distance,total_participation,
								  curr_rank,round(pledged_distance) as pledged_distance,
								  round(raised_amount) as raised_amount,case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
								  then 0 else curr_rank end sl_no
								  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,
										tc.raised_amount,row_number()over(order by coalesce(distance,0) desc ) as curr_rank
										from  (select a.*,coalesce (b.distance,0) distance from 
											   (select distinct tb.city,tb.state_name,tb.total_participation,tb.pledged_distance
												from  labmao.labmao_city_activity_report tb)a
											   join (select city,state_name,sum(distance) distance from
													 labmao.labmao_city_activity_report
													 group by city,state_name ) b on a.city=b.city and  a.state_name = b.state_name) tb
										left join fund_raise tc
										on tc.state_name=tb.state_name
										and tc.city=tb.city) as tm 
								 ) as tk
				  where  (sl_no between  v_fromrownumber and v_torownumber) or sl_no=0
				  order by sl_no
				 ) as row
				 into p_report_json;

		 end if;
		 
	else	 
		 
		 if (v_distance_asc =1 or v_total_participation_asc=1 or v_funds_raised_asc=1 ) then 

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
								from  labmao.labmao_city_state_fund 
								group by city,state_name)

			select array_to_json(array_agg(row))
			from ( select * from (select city,state_name,round(distance,2) as distance,
										total_participation,curr_rank,round(pledged_distance) as pledged_distance,
										round(raised_amount) as raised_amount,
								  case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
								  then 0 else curr_rank end sl_no
								  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,
										tc.raised_amount,row_number()over(order by case when coalesce(v_funds_raised_asc,0) =1 then coalesce(raised_amount,0)
																		  when coalesce(v_total_participation_asc,0)=1 then coalesce(total_participation,0)
																		  when coalesce(v_distance_asc,0)=1 then coalesce(distance,0)
																		  end  ) as curr_rank
										from  labmao.labmao_city_activity_report tb
										left join fund_raise tc
										on tc.state_name=tb.state_name
										and tc.city=tb.city
										where lower(tb.type) = lower(v_category)
								   ) as tm
								 ) as tk
				  where (sl_no between  v_fromrownumber and v_torownumber)
				  or sl_no=0 
				  order by sl_no) as row
				  into p_report_json;

	 	end if;
 
 
 
 
		if (v_distance_asc =0 or v_total_participation_asc=0 or v_funds_raised_asc=0 ) then  

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
							   from  labmao.labmao_city_state_fund group by city,state_name)

		select array_to_json(array_agg(row))
		from ( select * from (select city,state_name,round(distance,2) as distance,
							  total_participation,curr_rank,round(pledged_distance) as pledged_distance,
							  round(raised_amount) as raised_amount,case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
							  then 0 else curr_rank end sl_no
							  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,tc.raised_amount,
									row_number()over(order by case when coalesce(v_funds_raised_asc,1) =0 then coalesce(raised_amount,0)
													 when coalesce(v_total_participation_asc,1)=0 then coalesce(total_participation,0)
													 when coalesce(v_distance_asc,1)=0 then coalesce(distance,0)
													 end desc ) as curr_rank
									from  labmao.labmao_city_activity_report tb
									left join fund_raise tc 
									on tc.state_name=tb.state_name
									and tc.city=tb.city
									where lower(tb.type) = lower(v_category)
								   ) as tm 
							 ) as tk
			  where  (sl_no between  v_fromrownumber and v_torownumber)
			  or sl_no=0
			  order by sl_no
			 ) as row
			into p_report_json;

		 end if;
	 
		 if (v_distance_asc is null and v_total_participation_asc is null and v_funds_raised_asc is null )then

			with fund_raise as(select sum(raised_amount) as raised_amount,city,state_name
							   from  labmao.labmao_city_state_fund 
							   group by city,state_name)

			select array_to_json(array_agg(row))
			from ( select * from (select city,state_name,round(distance,2) as distance,total_participation,
								  curr_rank,round(pledged_distance) as pledged_distance,
								  round(raised_amount) as raised_amount,case when city=coalesce(v_city,'X') and state_name =coalesce(v_state_name,'X')
								  then 0 else curr_rank end sl_no
								  from (select tb.city,tb.state_name,tb.distance,tb.total_participation,tb.pledged_distance,
										tc.raised_amount,row_number()over(order by coalesce(distance,0) desc ) as curr_rank
										from  labmao.labmao_city_activity_report tb
										left join fund_raise tc
										on tc.state_name=tb.state_name
										and tc.city=tb.city
										where lower(tb.type) = lower(v_category)
									   ) as tm 
								 ) as tk
				  where  (sl_no between  v_fromrownumber and v_torownumber) or sl_no=0
				  order by sl_no
				 ) as row
				 into p_report_json;

		 end if;
		 
		 
 
 	end if;
 
 
 end;
$$;


--
