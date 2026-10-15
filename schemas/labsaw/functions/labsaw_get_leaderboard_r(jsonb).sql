-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_leaderboard_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_get_leaderboard_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_leaderboard_r(p_json jsonb, OUT p_leaderboard_json jsonb) RETURNS jsonb
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
v_user_json jsonb;
v_pollidarr numeric[];
v_asset_type_id numeric :=6;
p_entityrole_mapid numeric[];
p_entityrole_mapid1 numeric[];
v_ent_count numeric;
v_entity_id text;
v_poll_id numeric;
v_str_date text;
v_date date;
v_asset_type_id1 numeric;
	v_asset_id character varying;
	v_entity_role_map_id numeric;

begin
select  p_json->>'user_guid',p_json->>'page_count',p_json->>'page_size',p_json->>'entity_id'
,p_json->>'poll_id',p_json->>'date',p_json->>'asset_type_id',p_json->>'asset_id'
into v_user_guid,p_pagenumber,p_itemnumber,v_entity_id,v_poll_id,v_str_date,v_asset_type_id1,v_asset_id;

v_from_number := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_to_number   := (p_pagenumber * p_itemnumber);

raise notice 'date value %', v_str_date;
raise notice '% %',v_from_number,v_to_number;

--p_entityrole_mapid:=array[23928];
v_ent_count:=1;

-------

    p_entityrole_mapid1:=(SELECT string_to_array(v_entity_id,','))::int[];
	
	raise notice 'p_entityrole_mapid1 % ',p_entityrole_mapid1;
	 
	 --p_entityrole_mapid1:=array_append(p_entityrole_mapid1,p_entityrole_mapid);
	 
	 select entity_role_map_id
	 into v_entity_role_map_id
     from labsaw.labsaw_entity_role_map
	 where entity_role_id = (select entity_role_id
	 from labsaw.labsaw_asset_type
	 where asset_type_id=v_asset_type_id1)
	 and source_object_id=v_asset_id;
	 
	 p_entityrole_mapid:=array_append(p_entityrole_mapid1,v_entity_role_map_id);
	 
	-- raise notice 'v_entity_role_map_id % ',v_entity_role_map_id;
	 
	-- raise notice 'p_entityrole_mapid % ',p_entityrole_mapid;

-------

--p_entityrole_mapid:=array[v_entity_id];

if v_str_date!='' then

	v_date:=v_str_date::date;
	select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labsaw.labsaw_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
						  and    p.start_date::date=v_date
                          and    exists(select 1
                                        from   labsaw.labsaw_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id)
                                        --having count(1) = v_ent_count)
                         ) a
                  where  a.rno between 1 and 100
                 )
                  into   v_pollidarr;	

--raise notice 'poll array %', v_pollidarr;				  
				  

else

 select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labsaw.labsaw_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          and    exists(select 1
                                        from   labsaw.labsaw_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id)
                                        --having count(1) = v_ent_count)
                          -- limit  2
                         ) a
                  where  a.rno between 1 and 100
                 )
                  into   v_pollidarr;
				 raise notice 'v_pollidarr % ',v_pollidarr; 
end if;

--select 1/0;
select 
'{"leader_board":'||jsonb_agg(row)::text||',
"total_count":'||cnt||',
"page_count":'||page_cnt||'}'
into p_leaderboard_json
from (
select * from (	
select  
	count(1) over() as cnt,
	tot_points as total_points,first_name,last_name,b.user_id,
	case  when count(1) over() % p_itemnumber>1 then
	 ceil((count(1) over()/p_itemnumber)) else ceil(count(1) over()/p_itemnumber) end as page_cnt ,
row_number() OVER ( 
		 ORDER BY tot_points desc,tab.user_id ) as rn,		 
(case when tot_points !=0
             then RANK() over ( order by tot_points desc) 
        else 0
        end)	as rank	 
from (
select  user_id,coalesce(sum(total_coins),0) as tot_points
from labsaw.labsaw_user_poll_response
where   (total_coins is not null or total_coins !=0) and is_active is null
and  poll_id in(select poll_id from   unnest(v_pollidarr) U(poll_id))
group by user_id
)tab
join labsaw.labsaw_web_user b on tab.user_id=b.user_id
	) tab2 where rn between v_from_number and  v_to_number 
)row 
group by cnt,page_cnt;
	
	
	if v_user_guid is not null then 
	select to_jsonb(tab2) into v_user_json
	from (
select  
	 user_guid,
	tot_points as total_points,first_name,last_name,b.user_id, 
(case when tot_points !=0
             then RANK() over ( order by tot_points desc) 
        else 0
        end) as rank		 
from (
select  user_id,coalesce(sum(total_coins),0) as tot_points
from labsaw.labsaw_user_poll_response 
where   (total_coins is not null or total_coins !=0) and is_active is null
and  poll_id in(select poll_id from   unnest(v_pollidarr) U(poll_id))	
group by user_id
)tab
join labsaw.labsaw_web_user b on tab.user_id=b.user_id
) tab2
where user_guid=v_user_guid;
--'1da999e3-6ade-43e5-ab71-b15b7aaf855d'

end if;	

p_leaderboard_json :=jsonb_set(p_leaderboard_json, '{user_leader_board}',coalesce(v_user_json,'""'),true);
	
	if p_leaderboard_json is null then 
	
	p_leaderboard_json:='{
  "leader_board": [],
  "user_leader_board": null,
  "page_count": null
}';
	
	end if;
	
	/*			
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
				
					if exists (select 1 from labsaw.labsaw_user_transaction
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
	
	
					 
		execute  'select ''{"leader_board":''||jsonb_agg(tab)::text||'',
		"total_count":''||total_count||'',
		"page_count":''||page_count||'',"user_leader_board":null}'' 
			 	  from (select count(1) over() as total_count,
				  case  when count(1) over() % '||p_page_size||'>1 then 
					  (count(1) over()/'||p_page_size||')+1 else count(1) over()/'||p_page_size||' end as page_count ,
						   a.bib_no,a.name,a.gender,a.state,a.city,a.time,a.distance,race_category,
						   row_number() over(order by user_name)as rn
					  from (select EXTRACT(year from age(current_timestamp::date,urc.date_of_birth::date)) as age, 
						          ut.bib_no,u.user_guid,u.user_full_name as name,u.gender as gender,s.name as state,
						          c.name as city,TO_CHAR((urc.actual_elapsed_time_in_seconds || '' second'')::interval, ''HH24:MI:SS'') as time,
								  urc.actual_elapsed_time_in_seconds,urc.actual_distance_in_meters as distance,urc.user_name,
								  urc.avg_pace as avg_speed,case ut.race_category_id when 1 then ''10''
								  												when 2 then ''21.1'' when 3 then ''42.2'' end as race_category
						   from labsaw.labsaw_web_user u
						   join labsaw.labsaw_user_race_challange urc
						   on u.user_guid=urc.user_guid
						   join labsaw.labsaw_user_transaction ut
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
														from labsaw.labsaw_web_user u
														join labsaw.labsaw_user_race_challange urc
														on u.user_guid=urc.user_guid
														join labsaw.labsaw_user_transaction ut
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
			p_leaderboard_json:= jsonb_set(p_data_json,'{user_leader_board}', p_data,true);						  
			else
			p_leaderboard_json:=p_data_json;
			end if;
		*/
	
end;
$_$;


--
