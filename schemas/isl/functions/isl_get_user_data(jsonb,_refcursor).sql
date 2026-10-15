-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: isl_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from isl.isl_get_user_data
(
    '{
    "opt_type": 3,
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
    v_map_id numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
  
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
    select opt_type,map_id into v_opt_type_1,v_map_id from isl.isl_user_data_filter
    where id=v_opt_type;
    
 
    
    
 if v_opt_type_1 = 1 then
    	open p_user_cursor for
         select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, 
         social_user_name, user_full_name, email_id, dob,
     		mobile_no, gender,wu.city,(wu.created_date + '5.5 hours'::interval)::date,favourite_club,em.entity_name as team_name,favourite_player_id,em1.entity_name as player_name
          from isl.isl_web_user wu
          left join isl.isl_entity_role_map erm on wu.favourite_club = erm.source_object_id and erm.entity_role_id=333
          left join isl.isl_entity_master em on erm.entity_master_id = em.entity_master_id
          left join isl.isl_entity_role_map erm1 on wu.favourite_player_id = erm1.source_object_id and erm1.entity_role_id=222
          left join isl.isl_entity_master em1 on erm1.entity_master_id = em1.entity_master_id         
           where wu.is_active=1 and (wu.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ;
          
           --where (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
         
     
 elseif v_opt_type_1 = 2 then
 
 	if exists(select 1 from isl.isl_client_web_cust_model
                  where (client_mod_json->>'poll_id')::numeric = v_map_id)then        
         
         open p_user_cursor for
          (select module_name,firstname,dob,lastname,pincode,phone,email,userFrom,contestSource,
				b->>'question' question ,b->>'answer' answer ,created_date
          from(select module_name,custom_module_id,client_mod_json->'data'->'user'->>'firstname' firstname,
				client_mod_json->'data'->'user'->>'dob' dob,
				client_mod_json->'data'->'user'->>'lastname' lastname ,
				client_mod_json->'data'->'user'->>'pincode' pincode,
				client_mod_json->'data'->'user'->>'phone' phone,
				client_mod_json->'data'->'user'->>'email' email,
				client_mod_json->'data'->'user'->>'userFrom' userFrom,
 				client_mod_json->'data'->'user'->>'contestSource' contestSource,
               	created_date,
				jsonb_array_elements(client_mod_json->'data'->'poll') b from isl.isl_client_web_cust_model
				where (client_mod_json->>'poll_id')::numeric = v_map_id and custom_module_id<>1)a
				where custom_module_id not in (3,4,5,6));
                  
      elsif exists(select 1 from isl.isl_poll where poll_id = v_map_id)then 
      
 		open p_user_cursor for
		select a.poll_option_id,(a.option::json->>'pid') player_id,
		(a.option::json->>'player_name') player_name,count(1) from isl.isl_poll_option a
		left join isl.isl_poll_response b on a.poll_option_id=b.response_option_id
		where a.poll_id = v_map_id
		group by 1,2,3;
        
   end if; 
   
   elseif v_opt_type_1 = 3 then  
    	
        open p_user_cursor for
        with cte_data as ( select asset_id, asset_type_id,count(1) total
 		from isl.isl_user_asset_reaction
 		where reaction_id is not null and reaction_date::date between v_start_date_time and v_end_date_time
 		group by asset_id, asset_type_id
 		order by total desc)
		select * from (select  al.asset_id,al.asset_title,
            case  al.asset_type_id  when 1 then 'article' when 2 then 'album' when 4 then 'video' else 'NA' end as post_type,
          (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=1 and reaction_date::date between v_start_date_time and v_end_date_time )as Happy,
          (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=2 and reaction_date::date between v_start_date_time and v_end_date_time)as Sad,
          (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=3 and reaction_date::date between v_start_date_time and v_end_date_time)as Cup,
          (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=4 and reaction_date::date between v_start_date_time and v_end_date_time)as comment,
		  (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=5 and reaction_date::date between v_start_date_time and v_end_date_time)as 
          	Red_card,
           (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.platform_id=1 and reaction_date::date between v_start_date_time and v_end_date_time )as Android,
            (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.platform_id=2 and reaction_date::date between v_start_date_time and v_end_date_time)as IOS,
            (select count(1) from isl.isl_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.platform_id is null and reaction_date::date between v_start_date_time and v_end_date_time)as Web     
    from cte_data a
  	left join isl.isl_asset_list al on a.asset_id=al.asset_id and a.asset_type_id= al.asset_type_id
   	)tab;
    
  elseif v_opt_type_1 = 4 then 
  		open p_user_cursor for	
  		select a.user_id,b.user_full_name,b.dob,b.mobile_no,b.email_id,b.city,
		b.gender,b.favourite_club,b.address as social_user_name,a.nth_num,c.gift_name,c.gift_url
        from isl.isl_gratification_details a
        left join isl.isl_web_user b on  a.user_id=b.user_id
        left join isl.isl_gratification_gift c on a.gift_id = c.gift_id
        where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;
        
   elseif v_opt_type_1 = 5 then 
   
        open p_user_cursor for
   		select tab_1.*,em.entity_name as team_name from
		(select e->>'id' as player_id,e->>'name' as name,e->>'team_id' as team_id,
        e->>'skill_name' as skill_name /*,e->'sport_specific_keys'->>'is_captain' as is_captain*/,count(1) 
        from(select jsonb_array_elements(d->'players') e 
             from (select jsonb_array_elements(b) d 
                   from (select team_json->'newly_added_players' b 
                         from isl.isl_user_team
                         where season_id = '148' and week_id = v_map_id
                         order by 1 desc) c)
                   row)tab
        group by e->>'id',e->>'name' ,e->>'team_id' ,e->>'skill_name'
        order by 5 desc )tab_1
        left join isl.isl_entity_role_map erm on tab_1.team_id=erm.source_object_id and erm.entity_role_id=333
        left join isl.isl_entity_master em on erm.entity_master_id = em.entity_master_id;
		
	elseif v_opt_type_1 = 6 then
		
		open p_user_cursor for
		select wu.user_full_name,wu.mobile_no,wu.email_id,f.team_id,em.entity_name as team,f.match_id,em1.entity_name as Match ,
			case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google' when 5 then 'Custom' end as source
		from isl.isl_fan_wall f
		left join isl.isl_web_user wu on f.user_guid = wu.user_guid
		left join isl.isl_entity_role_map erp on f.team_id = erp.source_object_id::numeric and erp.entity_role_id = 333
		left join isl.isl_entity_master em on erp.entity_master_id = em.entity_master_id 
		left join isl.isl_entity_role_map erp1 on f.match_id = erp1.source_object_id::numeric and erp1.entity_role_id = 6 and erp1.source_object_id is not null
		left join isl.isl_entity_master em1 on erp1.entity_master_id = em1.entity_master_id
		where (f.registered_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;
		
	elseif v_opt_type_1 = 7 then
	
		open p_user_cursor for
		select user_full_name,email_id,client_id from 
		(select user_full_name,email_id,client_id,row_number() over(order by client_id desc) as rn from
		(select distinct user_full_name,email_id,client_id from isl.isl_web_user
		where client_id = 5 and is_verified =  1 and user_full_name is not null
		UNION
		select distinct user_full_name,email_id,client_id from isl.isl_web_user
		where client_id not in (9,5) and email_id is not null and user_full_name is not null 
		 and is_active =  1
		 and email_id not in (select email_id from isl.isl_web_user 
							 where client_id = 5 and is_verified =  1 and user_full_name is not null)
		) tab)row
		where rn <= 100000 ;
	
	elseif v_opt_type_1 = 8 then
	
		open p_user_cursor for
		select client_mod_json->'data'->'user'->>'dob' as dob_1,
			client_mod_json->'data'->'user'->>'email' as email,
			client_mod_json->'data'->'user'->>'phone' as phone,
			client_mod_json->'data'->'user'->>'firstname' as firstname,
			client_mod_json->'data'->'user'->>'lastname' as lastname,
			client_mod_json->'data'->'user'->>'userFrom' as userFrom,
			client_mod_json->'data'->>'answer' as answer,
			client_mod_json->'data'->'user'->>'favteam' as favteam,
			client_mod_json->'data'->'user'->>'address' as address,
			client_mod_json->'data'->'user'->>'pincode' as pincode,
			(created_date + '5.5 hours'::interval) as created_date
	 from isl.isl_client_web_cust_model
	 where module_name in ('44482','44483','44484','44485','44486')
	 and (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ;
	 
  elseif v_opt_type_1 = 9 then	 
	 
	 open p_user_cursor for
	 select client_mod_json->'data'->'user_info'->>'firstname' as first_name,
     		client_mod_json->'data'->'user_info'->>'lastname' as last_name,
			client_mod_json->'data'->'user_info'->>'email' as email_id,
            client_mod_json->'data'->'user_info'->>'dob' as dob,
			client_mod_json->'data'->'user_info'->>'phone' as mobile_no,
			client_mod_json->'data'->'user_info'->>'pincode' as pincode,			
            client_mod_json->'data'->'user_info'->>'address' as address,
			client_mod_json->'data'->'user_info'->>'userFrom' as city,
			client_mod_json->'data'->>'answer' as answer,
			client_mod_json->'data'->'user_info'->>'favteam' as address_line1,
			module_name
	 from isl.isl_client_web_cust_model
	 where module_name in ('53093','53094','53095','53096','53097','53098','53099');
	
   end if; 
	/*elsif v_opt_type = 2 then
    
		open p_user_cursor for
        select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from isl.isl_user_asset_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from isl.isl_user_asset_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from isl.isl_asset_comment_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join isl.isl_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
		
        elsif v_opt_type = 3 then
        	/*v_start_date_time:= '2019-04-08 20:00:00';
            v_end_date_time := '2019-04-08 23:59:59';
            v_start_date_time := v_start_date_time - '5.5 hours'::interval;
            v_end_date_time := v_end_date_time - '5.5 hours'::interval;*/
    
            open p_user_cursor for
            select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
		user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, uar.comment_text,uar.reaction_date
from isl.isl_user_asset_reaction uar
join isl.isl_web_user wu
on wu.user_id = uar.user_id
left join waf_master.waf_cities c
on c.city_id = wu.city_id
left join waf_master.waf_states s
on s.state_id = wu.state_id
left join waf_master.waf_countries co
on co.country_id = wu.country_id
where uar.asset_id  = 984
and uar.asset_type_id = 1
and uar.reaction_id = 4
and (uar.reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
order by uar.reaction_date;

    elsif v_opt_type = 4 then
    
 open p_user_cursor for   
select b.user_full_name,mobile_no,email_id,c.gift_name ,d.event_name
from isl.isl_gratification_details a
join isl.isl_gratification_gift c on a.gift_id=c.gift_id
join isl.isl_web_user b on a.user_id=b.user_id
join isl.isl_gratification_event d on a.event_id=d.event_id
where a.gift_id <>4
order by 1 desc ;
/*select social_id,social_user_name,user_full_name,count(1) from isl.isl_web_user
where client_id= 2
group by social_id,social_user_name,user_full_name
having count(1)>1;
*/
          */
   -- end if;
 
 
 
 
end;

$$;


--
