-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labsaw_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labsaw.labsaw_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_opt_type_1 numeric;
	v_match_id numeric;
	v_json_data jsonb;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
	
	select opt_type,Map_id 
	into v_opt_type_1,v_match_id
	from labsaw.labsaw_user_data_filter
	where id = v_opt_type ;
	
  
 if v_opt_type_1 = 1 then
 	
	open p_user_cursor for
 	with cte_data as(select distinct email_id,social_user_name,user_full_name,dob,mobile_no,gender,
				 	row_number()over (partition by email_id order by created_date desc)
				 	from labsaw.labsaw_web_user)
				 
	select email_id,social_user_name,user_full_name,dob,mobile_no,gender from cte_data	
	where row_number=1 and email_id is not null;
	
	elseif 	v_opt_type_1 = 2 then
	
			open p_user_cursor for
			select a.user_id,b.user_full_name,b.email_id, 
			case c.gift_type when 2 then 'Match Ticket'  
				when 3 then 'Jersey' end as Gift_type
			from labsaw.labsaw_gratification_details a
			left join labsaw.labsaw_web_user b on a.user_id = b.user_id
			left join labsaw.labsaw_gratification_gift c on a.gift_id=c.gift_id
			where c.gift_type in (2,3) and a.match_id = v_match_id ;
	
	elseif 	v_opt_type_1 = 5 then
	
			open p_user_cursor for
			select  count(poll_id) as match_played,tab.user_id,
			ab.first_name,ab.last_name,
			string_agg(match,' , ')as match_string from (
			select distinct a.poll_id,user_id,poll_desc::jsonb->>'optionName' as match  from labsaw.labsaw_poll a
			join labsaw.labsaw_user_poll_response b on a.poll_id=b.poll_id
			where  exists (select 1 from
			  labsaw.labsaw_asset_entity_map
			   where asset_type_id=6 and entity_role_map_id=14061
			   and asset_id=a.poll_id)
			order by user_id
			) tab
			join labsaw.labsaw_web_user ab on ab.user_id=tab.user_id
			group by tab.user_id,ab.first_name,ab.last_name;
	   
	   elseif 	v_opt_type = 6 then		
			open p_user_cursor for
						select * from (	
					select  
				--count(1) over() as cnt,
				tot_points as total_points,first_name,last_name,
				
			row_number() OVER ( 
					 ORDER BY tot_points desc,tab.user_id ) as rn,		 
			(case when tot_points !=0
						 then RANK() over ( order by tot_points desc) 
					else 0
					end)	as rank	 ,b.email_id
			from (
			select  user_id,coalesce(sum(total_coins),0) as tot_points
			from labsaw.labsaw_user_poll_response 
			where total_coins is not null or total_coins !=0
			group by user_id
			)tab
			join labsaw.labsaw_web_user b on tab.user_id=b.user_id
				) tab2 

			where rn between 1 and  100 ;

	elseif 	v_opt_type = 7 then

        select p_input_json->'jsondata'->'guids' into v_json_data;

        open p_user_cursor for
		select client_id, social_user_name, user_full_name, 
		email_id, created_date,dob,gender,mobile_no,user_guid,first_name,last_name,updated_date

		
		from labsaw.labsaw_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_guid=b.value
		order by created_date desc
		;
		
		elseif 	v_opt_type = 10 then
		
		open p_user_cursor for
		select affliate_data_id,affliate_id,affliate_name,affiliate_signup,affiliate_deposit ,
				affiliate_account_no,is_approved,first_name,last_name,email_id,user_full_name				
		from labsaw.labsaw_affliate_data a
		left join labsaw.labsaw_web_user wu on a.user_guid = wu.user_guid
		where is_approved = 0 ; 
        
        
        elseif v_opt_type = 11 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->>'first_name' as first_name,contact_json->'data'->>'last_name' as last_name,
         contact_json->'data'->>'email_id' as email_id,contact_json->'data'->>'subject' as subject
		 from labsaw.labsaw_contact;
		 --where created_date::date between v_start_date_time and v_end_date_time;
 
 	raise notice 'aaav_start_date_time %',v_start_date_time;
		raise notice 'aaav_end_date_time %',v_end_date_time;
		
 
end if;
	
	
 
end;

$$;


--
