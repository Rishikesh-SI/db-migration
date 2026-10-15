-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labrstg_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labrstg.labrstg_get_user_data
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
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender,reaction_count, comment_count,first_name,last_name,created_date at time zone 'utc' at time zone 'Asia/Calcutta',s.name as state_name
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, 0 as reaction_count,
          		0 as comment_count,first_name,last_name,created_date,state_id
          from labrstg.labrstg_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,
          		count(1) as reaction_count, 0 as comment_count,first_name,last_name,created_date at time zone 'utc' at time zone 'Asia/Calcutta',state_id
          from labrstg.labrstg_web_user wu
          join labrstg.labrstg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,first_name,last_name,created_date,state_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, 0 as reaction_count,
          		count(1) as comment_count,first_name,last_name,created_date,state_id
          from labrstg.labrstg_web_user wu
          join labrstg.labrstg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,first_name,last_name,created_date,state_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,
          		count(1) as reaction_count, 0 as comment_count,first_name,last_name,created_date,state_id
          from labrstg.labrstg_web_user wu
          join labrstg.labrstg_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,first_name,last_name,created_date,state_id
         ) as tab
      left join waf_master.waf_states s
     on s.state_id = tab.state_id
	 order by created_date desc;
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labrstg.labrstg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labrstg.labrstg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labrstg.labrstg_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labrstg.labrstg_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 
 
 
end;
$$;


--
