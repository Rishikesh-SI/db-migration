-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_get_leaderboard_r(jsonb)
-- Type: FUNCTION

-- Name: labrao_get_leaderboard_r(jsonb); Type: FUNCTION; Schema: labrao; Owner: -
--

CREATE FUNCTION labrao.labrao_get_leaderboard_r(p_json jsonb, OUT p_leaderboard_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
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

v_race_category_query text := ' ';

v_gender_query text := ' ';

v_state_query text := ' ';

v_city_query text := ' ';

v_user_guid_query text:=' ';
p_data_null jsonb;
p_data_json_null jsonb;
p_itemnumber numeric:=10;
p_pagenumber numeric;
p_page_size numeric;
v_start_age numeric;
v_end_age numeric;
v_count numeric;
page_count numeric;
v_user_age_query  text := ' ';
v_bib_no text ;
v_search_query text := ' ';

begin
select  p_json->>'user_guid',p_json->>'page_count',p_json->>'page_size',p_json->>'race_category',p_json->>'state',
p_json->>'city',p_json->>'gender',p_json->>'startage',p_json->>'endage', p_json->>'bib_no'           
into v_user_guid,p_pagenumber,p_page_size,v_race_category_id,v_state_id,v_city_id,v_gender_id,v_start_age,
	v_end_age,v_bib_no;
				
				
				if v_race_category_id = 0 or v_race_category_id is  null then
				
					v_race_category_query := 'where ut.race_category_id in (1,2,3)
												and is_qualified =1 ';
					
					else 
					
					v_race_category_query := 'where ut.race_category_id = '|| v_race_category_id ||' 
												and is_qualified =1 ' ;
					
				
					
				end if;
				
				/*if v_city_id is not null then
				
					v_city_query :=  ' and u.city_id = $2';
					
				end if;
				
				if v_state_id is not null then
				
					v_state_query := ' and u.state_id= $3 ';

				end if;*/
				
				
				if   v_gender_id is not null  then
				
					v_gender_query := ' and u.gender= $4';
					
				end if;
				
				
				
				if   v_bib_no != '0' then
				
					if exists (select 1 from labrao.labrao_user_transaction
								 where bib_no::text = v_bib_no ) then
				
					v_search_query := ' and (ut.bib_no = '|| v_bib_no ||') ';
					
					else
					
					v_search_query := 'and upper(urc.user_name) like upper(''%'||v_bib_no||'%'' ) ';
					
					
					end if;
					
				end if;
									
				/*if v_start_age is not null and v_end_age is not null then
				
				 	v_user_age_query:= 'where a.age between '||v_start_age ||' and '|| v_end_age ;
					raise notice '%', v_user_age_query;
				else					
				      v_user_age_query:= ' ';
				end if;*/

	
				if (p_pagenumber=1) then

								v_from_number := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));

						  else

								v_from_number := p_page_size + ( (( (p_pagenumber-1) * p_itemnumber) - 
																  (p_itemnumber - 1)));

						  end if;

								v_to_number   := p_page_size + ( (p_pagenumber-1) * p_itemnumber);
	
	
					 
		execute  'select ''{"leader_board":''||jsonb_agg(tab)::text||'',"total_count":''||total_count||'',
		"page_count":''||page_count||'',"user_leader_board":null}'' 
			 	  from (select count(1) over() as total_count, case  when count(1) over() % '||p_page_size||'>1 then 
					  (count(1) over()/'||p_page_size||')+1 else count(1) over()/'||p_page_size||' end as page_count ,
						   a.bib_no,a.name,a.gender,a.state,a.city,a.time,a.distance,race_category,
						   row_number() over(order by user_name)as rn
					  from (select EXTRACT(year from age(current_timestamp::date,urc.date_of_birth::date)) as age, 
						          ut.bib_no,u.user_guid,u.user_full_name as name,u.gender as gender,s.name as state,
						          c.name as city,TO_CHAR((urc.actual_elapsed_time_in_seconds || '' second'')::interval, ''HH24:MI:SS'') as time,
								  urc.actual_elapsed_time_in_seconds,urc.actual_distance_in_meters as distance,urc.user_name,
								  urc.avg_pace as avg_speed,case ut.race_category_id when 1 then ''10''
								  												when 2 then ''21.1'' when 3 then ''42.2'' end as race_category
						   from labrao.labrao_web_user u
						   join labrao.labrao_user_race_challange urc
						   on u.user_guid=urc.user_guid
						   join labrao.labrao_user_transaction ut
						   on u.user_guid=ut.user_guid
						   join waf_master.waf_states s on u.state_id= s.state_id
						   join waf_master.waf_cities c on u.city_id= c.city_id ' 
						   || v_race_category_query 
						   || v_city_query
						   || v_state_query
						   || v_gender_query 
						   || v_search_query ||						   
						   ')a ' || v_user_age_query || '
					 )tab where rn between '||v_from_number||' and '||v_to_number||' 
					        group by total_count,page_count'
				     into p_data_json
					 using v_race_category_id,v_city_id,v_state_id,v_gender_id,v_start_age,v_end_age,v_bib_no ;

	
			
		if v_user_guid is not null	then
		
							 select row_to_json(row)
							from (select * from (select ut.bib_no,u.user_full_name as name,u.gender as gender,
														s.name as state,c.name as city,urc.actual_elapsed_time_in_seconds as time_1,
												 TO_CHAR((urc.actual_elapsed_time_in_seconds || ' second')::interval, 'HH24:MI:SS') as time,			
															   urc.actual_distance_in_meters as distance,
												 		urc.avg_pace as avg_speed,case ut.race_category_id when 1 then '10'
								  												when 2 then '21.1' when 3 then '42.2' end as race_category,
												 				urc.challanger_guid as guid
														from labrao.labrao_web_user u
														join labrao.labrao_user_race_challange urc
														on u.user_guid=urc.user_guid
														join labrao.labrao_user_transaction ut
														on u.user_guid=ut.user_guid
														join waf_master.waf_states s 
														on u.state_id= s.state_id
														join waf_master.waf_cities c 
														on u.city_id= c.city_id
												 		where u.user_guid=v_user_guid and is_qualified =1
														)a
										
									)row

						  into p_data;

			   end if;

	   
			if p_data is not null and p_data_json is not null then
			p_leaderboard_json:= jsonb_set(p_data_json,'{user_leader_board}',p_data,true);
			elsif p_data_json is null  and p_data is  null 
			then
			select '{"leader_board":null,"total_count":"0",
		                              "page_count":"0","user_leader_board":null}'
									  into  p_leaderboard_json;
			elsif p_data_json is null  and p_data is not null then			  
			select '{"leader_board":null,"total_count":"0",
		                              "page_count":"0","user_leader_board":null}'
									  into  p_data_json;
			p_leaderboard_json:= jsonb_set(p_data_json,'{user_leader_board}',p_data,true);						  
			else
			p_leaderboard_json:=p_data_json;
			end if;
						
end;

$_$;


--
