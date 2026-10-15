-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: dd_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
 select * from dd.dd_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2020-09-01 00:00:00",
  "end_date_time": "2020-09-11 23:59:59"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_spin_start_date date:='2020-09-10';
	v_spin_curr_date date:=current_date;
	v_diff numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
     raise notice '%,%',v_start_date_time,v_end_date_time;
    
  
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from dd.dd_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from dd.dd_web_user wu
          join dd.dd_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from dd.dd_web_user wu
          join dd.dd_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from dd.dd_web_user wu
          join dd.dd_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
         ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id;
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from dd.dd_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from dd.dd_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from dd.dd_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join dd.dd_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
			
			 end if;
    
   
 
 if v_opt_type = 3 then ---- jersey requests
 
 open p_user_cursor for
 select  j.email_id,j.jersey_number,j.player_name as user_jersey_name,j.favorite_player
		 ,j.created_date,wu.first_name,wu.last_name
	from  dd.dd_user_jersey_request	 j
	join dd.dd_web_user wu
	on wu.user_id=j.user_id
	where j.created_date >=v_start_date_time 
   and j.created_date <=v_end_date_time 
	order by j.created_date asc;
 
 end if;
 
 
 if v_opt_type = 4 then ---- gratified user data
 
 open p_user_cursor for
 select  w.user_id,w.email_id,w.first_name,w.last_name,
      g.gift_name
		 ,uj.created_date
	from  dd.dd_gratification_details_2020	uj
	join dd.dd_web_user w
	on w.user_id=uj.user_id
	join dd.dd_gratification_gift_2020 g
	on g.gift_id=uj.gift_id
	where g.gift_name <>'Better Luck Next Time'
	and uj.created_date>=v_start_date_time
	and uj.created_date<=v_end_date_time
	 order by uj.created_date asc;
 
 end if;
 
 
 if v_opt_type = 5 then ---- Login user data
 
 open p_user_cursor for
 select  w.user_id,w.email_id,w.first_name,w.last_name,
       
		  w.created_date
	from   dd.dd_web_user w
	 
	where   w.created_date>=v_start_date_time
	and w.created_date<=v_end_date_time
	 order by w.created_date asc;
 
 end if;
 
  if v_opt_type = 6 then ---- daily users 2020
 
 v_diff:=v_spin_curr_date-v_spin_start_date;
 ---raise notice '%',v_diff;
 
 open p_user_cursor for
 select  w.user_id,w.email_id,w.first_name,w.last_name,
       
		  w.created_date,dj.jersey_number,dj.player_name as user_jersey_name,dj.favorite_player
	from   dd.dd_web_user w
	join  dd.dd_user_jersey_request_2020	 dj
	 on dj.user_id=w.user_id
	where   w.user_id in (select user_id
						  from (select user_id,count(1),created_date::date as spin_date 
								from dd.dd_gratification_details_2020  
                                where  
                               gift_id=6
	  group by user_id,created_date::date
   having count(1)=v_diff+1 ) as tb)
	 order by w.user_id asc;
 
 end if;
 
 
 if v_opt_type = 7 then ---- gratified user data 2021
 
 	open p_user_cursor for
 select  w.user_id,w.email_id,w.first_name,w.last_name,
       
		  w.created_date,null as jersey_number,null as user_jersey_name,null as favorite_player,
		  w.last_spin_date
	from   dd.dd_web_user w
	where   w.user_id in (select user_id
						  from (select user_id 
								from dd.dd_gratification_details  
                                
	 ) as tb)
	 order by w.user_id asc;
 
 
 
 end if;
 
  if v_opt_type = 8 then ---- daily users 2021
 
 ----v_diff:=v_spin_curr_date-v_spin_start_date;
 ---raise notice '%',v_diff;
 open p_user_cursor for
 select  w.user_id,w.email_id,w.first_name,w.last_name,
      g.gift_name
		 ,uj.created_date
	from  dd.dd_daily_gratification_winners	uj
	join dd.dd_web_user w
	on w.user_id=uj.user_id
	join dd.dd_gratification_gift g
	on g.gift_id=uj.gift_id
	where  uj.created_date>=v_start_date_time
	and uj.created_date<=v_end_date_time
	 order by uj.created_date asc;
 
 
 end if;
 
 
 
 if v_opt_type = 9 then ---- watch party
 
 open p_user_cursor for
 
  select  wu.email_id
		 ,j.created_date,wu.first_name,wu.last_name,
		  j.client_mod_json->'data'->>'file_url' as file_path,
		   j.client_mod_json->'data'->>'phone_num' as contact
	from  dd.dd_client_web_cust_model	 j
	join dd.dd_web_user wu
	on wu.user_guid=j.client_mod_json->'data'->>'user_guid'
	where j.module_name='watch-party'
	and j.created_date >=v_start_date_time 
   and j.created_date <=v_end_date_time 
	order by j.created_date asc;
 
 end if;

 if v_opt_type = 10 then 
 
 ---raise notice '%',v_diff;
 
 open p_user_cursor for
 select  w.email_id,w.is_active,w.is_verified
       
	from   dd.dd_web_user w
	where   w.email_id is not null and
	w.is_active=1 and w.is_deleted=0 and w.is_verified=1;
	-- and w.created_date::date between v_start_date_time and v_end_date_time;

 end if;
 

end;
$$;


--
