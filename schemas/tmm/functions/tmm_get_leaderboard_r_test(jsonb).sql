-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_leaderboard_r_test(jsonb)
-- Type: FUNCTION

-- Name: tmm_get_leaderboard_r_test(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_leaderboard_r_test(p_json jsonb, OUT p_leaderboard_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid text;
v_from_number numeric;
v_to_number numeric;
p_data_json jsonb;
p_data jsonb;
v_race_category_id numeric;
v_city_id numeric;
v_state_id numeric;
v_gender_id varchar(10000);
v_query text := ' ';
v_user_guid_query text:=' ';
p_data_null jsonb;
p_data_json_null jsonb;
p_itemnumber numeric:=4;
p_pagenumber numeric;
p_page_size numeric;

v_count numeric;
page_count numeric;
begin
select  p_json->>'user_guid',p_json->>'page_count',p_json->>'page_size',p_json->>'race_category',p_json->>'state',
p_json->>'city',p_json->>'gender'    
into v_user_guid,p_pagenumber,p_page_size,v_race_category_id,v_state_id,v_city_id,v_gender_id;

/*select * from 
(select row_number() over(order by actual_elapsed_time_in_seconds) as slno, urc.* 

                        from tmm.tmm_user_race_challange urc ) a  limit 5;*/
				if v_race_category_id is not null and v_state_id is not null and v_city_id is not null and v_gender_id is not null 
				then
					v_query:= ' where u.race_category_id= '|| v_race_category_id||
							  ' and u.city_id= '||v_city_id||' 
								and u.state_id= '||v_state_id||
								'and u.gender= '''||v_gender_id||'''';
				elsif v_race_category_id is not null 
				then 
					 v_query:=' where u.race_category_id= '|| v_race_category_id||'';
				elsif v_city_id is not null 
				then
					 v_query:=' where u.city_id= '|| v_city_id||'';
				elsif v_state_id is not null 
				then
					 v_query:=' where u.state_id= '|| v_state_id||'';
				elsif v_gender_id is not null and v_gender_id !=''
				then
					 v_query:=' where u.gender= '''||v_gender_id||'''';
				else
					v_query:=' ';
				end if;
				
				
	
				if  v_user_guid in (select a.user_guid from  
									(select user_guid,actual_elapsed_time_in_seconds,
									 dense_rank() over(order by actual_elapsed_time_in_seconds) as rank 
									 from tmm.tmm_user_race_challange)a 
									where a.rank between v_from_number and v_to_number ) then
				v_user_guid_query:= ' where a.user_guid !='''||v_user_guid||'''';
				else
				v_user_guid_query:= ' ';
				end if;

	--raise notice 'v_query:%',v_query;
	--raise notice 'v_user_guid_query:%',v_user_guid_query;
	--select 1/0;
	
				if (p_pagenumber=1) then

								v_from_number := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));

						  else

								v_from_number := p_page_size + ( (( (p_pagenumber-1) * p_itemnumber) - 
																  (p_itemnumber - 1)));

						  end if;

								v_to_number   := p_page_size + ( (p_pagenumber-1) * p_itemnumber);
	/*raise notice 'v_to_number:%',v_to_number;
	raise notice 'v_from_number:%',v_from_number;
	select 1/0;
	*/
	/*v_from_number := p_pagenumber;
	v_to_number   := p_page_size;*/
	--select count(1) into v_count from tmm.tmm_user_race_challange;
	--page_count:=ceil(v_count/10);
	
	/*raise notice 'v_count:%',v_count;
	raise notice 'page_count:%',page_count;
	select 1/0;
	*/

			/* execute 'select ''{"leader_board":''||jsonb_agg(tab)::text||''}'' 
					  from( select a.cnt,a.bib_no,a.name,a.gender,a.state,a.city,a.time,a.rank
							from ( select count(1) over() as cnt,ut.bib_no,u.user_guid,u.user_full_name as name,u.gender as gender,
										  s.name as state,c.name as city,urc.actual_elapsed_time_in_seconds as time,
										  row_number() over(order by urc.actual_elapsed_time_in_seconds )as rn,
										  dense_rank() over(order by urc.actual_elapsed_time_in_seconds ) as rank 
								   from tmm.tmm_web_user u
									join tmm.tmm_user_race_challange urc
									on u.user_guid=urc.user_guid
									join tmm.tmm_user_transaction ut
									on u.user_guid=ut.user_guid
									join waf_master.waf_states s on u.state_id= s.state_id
									join waf_master.waf_cities c on u.city_id= c.city_id '|| v_query ||
								 ' group by ut.bib_no,u.user_guid,u.user_full_name ,u.gender ,
										  s.name ,c.name ,urc.actual_elapsed_time_in_seconds)a
						  where a.rn between '||v_from_number||' and '||v_to_number||'
							'||v_user_guid_query||
					')tab'
					 into p_data_json;*/
					 
					 
					 
		execute  'select ''{"leader_board":''||jsonb_agg(tab)::text||'',"total_count":''||total_count||'',
		"page_count":''||page_count||'',"user_leader_board":null}'' 
			 	  from (select a.total_count,a.page_count, a.bib_no,a.name,a.gender,a.state,a city,a.time,a.rn,a.rank  
					  from(select count(1) over() as total_count, case  when count(1) over() % '||p_page_size||'=1 then 
					  (count(1) over()/'||p_page_size||')+1
						                                                else count(1) over()/'||p_page_size||' end as page_count, 
						          ut.bib_no,u.user_guid,u.user_full_name as name,u.gender as gender,s.name as state,
						          c.name as city,urc.actual_elapsed_time_in_seconds as time,
									  row_number() over(order by urc.actual_elapsed_time_in_seconds )as rn,
									  dense_rank() over(order by urc.actual_elapsed_time_in_seconds ) as rank 
						   from tmm.tmm_web_user u
						   join tmm.tmm_user_race_challange urc
						   on u.user_guid=urc.user_guid
						   join tmm.tmm_user_transaction ut
						   on u.user_guid=ut.user_guid
						   join waf_master.waf_states s on u.state_id= s.state_id
						   join waf_master.waf_cities c on u.city_id= c.city_id ' || v_query ||
								 ')a'||v_user_guid_query||'  
					 )tab where rn between '||v_from_number||' and '||v_to_number||' 
					        group by total_count,page_count'
				     into p_data_json;

			--select  p_data_json->-'leader_board'->>'cnt' into v_count;
			
	--raise notice 'p_data_json:%',p_data_json;
	--raise notice 'v_count:%',v_count;
	--	select 1/0;
	
	
		if v_user_guid is not null	then
		if  v_user_guid in (select a.user_guid from  
						(select user_guid,actual_elapsed_time_in_seconds,
                         row_number() over(order by actual_elapsed_time_in_seconds) as rn 
                         from tmm.tmm_user_race_challange)a 
						where a.rn between v_from_number and v_to_number ) then	
		             select row_to_json(row)
					from (select * from (select ut.bib_no,u.user_guid,u.user_full_name as name,u.gender as gender,
													   s.name as state,c.name as city,urc.actual_elapsed_time_in_seconds as time,
													   row_number() over(order by urc.actual_elapsed_time_in_seconds )as rn,
													   dense_rank() over(order by urc.actual_elapsed_time_in_seconds ) as rank 
												from tmm.tmm_web_user u
												join tmm.tmm_user_race_challange urc
												on u.user_guid=urc.user_guid
												join tmm.tmm_user_transaction ut
												on u.user_guid=ut.user_guid
												join waf_master.waf_states s 
												on u.state_id= s.state_id
												join waf_master.waf_cities c 
												on u.city_id= c.city_id
												)a
                                where a.user_guid=v_user_guid
							)row

			      into p_data;
	   end if;
	   end if;
			if p_data is not null then
			p_leaderboard_json:= jsonb_set(p_data_json,'{user_leader_board}',p_data,true);
			else
			p_leaderboard_json:=p_data_json;
			end if;
				/*if p_data is null then
				select '{"user_leader_board":'||jsonb_agg(tab)::text||'}' 
							  from(select )tab 
				 into p_data_null;
				p_leaderboard_json:= p_data_json || p_data_null;
				elsif p_data_json is null then
				 select '{"leader_board":'||jsonb_agg(tab)::text||'}' 
							  from(select )tab into p_data_json_null;
				p_leaderboard_json:= p_data|| p_data_json_null;
				else
				p_leaderboard_json:= p_data_json || p_data;
				end if;*/
   
   --raise notice 'p_leaderboard_json:%',p_leaderboard_json;
	--select 1/0;
	/*else
	select '{"leader_board":['||string_agg(row_to_json(row)::text,',')||']}'
    from (select * from (select ut.bib_no,
				   u.user_full_name as name,u.gender as gender,s.name as state,c.name as city,
	urc.actual_elapsed_time_in_seconds as time,row_number() 
	over(order by urc.actual_elapsed_time_in_seconds ) as rank from tmm.tmm_web_user u
	join tmm.tmm_user_race_challange urc
	on u.user_guid=urc.user_guid
	join tmm.tmm_user_transaction ut
	on u.user_guid=ut.user_guid
	join waf_master.waf_states s on u.state_id= s.state_id
	join waf_master.waf_cities c on u.city_id= c.city_id
						where ut.race_category_id=v_race_category_id and u.city_id=v_city_id and u.state_id=v_state_id
	and u.gender=v_gender_id) a
	where a.rank between v_from_number and v_to_number
        )row
	into p_leaderboard_json;
	
	
	
 
 
	
	end if;*/
    
end;

$$;


--
