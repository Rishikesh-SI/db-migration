-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labbr_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labbr; Owner: -
--

CREATE FUNCTION labbr.labbr_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labbr.labbr_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_poll_id numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source,user_id, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count,filepath
    from (select client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count ,upr.add_info->>'filepath' as filepath
          from labbr.labbr_web_user wu
  		  left join labbr.labbr_user_poll_response upr
		  on upr.user_id=wu.user_id
          where wu.created_date between v_start_date_time and v_end_date_time
          union
          select client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count,upr.add_info->>'filepath'
          from labbr.labbr_web_user wu
          join labbr.labbr_user_asset_reaction uar
          on uar.user_id = wu.user_id
		  left join labbr.labbr_user_poll_response upr
		  on upr.user_id=wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,upr.add_info
          union
          select client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count,upr.add_info->>'filepath'
          from labbr.labbr_web_user wu
          join labbr.labbr_user_asset_reaction uar
          on uar.user_id = wu.user_id
		  left join labbr.labbr_user_poll_response upr
		  on upr.user_id=wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,upr.add_info
          union
          select client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count,upr.add_info->>'filepath'
          from labbr.labbr_web_user wu
          join labbr.labbr_asset_comment_reaction acr
          on acr.user_id = wu.user_id
		  left join labbr.labbr_user_poll_response upr
		  on upr.user_id=wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id,wu.user_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,upr.add_info
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
      		from labbr.labbr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labbr.labbr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labbr.labbr_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labbr.labbr_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
	
    end if;
	
	if v_opt_type = 3 then
	
	    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
		
		open p_user_cursor for
		select wu.user_id,p.title,wu.first_name,wu.last_name,wu.email_id,
		po.option::json->>'question' as question,upr.add_info::jsonb->>'filepath' as answer,upr.response_date
		from labbr.labbr_poll p
		join labbr.labbr_poll_option po on p.poll_id=po.poll_id
		join labbr.labbr_user_poll_response upr on po.poll_option_id=upr.response_option_id
		join labbr.labbr_web_user wu on wu.user_id=upr.user_id
		where p.poll_id=v_poll_id
		group by p.title,wu.first_name,wu.last_name,wu.email_id,question,answer,response_date,wu.user_id;

	end if;
    
    
    if v_opt_type = 4 then 
  open p_user_cursor for
select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source,
       a.first_name, a.last_name, a.email_id, a.dob, a.mobile_no, a.gender,a.city,a.pincode,f.entity_name as favourite_player_name,d.name as country
			from labbr.labbr_web_user a
   			left join waf_master.waf_players f 
			on a.favourite_player_id=f.source_object_id
			left join waf_master.waf_countries d 
			on a.country_id=d.country_id
            where created_date between v_start_date_time and v_end_date_time
            order by created_date desc;		  
end if;
 
 
 
 
end;
$$;


--
