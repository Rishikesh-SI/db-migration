-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_get_user_profile(text)
-- Type: FUNCTION

-- Name: labmao_get_user_profile(text); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_get_user_profile(p_user_guid text, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
 v_curr_date date:=current_date;
 v_total_distance_covered numeric ;
 v_reached_pledged_distance numeric;
 v_first_activity  numeric;
	v_reached_30km  numeric;
	v_3_days  numeric;
	v_5_days  numeric;
	v_7_days  numeric;
	v_2_weeks numeric;
	v_3_weeks numeric;
	v_4_weeks numeric;
	v_bronze_medal numeric;
	v_silver_medal numeric;
	v_gold_medal numeric;
	v_platinum_medal numeric;
	v_badge_out numeric;
	v_user_id numeric;
	v_distance jsonb;
	
	i record;
 	 j record;
	 v_counter numeric := 0;
	 v_previous_day date := null;
	 v_date_diff numeric;
	 v_day_3 numeric;
	 v_day_5 numeric;
	 v_day_7 numeric;
	 v_data text;
	 v_data_1 jsonb ;	 
	 v_weeks_2 numeric;
	 v_weeks_3 numeric;
	 v_weeks_4 numeric;
begin
/*
select * from labmao.labmao_upd_badge_detail(p_user_guid)
into v_badge_out;*/

select user_id into v_user_id from labmao.labmao_user_master
where user_guid = p_user_guid;

begin
select distance,first_activity,reached_30km,weeks_2,weeks_3,weeks_4,
days_3,days_5,days_7,reached_pledged_distance,bronze_medal,silver_medal,gold_medal,platinum_medal
from labmao.labmao_user_activity_report
where user_id = v_user_id  -- or upper(email_id) =upper(p_user_guid)
	-- email_id = case when p_user_guid ='praveen22100@gmail.com' then 'vivek@procam.in'
	--else p_user_guid end
		  
into v_total_distance_covered,
v_first_activity,
v_reached_30km,v_2_weeks,v_3_weeks,v_4_weeks,
v_3_days,v_5_days,v_7_days,v_reached_pledged_distance,
v_bronze_medal,v_silver_medal,v_gold_medal,v_platinum_medal;

exception when no_data_found then
v_total_distance_covered:=0;
end;

v_bronze_medal:= case when coalesce(v_silver_medal,0)=1 then null else v_bronze_medal end;
v_silver_medal:= case when coalesce(v_gold_medal,0)=1 then null else v_silver_medal end;
v_gold_medal:= case when coalesce(v_platinum_medal,0)=1 then null else v_gold_medal end;
 
 
 
update labmao.labmao_user_master
set  group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE')
and payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid));

update labmao.labmao_user_activity_report
set group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE')
and upper(email_id) =upper(p_user_guid);

  
update labmao.labmao_user_master
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme')
and   payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid));

update labmao.labmao_user_activity_report
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme')
and  upper(email_id) =upper(p_user_guid);
 

update labmao.labmao_user_master
set old_group_id=group_id,
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where payment_status=1
and (user_guid=p_user_guid or upper(email_id) =upper(p_user_guid))
and group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');

update labmao.labmao_user_activity_report
set  
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where  upper(email_id) =upper(p_user_guid)
and group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');

select row_to_json(row) 
from (
	select um.user_id,
	um.email_id,
	 
	um.user_guid, 
	um.payment_status, 
	um.payment_amount,
	um.category, 
	replace(um.pledged_distance,'.0000','') as pledged_distance, 
	um.group_id, 
	initcap(um.user_name) as user_name, 
	um.city, 
	um.state_name, 
	um.pincode, 
	um.bib_no,
	um.height,
	um.weight,
	um.mobile_no, 
	um.external_user_id,
	um.dob,
	EXTRACT(YEAR from AGE(NOW(), um.dob)) age,
	um.charity_amount ,
	um.nationality,
	um.gender,
    um.pledged_state,
    um.pledged_city,
	um.ngo,
	um.corporate,
	um.runclub_name,
	a.distance as total_distance_covered,
	--g.group_name,
    case when um.group_name ='PhonePe' then '' else um.group_name end as group_name_1,
	case when  um.activity_date=v_curr_date then 1 else 0 end as  is_one_time,
   --  v_total_distance_covered as total_distance_covered,
	v_first_activity as first_activity,
	case when v_total_distance_covered>=30 then 1 else v_reached_30km end as reached_30km,
	v_reached_pledged_distance as reached_pledged_distance,
	v_2_weeks as weeks_2,
	v_3_weeks as weeks_3,
	v_4_weeks as weeks_4,
	v_3_days as days_3,
	v_5_days as days_5,
	v_7_days as days_7,
	v_bronze_medal as bronze_medal,
	v_silver_medal as silver_medal,
	v_gold_medal as gold_medal,
	v_platinum_medal as platinum_medal,
	case when round(v_total_distance_covered)>0 
	and um.category in ('Change Leader','Change Champion') then 1
	else 0 end as video_flag
	from labmao.labmao_user_master um 
	left join (select user_id,sum(distance) distance from labmao.labmao_user_activity_detail
			   where user_id = v_user_id group by 1) a on a.user_id = um.user_id
	-- left join labmao.labmao_group g on um.email_id = g.encrypted_email
	where (user_guid = p_user_guid --or upper(email_id) =upper(p_user_guid)
	 --email_id = case when p_user_guid ='praveen22100@gmail.com' then 'vivek@procam.in'
--	else p_user_guid end
		  )
	and payment_status=1
	 ) row
	into p_user_json;
	
	select json_agg(tab) into v_distance from 
	(select type,round(sum(distance),2) from labmao.labmao_user_activity_detail
	where user_id = v_user_id
	group by  1) tab;
	
	
	p_user_json := jsonb_set(p_user_json, '{distance}', coalesce(v_distance,'[]'::text::jsonb),true);
	
    for i in
	 select user_id,type,
	 case when distance > 0 then 1 else null end as first_activity,
	 case when distance>=30 then 1 else null end as reached_30km
	 from
	 (select user_id,type,sum(distance) distance from labmao.labmao_user_activity_detail
	 where user_id = v_user_id
	 group by 1,2 ) a
	 
     loop
	     for j in
	     select  distinct activity_date from labmao.labmao_user_activity_detail
         where user_id = i.user_id and type = i.type
		 order by activity_date 
	
	     loop
		
	     if v_previous_day is null then
		 
			 v_counter := 1  ;
			 v_previous_day := j.activity_date::date ;			 
		 
		 else 
		     
			select j.activity_date::date - v_previous_day into v_date_diff;

			  if v_date_diff > 1 then
			  
			    v_counter := 0;
				v_previous_day := null ;	
								 
			  else
			    
				 v_previous_day := j.activity_date ;
				 v_counter := v_counter + 1;
			     
				  if v_counter = 3 then
				  
				  v_day_3:=  1;
				  
				  elsif v_counter = 5 then
				  
				  v_day_5 :=  1;
				  
				  elsif v_counter = 7 then
				  
				  v_day_7 :=  1;
				  
				  elsif v_counter = 14 then
				  
				  v_weeks_2 := 1;
				  
				   elsif v_counter = 21 then
				   
				   v_weeks_3 := 1;
				   
				   elsif v_counter = 28 then
				   
				   v_weeks_4 := 1;
				  
				  end if;
			     
			  end if ;
			  		   
		 
		 end if;
		 	 
		
		end loop;
		
			v_data := '{
				"type": "'|| coalesce(i.type,'') ||'" ,
				"first_activity": "'|| coalesce(i.first_activity::varchar,'') ||'",
				"reached_30km": "'|| coalesce(i.reached_30km::varchar,'') ||'",
				"day_3": "'|| coalesce(v_day_3::varchar,'') ||'",
				"day_5": "'|| coalesce(v_day_5::varchar,'') ||'",
				"day_7": "'|| coalesce(v_day_7::varchar,'') ||'",
				"weeks_2": "'|| coalesce(v_weeks_2::varchar,'') ||'",
				"weeks_3": "'|| coalesce(v_weeks_3::varchar,'') ||'",
				"weeks_4": "'|| coalesce(v_weeks_4::varchar,'') ||'"
				
				
				}';
   
			select COALESCE(v_data_1 , '[]'::JSONB) || v_data::JSONB 
			into v_data_1 ;
			
			
	
	end loop;
	
	p_user_json := jsonb_set(p_user_json, '{activity}', coalesce(v_data_1,'[]'::text::jsonb),true);
	
	
	end;
$$;


--
