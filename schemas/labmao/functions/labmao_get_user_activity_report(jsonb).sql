-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_get_user_activity_report(jsonb)
-- Type: FUNCTION

-- Name: labmao_get_user_activity_report(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_get_user_activity_report(p_json jsonb, OUT p_report_json jsonb, OUT p_report_filter jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
  v_page_number numeric;
  v_item_number numeric;
  
  v_fromrownumber numeric;
v_torownumber numeric; 
v_user_id numeric;
v_gender varchar(50);
v_age_group varchar(50);
v_city varchar(500);
v_state_name  varchar(500);
v_group_name  varchar(500);
v_distance_asc numeric;
v_search_text varchar(500);
v_from_age numeric;
v_to_age numeric;
v_city_json jsonb;
v_corporate_json jsonb;
v_state_json jsonb;
v_age_json jsonb;
v_category varchar(500);

 begin
 
 
select  p_json->>'page_number',
        p_json->>'item_number',
		p_json->>'gender',
		p_json->>'age_group',
		p_json->>'city',
		p_json->>'state_name',
		p_json->>'group_name',
		p_json->>'distance_asc',
		p_json->>'search_text',
		p_json->>'user_id',
		p_json->>'category'
		into
		v_page_number,
		v_item_number,
		v_gender,
		v_age_group,
		v_city,
		v_state_name,
		v_group_name,
		v_distance_asc,
		v_search_text,
		v_user_id,
		v_category;
		
		
 
v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);
 ---raise notice '%,%,%,%,%,%,%',v_gender,v_state_name,v_city,v_fromrownumber,v_torownumber,
 ---v_search_text,v_user_id;
 
	 update labmao.labmao_user_master
	 set group_name =null,group_id =null
	 where payment_status=1
	 and group_name='PhonePe';
	
	 update labmao.labmao_user_activity_report
     set  group_name =null,group_id =null
	 where   group_name='PhonePe';
 
 
     update labmao.labmao_user_master
     set pledged_state=replace(pledged_state,'-',null),
         pledged_city=replace(pledged_city,'-',null)
	 where payment_status=1;
	 
    update labmao.labmao_user_master
    set pledged_state=replace(pledged_state,' - ',null),
        pledged_city=replace(pledged_city,' - ',null)
    where payment_status=1;
	 
	update labmao.labmao_user_activity_report
    set pledged_state=replace(pledged_state,'-',null),
        pledged_city=replace(pledged_city,'-',null);
	 
 	update labmao.labmao_user_activity_report
 	set pledged_state=replace(pledged_state,' - ',null),
     	pledged_city=replace(pledged_city,' - ',null); 
 
 
 
	 select  array_to_json(array_agg(row))
	 from ( select distinct  coalesce(pledged_state,state_name) as state_name,
		   coalesce(pledged_city,city) as city
		   from labmao.labmao_user_activity_report
		   where  city is not null
		   and state_name is not null
		   order by city
		  ) as row
	 into v_city_json;
 
 
	 select  array_to_json(array_agg(row))
	 from ( select distinct   coalesce(pledged_state,state_name) as state_name 
		   from labmao.labmao_user_activity_report
		   where   state_name is not null
		   order by state_name
		  ) as row
	 into  v_state_json;
 
 
	 select  array_to_json(array_agg(row))
	 from ( select distinct   group_name
		   from labmao.labmao_user_master
		   where payment_status=1
		  and group_id is not null
		   and group_name is not null
		   order by group_name
		  ) as row
	 into v_corporate_json ;
 
 
 
 
 
	 select  array_to_json(array_agg(row))
	 from ( select distinct   age_group
		   from labmao.labmao_age_group
		   order by age_group
		  ) as row
	 into v_age_json ;
 
 
 
	 if v_age_group is not null then
	 
		 begin
		 
			 select from_age,to_age
			 from labmao.labmao_age_group
			 where age_group=v_age_group
			 into v_from_age,v_to_age;

			 exception when others
			 then
			 v_from_age:=1;
			 v_to_age:=150;
			 
		 end;
		 
	 else
		  v_from_age:=1;
		  
		  v_to_age:=150;
		  
	 end if;
 
    
	if v_category is null then
 
		 if v_distance_asc =1 then

			 select array_to_json(array_agg(row))
			 from (select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
								  tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
								  case when tb.runner_id = coalesce(v_user_id,0) then 0 else  curr_rank end sl_no,
								  tb.curr_rank,um.runclub_name,um.ngo
								  from (select user_id,user_name,distance,bib_no,group_name,
										coalesce(pledged_city ,city) as city,coalesce(pledged_state ,state_name) as state_name,
										runner_id,pledged_distance,row_number()over(order by distance asc,user_name) as curr_rank
										from  labmao.labmao_user_activity_report
										where (gender = coalesce(v_gender,gender)
										and  coalesce(pledged_city ,city)  = coalesce(v_city,coalesce(pledged_city ,city))
										and coalesce(pledged_state ,state_name) = coalesce(v_state_name,coalesce(pledged_state ,state_name))
										and coalesce(group_name,'X') = coalesce(v_group_name,coalesce(group_name,'X'))
										and runner_id <> coalesce(v_user_id,0)
										and age between v_from_age and v_to_age	
										and distance >=0.01
										and (upper(user_name) like  '%'|| coalesce(upper(v_search_text),upper(user_name)) ||'%'
										or cast(bib_no as varchar(500))=v_search_text)) or runner_id=coalesce(v_user_id,0)
									   ) as tb
								  left join labmao.labmao_user_master um on tb.user_id = um.user_id								  
								 ) as tk
				   where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
				   order by sl_no
			 /*union 
			 select user_id,
			 user_name,
			 distance,
			 bib_no,
			 group_name,
			 city,
			 state_name,
			 pledged_distance,
				0 as sl_no 
			 from  labmao.labmao_user_activity_report
			 where runner_id = v_user_id
			 order by sl_no*/
				  ) as row
				  into p_report_json;
			  end if;

			 if v_distance_asc =0 then
				  select array_to_json(array_agg(row))
				 from (select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
									  tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
									  case when tb.runner_id = coalesce(v_user_id,0) then 0 else  tb.curr_rank end sl_no,
									  tb.curr_rank,um.runclub_name,um.ngo
									  from (select user_id,user_name,distance,bib_no,group_name,
											coalesce(pledged_city ,city) as city,
											coalesce(pledged_state ,state_name) as state_name,
											runner_id,pledged_distance,row_number()over(order by distance desc,user_name) as curr_rank
											from  labmao.labmao_user_activity_report
											where (gender = coalesce(v_gender,gender)
											and  coalesce(pledged_city ,city)  = coalesce(v_city,coalesce(pledged_city ,city))
											and coalesce(pledged_state ,state_name) = coalesce(v_state_name,coalesce(pledged_state ,state_name))
											and coalesce(group_name,'X') = coalesce(v_group_name,coalesce(group_name,'X'))
											and runner_id <> coalesce(v_user_id,0)
											and age between v_from_age and v_to_age	
											and distance >=0.01
											and (upper(user_name) like  '%'|| coalesce(upper(v_search_text),upper(user_name)) ||'%'
												or cast(bib_no as varchar(500))=v_search_text)) or runner_id=coalesce(v_user_id,0)
										   ) as tb
									  left join labmao.labmao_user_master um on tb.user_id = um.user_id	
									 ) as tk
					   where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
					   order by sl_no
					  ) as row
					  into p_report_json;

			end if;
	 ---raise notice '%',v_distance_asc;

		 if v_distance_asc is null then

			  select array_to_json(array_agg(row))
			  from ( select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
									tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
									case when tb.runner_id = coalesce(v_user_id,0) then 0 else
									case when coalesce(v_group_name,coalesce(v_city,v_state_name)) is not null then tb.curr_corp_rank else  tb.curr_rank end
									end sl_no,
									case when coalesce(v_group_name,coalesce(v_city,v_state_name)) is not null then tb.curr_corp_rank else  tb.curr_rank end as curr_rank,
									um.runclub_name,um.ngo
									from (select user_id,user_name,distance,bib_no,group_name,coalesce(pledged_city ,city) as city,
										  coalesce(pledged_state ,state_name) as state_name,runner_id,pledged_distance,
										  row_number()over(order by user_name) as curr_rank,
										  row_number()over(order by distance desc) as curr_corp_rank
										  from  labmao.labmao_user_activity_report
										  where (gender = coalesce(v_gender,gender)
										  and  coalesce(pledged_city ,city)  = coalesce(v_city,coalesce(pledged_city ,city))
										  and coalesce(pledged_state ,state_name) = coalesce(v_state_name,coalesce(pledged_state ,state_name))
										  and coalesce(group_name,'X') = coalesce(v_group_name,coalesce(group_name,'X'))
										  and runner_id <> coalesce(v_user_id,0)
										  and age between v_from_age and v_to_age	
										  and distance >=0.01
										  and (upper(user_name) like  '%'|| coalesce(upper(v_search_text),upper(user_name)) ||'%'
										  or cast(bib_no as varchar(500))=v_search_text)) or runner_id=coalesce(v_user_id,0)
										 ) as tb
									left join labmao.labmao_user_master um on tb.user_id = um.user_id	
								   ) as tk
					where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
					order by sl_no
				   ) as row
				   into p_report_json;

		 end if;
		 
	 else
	 	
		if v_distance_asc =1 then

			 select array_to_json(array_agg(row))
			 from (select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
								  tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
								  case when tb.runner_id= coalesce(v_user_id,0) then 0 else  tb.curr_rank end sl_no,
								  tb.curr_rank,um.runclub_name,um.ngo
								  from (select a.user_id,user_name,b.distance,bib_no,group_name,
										coalesce(pledged_city ,city) as city,coalesce(pledged_state ,state_name) as state_name,
										runner_id,pledged_distance,row_number()over(order by b.distance asc,user_name) as curr_rank
										from  labmao.labmao_user_activity_report a
										join  (select user_id,sum(distance) distance from labmao.labmao_user_activity_detail
												 where type = v_category
												 group by 1) b on a.user_id = b.user_id
										where (gender = coalesce(v_gender,gender)
										and  coalesce(pledged_city ,city)  = coalesce(v_city,coalesce(pledged_city ,city))
										and coalesce(pledged_state ,state_name) = coalesce(v_state_name,coalesce(pledged_state ,state_name))
										and coalesce(group_name,'X') = coalesce(v_group_name,coalesce(group_name,'X'))
										and runner_id <> coalesce(v_user_id,0)
										and age between v_from_age and v_to_age	
										and b.distance >=0.01
										and (upper(user_name) like  '%'|| coalesce(upper(v_search_text),upper(user_name)) ||'%'
										or cast(bib_no as varchar(500))=v_search_text)) or runner_id=coalesce(v_user_id,0)
									   ) as tb
								  left join labmao.labmao_user_master um on tb.user_id = um.user_id
								 ) as tk
				   where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
				   order by sl_no
			 /*union 
			 select user_id,
			 user_name,
			 distance,
			 bib_no,
			 group_name,
			 city,
			 state_name,
			 pledged_distance,
				0 as sl_no 
			 from  labmao.labmao_user_activity_report
			 where runner_id = v_user_id
			 order by sl_no*/
				  ) as row
				  into p_report_json;
			  end if;

			 if v_distance_asc =0 then
				  select array_to_json(array_agg(row))
				 from (select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
									  tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
									  case when tb.runner_id= coalesce(v_user_id,0) then 0 else  tb.curr_rank end sl_no,
									  tb.curr_rank,um.runclub_name,um.ngo
									  from (select a.user_id,a.user_name,b.distance,a.bib_no,a.group_name,
											coalesce(a.pledged_city ,a.city) as city,
											coalesce(a.pledged_state ,a.state_name) as state_name,
											a.runner_id,a.pledged_distance,row_number()over(order by b.distance desc,a.user_name) as curr_rank
											from  labmao.labmao_user_activity_report a
											join  (select user_id,sum(distance) distance from labmao.labmao_user_activity_detail
												 where type = v_category
												 group by 1) b on a.user_id = b.user_id
											where (a.gender = coalesce(v_gender,a.gender)
											and  coalesce(a.pledged_city ,a.city)  = coalesce(v_city,coalesce(a.pledged_city ,a.city))
											and coalesce(a.pledged_state ,a.state_name) = coalesce(v_state_name,coalesce(a.pledged_state ,a.state_name))
											and coalesce(a.group_name,'X') = coalesce(v_group_name,coalesce(a.group_name,'X'))
											and a.runner_id <> coalesce(v_user_id,0)
											and a.age between v_from_age and v_to_age	
											and b.distance >=0.01
											and (upper(a.user_name) like  '%'|| coalesce(upper(v_search_text),upper(a.user_name)) ||'%'
												or cast(a.bib_no as varchar(500))=v_search_text)) or a.runner_id=coalesce(v_user_id,0)
										   ) as tb
									  left join labmao.labmao_user_master um on tb.user_id = um.user_id
									 ) as tk
					   where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
					   order by sl_no
					  ) as row
					  into p_report_json;

			end if;
	 ---raise notice '%',v_distance_asc;

		 if v_distance_asc is null then

			  select array_to_json(array_agg(row))
			  from ( select * from ( select tb.user_id,tb.user_name,round(tb.distance,2) as distance,
									tb.bib_no,coalesce(tb.group_name,um.corporate)as group_name,tb.city,tb.state_name,tb.pledged_distance,
									case when tb.runner_id= coalesce(v_user_id,0) then 0 else
									case when coalesce(v_group_name,coalesce(v_city,v_state_name)) is not null then tb.curr_corp_rank else  tb.curr_rank end
									end sl_no,
									case when coalesce(v_group_name,coalesce(v_city,v_state_name)) is not null then tb.curr_corp_rank else  tb.curr_rank end as curr_rank,
									um.runclub_name,um.ngo
									from (select a.user_id,a.user_name,b.distance,a.bib_no,a.group_name,coalesce(a.pledged_city ,a.city) as city,
										  coalesce(a.pledged_state ,a.state_name) as state_name,a.runner_id,a.pledged_distance,
										  row_number()over(order by a.user_name) as curr_rank,
										  row_number()over(order by b.distance desc) as curr_corp_rank
										  from  labmao.labmao_user_activity_report a
										  join  (select user_id,sum(distance) distance from labmao.labmao_user_activity_detail
												 where type = v_category
												 group by 1) b on a.user_id = b.user_id
										  where (a.gender = coalesce(v_gender,gender)
										  and  coalesce(a.pledged_city ,a.city)  = coalesce(v_city,coalesce(a.pledged_city ,a.city))
										  and coalesce(a.pledged_state ,a.state_name) = coalesce(v_state_name,coalesce(a.pledged_state ,a.state_name))
										  and coalesce(a.group_name,'X') = coalesce(v_group_name,coalesce(a.group_name,'X'))
										  and a.runner_id <> coalesce(v_user_id,0)
										  and a.age between v_from_age and v_to_age	
										  and b.distance >=0.01
										  and (upper(a.user_name) like  '%'|| coalesce(upper(v_search_text),upper(a.user_name)) ||'%'
										  or cast(a.bib_no as varchar(500))=v_search_text)) or a.runner_id=coalesce(v_user_id,0)
										 ) as tb
									left join labmao.labmao_user_master um on tb.user_id = um.user_id
								   ) as tk
					where (sl_no between v_fromrownumber  and v_torownumber) or sl_no=0
					order by sl_no
				   ) as row
				   into p_report_json;

		 end if;
	 
	 end if;
		 
		 
 
  select row_to_json(row)
  from (
  select v_city_json as city_filter,
	     v_state_json as state_filter,
	     v_corporate_json as corporate_filter,
	     v_age_json as age_filter
  ) as row
  into p_report_filter;
  
 end;
$$;


--
