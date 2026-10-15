-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labmi_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labmi.labmi_get_user_data
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
	v_season_id numeric ;
	v_is_captain numeric;
	v_is_vice_captain numeric;
	v_count numeric;
	tot_cnt numeric;
	v_poll_id numeric;
	v_poll_id_1 numeric;
	v_json_data jsonb;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    /*select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, 
    social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labmi.labmi_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labmi.labmi_web_user wu
          join labmi.labmi_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labmi.labmi_web_user wu
          join labmi.labmi_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labmi.labmi_web_user wu
          join labmi.labmi_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
         ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id;*/
     
     select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name, user_full_name, email_id, dob,
     		mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count,campaign_id
    from (select user_id, sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
          from (
         select user_id, 0 as reaction_count, 0 as comment_count
          from labmi.labmi_web_user
          where is_verified = 1 and client_id = 5 
		--	  (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
		--	  and 
          union all
          select user_id, count(1) as reaction_count, 0 as comment_count
          from labmi.labmi_user_asset_reaction
          where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
          and reaction_id <> 4
          group by user_id
          union all
          select user_id, 0 as reaction_count, count(1) as comment_count
          from labmi.labmi_user_asset_reaction
          where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
          and reaction_id = 4
          group by user_id
          union all
          select user_id, count(1) as reaction_count, 0 as comment_count
          from labmi.labmi_asset_comment_reaction
          where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
          group by user_id
              ) as tab1
          group by user_id
         ) as tab
         join labmi.labmi_web_user wu
         on wu.user_id = tab.user_id
	left join waf_master.waf_cities c
     on c.city_id = wu.city_id
     left join waf_master.waf_states s
     on s.state_id = wu.state_id
     left join waf_master.waf_countries co
     on co.country_id = wu.country_id where client_id = 5;
 
	elsif v_opt_type = 2 then
    
		open p_user_cursor for
        select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labmi.labmi_user_asset_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labmi.labmi_user_asset_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labmi.labmi_asset_comment_reaction
      		where (reaction_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labmi.labmi_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			where al.asset_type_id = 1
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
from labmi.labmi_user_asset_reaction uar
join labmi.labmi_web_user wu
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
    
  
/* open p_user_cursor for 
select b.user_full_name,mobile_no,email_id,c.gift_name ,d.event_name
from labmi.labmi_gratification_details a
join labmi.labmi_gratification_gift c on a.gift_id=c.gift_id
join labmi.labmi_web_user b on a.user_id=b.user_id
join labmi.labmi_gratification_event d on a.event_id=d.event_id
where a.gift_id <>4
order by 1 desc ;*/
/*select social_id,social_user_name,user_full_name,count(1) from labmi.labmi_web_user
where client_id= 2
group by social_id,social_user_name,user_full_name
having count(1)>1;
*/

select p_input_json->'jsondata'->'guids' into v_json_data;

open p_user_cursor for 
select user_guid,email_id,mobile_no
from labmi.labmi_web_user a,
jsonb_array_elements_text(v_json_data) as b
where  a.user_guid=b.value ;

--select  from labmi.labmi_web_user
--where user_guid in (v_guids);
			

elsif v_opt_type = 5 then
	
		open p_user_cursor for 
        WITH player_cte as (
		select * from crosstab(
							'select user_id,d->>''name'' as name,
					   			btrim(d->>''name'' || case when d->>''is_captain'' = ''true'' then ''(C)''
					   									when d->>''is_wicket_keeper'' = ''true'' then ''(Wk)''
														else '' ''
														end) as player_value
						   from(select jsonb_array_elements(b) d,user_id	   
							   from (select team_json->''players'' b,user_id
				   					from labmi.labmi_user_team
				   					where season_id::numeric = 2020 and week_id = 1 and
            						(created_date + ''5.5 hours''::interval)::date between '''||v_start_date_time::date ||''' and ''' ||v_end_date_time::date ||'''
				   					order by 1 desc) c
			                 )row
		                  order by 1,2')
		AS final_result(user_id numeric, Player_1 TEXT,
					Player_2 TEXT,
					Player_3 TEXT,
					Player_4 TEXT,
					Player_5 TEXT,
				   Player_6 TEXT,
				   Player_7 TEXT,
				   Player_8 TEXT,
				   Player_9 TEXT,
				   Player_10 TEXT,
				   Player_11 TEXT))
				   			   
	select user_full_name, email_id, mobile_no,c.created_date,c.updated_date,d.name as city,Player_1,Player_2,Player_3,Player_4,
	Player_5,Player_6,Player_7,Player_8,Player_9,Player_10,Player_11
	from player_cte
	join labmi.labmi_web_user b on player_cte.user_id=b.user_id
    join labmi.labmi_user_team c on player_cte.user_id=c.user_id
    left join waf_master.waf_cities d on d.city_id = b.city_id;
        
	elsif v_opt_type = 6 then
	
	
		DROP TABLE IF EXISTS cte_tab;

		CREATE TEMP TABLE cte_tab as
		select d->>'name' as name ,d->>'id' as Player_id,
			   d->>'skill_name' as  skill_name,
			   d->>'is_wicket_keeper' as is_wicket_keeper,
			   d->>'is_captain' as is_captain ,
			   d->>'nationality' as nationality ,
			   d->>'nationality_id' as nationality_id
		from(select jsonb_array_elements(b) d
			 from (select team_json->'players' b
				   from labmi.labmi_user_team
				   where season_id::numeric = 2020 and week_id = 1
				   order by 1 desc) c
			)row;
	
	
	       select count(1) into tot_cnt from labmi.labmi_user_team;
		   
			select Player_id, count(1) into v_is_captain, v_count from cte_tab
			where is_captain = 'true'
			group by Player_id 
			order by 2 desc
			limit 1;

           raise notice '%',v_is_captain;
		  -- select 1/0;
		    
			select Player_id, count(1) into v_is_vice_captain, v_count from cte_tab
			where is_wicket_keeper = 'true' 
			and Player_id::numeric <> v_is_captain
			group by Player_id 
			order by 2 desc
			limit 1;
			
			open p_user_cursor for	
			select * from (select * from (
			select * from 
			(select 
			  name,skill_name,
			  1 as is_captain,
			  0 as is_wicket_keeper,
			 count(1)   ,
			round( ((count(1)*100)/ tot_cnt),2) AS percentage
			from cte_tab
			where Player_id::numeric = v_is_captain
			group by Player_id,name,skill_name,nationality_id::numeric
			order by 6 desc
			limit 1) tab
			union all
			select * from 
			(select 
			 name,skill_name,
			  0 as is_captain,
			  1 as is_wicket_keeper,count(1)  ,
			 round(((count(1)*100)/ tot_cnt),2) AS percentage
			from cte_tab
			where Player_id::numeric = v_is_vice_captain
			group by Player_id,name,skill_name,nationality_id::numeric
			order by 6 desc
			limit 1) tab_1
			union all
			select * from 
			(select name,skill_name, 0 as is_captain,
			  0 as is_wicket_keeper,count(1) ,
			round(((count(1)*100)/ tot_cnt),2) AS percentage
			 from cte_tab
			where Player_id::numeric not in (v_is_vice_captain,v_is_captain)
			group by Player_id,name,skill_name ,nationality_id::numeric
			order by 6 desc
			limit 9
			) tab_2
			)tab_3
			order by case when skill_name='Batsman' then 0 
						  when is_wicket_keeper=1 or skill_name='Wicket-Keeper'  then 1
			              when skill_name='All-Rounder' then 2   
						  when skill_name='Batsman' then 3 end ,percentage desc
			)row;
			
			
		elsif v_opt_type = 7 then	
			
			DROP TABLE IF EXISTS cte_tab;

		CREATE TEMP TABLE cte_tab as
		select d->>'name' as name ,d->>'id' as Player_id,
			   d->>'skill_name' as  skill_name,
			   d->>'is_wicket_keeper' as is_wicket_keeper,
			   d->>'is_captain' as is_captain ,
			   d->>'nationality' as nationality ,
			   d->>'nationality_id' as nationality_id
		from(select jsonb_array_elements(b) d
			 from (select team_json->'players' b
				   from labmi.labmi_user_team
				   where season_id::numeric = 2020 and week_id = 1
				   order by 1 desc) c
			)row;
	
	
	       select count(1) into tot_cnt from labmi.labmi_user_team;
		   
		   open p_user_cursor for
		   select name,skill_name,count(1),
			 round(((count(1)*100)/ tot_cnt),2) AS percentage
			from cte_tab
			group by name,skill_name
			order by 4 desc;
            
     elsif v_opt_type = 8 then 
     
     open p_user_cursor for
     select user_full_name, email_id, dob,
     mobile_no, gender, c.name as city, s.name as state,(created_date + '5.5 hours'::interval) as created_date,is_verified
     from labmi.labmi_web_user wu
	left join waf_master.waf_cities c
     on c.city_id = wu.city_id
     left join waf_master.waf_states s
     on s.state_id = wu.state_id
     left join waf_master.waf_countries co
     on co.country_id = wu.country_id
     where client_id =5 and (created_date + '5.5 hours'::interval)::date between v_start_date_time::date and v_end_date_time::date ;
     
     
   /*  open p_user_cursor for
     select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
		user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country
        from labmi.labmi_web_user wu
        left join waf_master.waf_cities c
        on c.city_id = wu.city_id
        left join waf_master.waf_states s
        on s.state_id = wu.state_id
        left join waf_master.waf_countries co
        on co.country_id = wu.country_id
        where (wu.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ;

      */
    elsif v_opt_type = 9 then
    
    open p_user_cursor for
	select client_mod_json->'data'->'user_data'->>'age' as age,
		client_mod_json->'data'->'user_data'->>'city' as city,
		client_mod_json->'data'->'user_data'->>'year' as year,
		client_mod_json->'data'->'user_data'->>'gender' as gender,
		client_mod_json->'data'->'user_data'->>'1_Rank1' as Rank1_1,
		client_mod_json->'data'->'user_data'->>'1_Rank2' as Rank2_1,
		client_mod_json->'data'->'user_data'->>'1_Rank3' as Rank3_1,
		-- client_mod_json->'data'->'user_data'->>'1_Rank4' as Rank4_1,
		-- client_mod_json->'data'->'user_data'->>'1_Rank5' as Rank5_1,
		-- client_mod_json->'data'->'user_data'->>'6_Rank1' as Rank1_6,
		-- client_mod_json->'data'->'user_data'->>'6_Rank2' as Rank2_6,
		-- client_mod_json->'data'->'user_data'->>'6_Rank3' as Rank3_6,
		-- client_mod_json->'data'->'user_data'->>'6_Rank4' as Rank4_6,
		-- client_mod_json->'data'->'user_data'->>'6_Rank5' as Rank5_6,
		client_mod_json->'data'->'user_data'->>'8_Rank1' as Rank1_8,
		client_mod_json->'data'->'user_data'->>'8_Rank2' as Rank2_8,
		client_mod_json->'data'->'user_data'->>'8_Rank3' as Rank3_8,
		-- client_mod_json->'data'->'user_data'->>'8_Rank4' as Rank4_8,
		-- client_mod_json->'data'->'user_data'->>'8_Rank5' as Rank5_8,		
		-- client_mod_json->'data'->'user_data'->>'10_Rank1' as Rank1_10,
		-- client_mod_json->'data'->'user_data'->>'10_Rank2' as Rank2_10,
		-- client_mod_json->'data'->'user_data'->>'10_Rank3' as Rank3_10,
		-- client_mod_json->'data'->'user_data'->>'10_Rank4' as Rank4_10,
		-- client_mod_json->'data'->'user_data'->>'10_Rank5' as Rank5_10,		
		client_mod_json->'data'->'user_data'->>'15_brands' as brands_15,
		client_mod_json->'data'->'user_data'->>'9_miAppRating' as miAppRating_9,
		client_mod_json->'data'->'user_data'->>'completeSurvey' as completeSurvey,
		client_mod_json->'data'->'user_data'->>'3_supportReason' as supportReason_3,
		client_mod_json->'data'->'user_data'->>'3_supportReasonOther' as supportReasonOther_3,
		client_mod_json->'data'->'user_data'->>'4_favoritePlayer' as favoritePlayer_4,	
		client_mod_json->'data'->'user_data'->>'4_favoritePlayerOther' as favoritePlayerOther_4,
		client_mod_json->'data'->'user_data'->>'2_gifWhileChatting' as gifWhileChatting_2,
		client_mod_json->'data'->'user_data'->>'12_mitvVideoDuration' as mitvVideoDuration_12,
		client_mod_json->'data'->'user_data'->>'13_mitvVideoLanguage' as mitvVideoLanguage_13,
		client_mod_json->'data'->'user_data'->>'18_updatesOnWhatsapp' as updatesOnWhatsapp_18,
		client_mod_json->'data'->'user_data'->>'20_podcastsListening' as podcastsListening_10,		
		client_mod_json->'data'->'user_data'->'19_onlineGamesPlaying' as onlineGamesPlaying_19,
		client_mod_json->'data'->'user_data'->>'19_onlineGamesPlayingOther' as onlineGamesPlayingOther_19,
		client_mod_json->'data'->'user_data'->'10_enjoyMITV' as enjoyMITV_10,
		client_mod_json->'data'->'user_data'->'6_typeOfContent' as typeOfContent_6,
		client_mod_json->'data'->'user_data'->'11_mitvPlatformPreference' as mitvPlatformPreference_11,
		client_mod_json->'data'->'user_data'->>'5_websiteVisitFrequency' as websiteVisitFrequency_5,		
		client_mod_json->'data'->'user_data'->>'17_miMembershipIntereset' as miMembershipIntereset_17,
		client_mod_json->'data'->'user_data'->>'21_miCampaignCurrentTheme' as miCampaignCurrentTheme_21,
		client_mod_json->'data'->'user_data'->>'16_fantasyPredictorPlaying' as fantasyPredictorPlaying_16,
		client_mod_json->'data'->'user_data'->>'7_socialMediaInteraction_8' as socialMediaInteraction_8_7,
		client_mod_json->'data'->'user_data'->>'14_miShopMerchandisePurchased' as miShopMerchandisePurchased_14,
		client_mod_json->'data'->'user_data'->>'22_miJuniorInterschoolAwareness' as miJuniorInterschoolAwareness_22		
		from labmi.labmi_client_web_cust_model
		where created_date between v_start_date_time::date and v_end_date_time::date
		order by custom_module_id desc;
	
	elsif v_opt_type = 10 then
    
    	open p_user_cursor for
		select wu.user_full_name,wu.user_id,wu.email_id,
		case  campaign_id when 1 then 'Blue' when 3 then 'silver' 
		when 4 then 'Gold' else 'Not a Member' end as Membership,
		wb.mobile_no,coalesce(sum(p.quiz_points),0) score from labmi.labmi_poll p
		left join labmi.labmi_whatsapp_bot_quiz_ans_history wb on p.poll_id = wb.poll_id
		left join labmi.labmi_poll_option po on wb.answer = po.poll_option_id
		left join labmi.labmi_web_user wu on wb.mobile_no = wu.mobile_no 
					and wu.client_id = 5 and wu.is_active = 1 and wu.is_verified = 1 and wu.mobile_verified = 1
		where  po.is_ans =1 and ((wb.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time)
		group by 1,2,3,4,5
		order by 2 desc;
		
	elsif v_opt_type = 11 then
	
	    open p_user_cursor for
		select wu.user_full_name,wu.mobile_no,p1.product_name from labmi.labmi_product_cart_paydetails p
		left join labmi.labmi_product_cart pc on p.product_cart_id = pc.product_cart_id
		left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
		left join labmi.labmi_product p1 on pc.product_id = p1.product_id
		where p.order_status = 'SUCCESS' and (pc.cart_json->'data'->'shipmentadd'->>'whatsapp_consent')::numeric = 1
		union all 
		select wu.user_full_name,wu.mobile_no,p1.product_name from labmi.labmi_web_user wu
		left join labmi.labmi_product p1 on wu.campaign_id = p1.product_id
		where wu.whatsapp_consent = 1 and wu.is_verified = 1 and wu.campaign_id=1
		order by product_name ;
		
	elsif v_opt_type = 12 then	
		
		open p_user_cursor for
		select wu.user_full_name,wu.email_id,wu.mobile_no,wu.gender,wu.dob,c.name as city,
		case  campaign_id when 1 then 'Blue' when 3 then 'silver' when 4 then 'Gold' end as Membership
		,row.* from
		(select
			client_mod_json->'data'->'user_data'->>'year' as year,
			client_mod_json->'data'->'user_data'->>'6_Rank1' as Rank1_6,
			client_mod_json->'data'->'user_data'->>'6_Rank2' as Rank2_6,
			client_mod_json->'data'->'user_data'->>'6_Rank3' as Rank3_6,
			client_mod_json->'data'->'user_data'->>'9_Rank1' as Rank1_9,
			client_mod_json->'data'->'user_data'->>'9_Rank2' as Rank2_9,
			client_mod_json->'data'->'user_data'->>'9_Rank3' as Rank3_9,
			client_mod_json->'data'->'user_data'->>'11_Rank1' as Rank1_11,
			client_mod_json->'data'->'user_data'->>'11_Rank2' as Rank2_11,
			client_mod_json->'data'->'user_data'->>'11_Rank3' as Rank3_11,
			client_mod_json->'data'->'user_data'->'8_Hashtags' as Hashtags_8,
			client_mod_json->'data'->'user_data'->>'22_600Extra' as Extra_600_22,
			client_mod_json->'data'->'user_data'->>'24_999Extra' as Extra_999_24,
			client_mod_json->'data'->'user_data'->>'25_2999Extra' as Extra_2999_25,
			client_mod_json->'data'->'user_data'->>'19_WhatsappBot' as WhatsappBot_19,
			client_mod_json->'data'->'user_data'->>'completeSurvey' as completeSurvey,
			client_mod_json->'data'->'user_data'->>'3_ConnectedScale' as ConnectedScale_3,
			client_mod_json->'data'->'user_data'->>'17_GalaxyPaltanPlay' as GalaxyPaltanPlay_17,
			client_mod_json->'data'->'user_data'->>'18_UshaWrongContest' as UshaWrongContest_18,
			client_mod_json->'data'->'user_data'->>'20_ShopSectionVisit' as ShopSectionVisit_20,
			client_mod_json->'data'->'user_data'->>'21_WhichOtherMIMerc' as WhichOtherMIMerc_21,
			client_mod_json->'data'->'user_data'->>'12_GifsWhileChatting' as GifsWhileChatting_12,
			client_mod_json->'data'->'user_data'->>'23_SilverGoldUpgrade' as SilverGoldUpgrade_23,
			client_mod_json->'data'->'user_data'->>'15_WatchMITVLiveShows' as WatchMITVLiveShows_15,
			client_mod_json->'data'->'user_data'->>'1_MainReasonToSupport' as MainReasonToSupport_1,
			client_mod_json->'data'->'user_data'->'14_TypeOfContentOnSite' as TypeOfContentOnSite_14,
			client_mod_json->'data'->'user_data'->>'16_MILiveRecommendations' as MILiveRecommendations_18,
			client_mod_json->'data'->'user_data'->>'21_WhichOtherMIMercOther' as WhichOtherMIMercOther_21,
			client_mod_json->'data'->'user_data'->>'26_OnePieceOfMerchandise' as OnePieceOfMerchandise_26,
			client_mod_json->'data'->'user_data'->>'5_SponsorThatComesToMind' as SponsorThatComesToMind_5,
			client_mod_json->'data'->'user_data'->>'13_HowOftenDoYouVisitSite' as HowOftenDoYouVisitSite_13,
			client_mod_json->'data'->'user_data'->>'4_KeyMessageDuringIpl2020' as KeyMessageDuringIpl2020_4,
			client_mod_json->'data'->'user_data'->>'1_MainReasonToSupportOther' as MainReasonToSupportOther_1,
			client_mod_json->'data'->'user_data'->'10_TypesOfVideosEnjoyedOnMITV' as TypesOfVideosEnjoyedOnMITV_10,
			client_mod_json->'data'->'user_data'->>'27_OverallMembershipExperience' as OverallMembershipExperience_27,
			client_mod_json->'data'->'user_data'->>'2_PlayerWhoImpressedYouTheMost' as PlayerWhoImpressedYouTheMost_2,
			client_mod_json->'data'->'user_data'->>'7_HowOftenInteractOnSocialMedia' as HowOftenInteractOnSocialMedia_7,
			client_mod_json->'data'->'user_data'->>'2_PlayerWhoImpressedYouTheMostOther' as PlayerWhoImpressedYouTheMostOther_2,
			client_mod_json->'data'->>'user_guid' user_guid, 
			created_date
			from labmi.labmi_client_web_cust_model
			where created_date >= '2020-12-12' 
			order by custom_module_id desc
			) row
			left join labmi.labmi_web_user wu on row.user_guid = wu.user_guid
			left join waf_master.waf_cities c on c.city_id = wu.city_id
			where row.created_date between v_start_date_time::date and v_end_date_time::date;
			
     elsif v_opt_type = 13 then
	 
	        open p_user_cursor for
	 		select a.mobile_no,a.email_id,a.dob,a.gender,a.favorite_player,
			case  campaign_id when 1 then 'Blue' when 3 then 'silver' when 4 then 'Gold' else 'Not a Member' end as Membership
			from labmi.labmi_whatsapp_bot_user a
			left join labmi.labmi_web_user wu on a.mobile_no = wu.mobile_no
			;
	elsif v_opt_type = 14 then
			 
			 open p_user_cursor for
			/* select wu.user_full_name,wu.email_id,wu.mobile_no,p1.product_name,u.shipment_address1 as address_line1,
			        u.shipment_address2 as address_line2 ,u.billing_landmark as address, u.shipment_pincode as pincode,s1.name as state,
					c1.name as city 
		     from labmi.labmi_product_cart_paydetails_archive p
			 left join labmi.labmi_product_cart_archive pc on p.product_cart_id = pc.product_cart_id
		     left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
			 left join labmi.labmi_product p1 on pc.product_id = p1.product_id
			 left join labmi.labmi_product_shipment_user_archive u on u.product_cart_id = pc.product_cart_id 
			 left join waf_master.waf_cities c1 on u.shipment_city_id=c1.city_id
		     left join waf_master.waf_states s1 on u.shipment_state_id=s1.state_id 
		     left join waf_master.waf_countries d on u.shipment_country_id=d.country_id 
		     where p.order_status = 'SUCCESS';	*/
			 select a.*
   from (select  distinct  
          ab.product_cart_id,
          shipment_name,
          shipment_address1,
          shipment_address2,
		 wu.user_full_name,
          -- shipment_state,
          -- shipment_city,
          shipment_pincode,  
		  -- shipment_mobile_no,
		 -- c.discount_percent as discount_percentage,		  
		  total_price as bill_amount,
         --  ab.bill_amount as base_price,
		  ab.billing_name,
		 -- ab.billing_address1,
		 -- ab.billing_address2,
		  --ab.billing_state,
		  --ab.billing_city,
		  --ab.billing_country,
		  ab.billing_pincode,
		  wu.mobile_no as billing_mobile_no,
          wc.name as city_name,
          ws.name as state_name,
          ab.billing_landmark as landmark,
		  wu.email_id,
		 -- ab.service_provider,
		  --ab.date_of_dispatch,
		  --ab.aw_bill_number,
		 -- ab.courier_status,
          --ab.received_by,
		  --- ab.remarks,
		  c.delivery_charges,
		  c.name_on_card,
		   p.product_name  as  membership_type,
		(select count(1)  from labmi.labmi_product_cart_details
        where is_customize=1 and product_cart_id=ab.product_cart_id
		 and is_active=0) as custmize_flag,
        --order_tracking_status,
		ab.updated_date,
		-- order_tracking_id,
		-- ord_tracking_status_value,
          order_status,
          b.status_message,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.status_message as jio_response,
		  b.bank_ref_no as transaction_id,
		  round(ab.taxes/2,2) as CGST,
		  round(ab.taxes/2,2) as SGST,
		  round(ab.taxes,2) as GST,
		  case c.product_id  when 3 then 846.60
						when 4 then 2541.52 end as base_amount,
		  (ab.bill_amount - round(ab.taxes,2)) as base_price,
		 -- b.customer_note,
		  coalesce (b.note_status,0) as note_status,
		is_status_flag as order_status_value,
          tracking_id, 
		  cart_json->'data'->'cartdetails' as cartdetails,
          payment_json->'data'->>'transaction_timestamp' as transaction_date,
		  to_date(left(payment_json->'data'->>'transaction_timestamp',8),'YYYYMMDD') as transaction_date_1,
		(
          select array_to_json(array_agg(tab)) from (
           select 
			a.quantity,
			b.product_id,
            coalesce(a.product_price,0) + coalesce(a.customize_price,0)  as total_price,
            b.product_price as unit_price,
            c.product_name  as  product_name,
             f.customize_name||a.customize_text
              as  customize_text,
             coalesce(f.custmize_prize,0)  as customize_price,		  
            e.product_customize_map_id,
            f.customize_name,
            ( select array_to_json(array_agg(row)) 
             from ( 
             select  d.specification_name,
             e.attribute_name from labmi.labmi_product_attribute_specification d
            join labmi.labmi_product_attribute e on d.product_attribute_id=e.product_attribute_id
            where product_attribute_specification_id =any(attribute_specification_ids))row) as attributes
           from labmi.labmi_product_cart_details_archive a
           join labmi.labmi_product_sku b on a.product_sku_id=b.product_sku_id
           join labmi.labmi_product c on c.product_id=b.product_id 
           join labmi.labmi_product_cart_archive d on a.product_cart_id=d.product_cart_id
           left join labmi.labmi_product_customize_map e on e.product_customize_map_id=a.product_customize_map_id
           left join  labmi.labmi_product_customize f on f.product_customize_id=e.product_customize_id
         
           where a.product_cart_id in (ab.product_cart_id)
               and a.is_deleted=0 and a.is_active=1  
              
             )tab)::text as  products
           ---
           from labmi.labmi_product_shipment_user_archive ab
           join labmi.labmi_product_cart_paydetails_archive b on b.product_cart_id=ab.product_cart_id
           join labmi.labmi_product_cart_archive c on b.product_cart_id=c.product_cart_id
		   join labmi.labmi_product p on c.product_id=p.product_id
		   join labmi.labmi_web_user wu on c.user_guid= wu.user_guid
		   join waf_master.waf_cities wc on ab.shipment_city_id = wc.city_id
           join waf_master.waf_states ws on ab.shipment_state_id =  ws.state_id and ws.country_id = 101
           where 1=1 and is_status_flag= 1)a;
			 
	elsif v_opt_type = 15 then
	
-- 	open p_user_cursor for		 
-- 	select a.user_full_name,a.email_id,a.mobile_no,coalesce(s.name,'NA')as state,coalesce(c.name,'NA')as city
-- 	from labmi.labmi_web_user  a
-- 	left join waf_master.waf_cities c on a.city_id=c.city_id
-- 	left join waf_master.waf_states s on a.state_id=s.state_id
-- 	left join labmi.labmi_membership_coupon_code mcc on a.user_guid = mcc.user_guid
-- 	where coalesce(a.old_campaign_id,1) = 1 and is_verified = 1 and client_id = 5 and (a.user_full_name is not null or a.email_id is not null or a.mobile_no is not null )
-- 	and a.created_date between v_start_date_time::date and v_end_date_time::date;
open p_user_cursor for
	select a.user_full_name,a.email_id,a.mobile_no,coalesce(a.dob,'RaZ+IaoOzIbP75pPlnAcNQ==')as dob,a.gender,coalesce(s.name,null)as statename,coalesce(c.name,null)as cityname,
	'Blue Tier Membership' as product_name,(a.created_date + '5.5 hours'::interval)::date as Membership_date,(a.created_date + '5.5 hours'::interval)::date as registration_date,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as first_name,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as name_on_card,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as shipment_name,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as shipment_address1,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as shipment_address2,
	'RaZ+IaoOzIbP75pPlnAcNQ==' as shipment_pincode,
	a.pin_code,
	null size,
	null product
	from labmi.labmi_web_user  a
	left join waf_master.waf_cities c on a.city_id=c.city_id
	left join waf_master.waf_states s on a.state_id=s.state_id
	--join cte_tab_blue t on a.user_guid = t.user_guid
	where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	and is_verified = 1 and  client_id = 5 and a.mobile_no is not null and a.campaign_id not in (3,4,5);
	
	elsif v_opt_type = 16 then
	
	select poll_id into v_poll_id from labmi.labmi_poll
	where is_whatsappquiz =1
	order by 1 desc
	limit 1;
	
	select asset_id into v_poll_id_1 from labmi.labmi_asset_entity_map
	where entity_role_map_id in 
	(select entity_role_map_id from labmi.labmi_asset_entity_map
	where asset_id = v_poll_id and asset_type_id = 6 and entity_role_map_id not in (2222,5,2,2882))
	and asset_type_id = 6 and asset_id <> v_poll_id ;
	
	open p_user_cursor for
	
	select wu.user_full_name,wu.email_id,wu.mobile_no,po.option::jsonb->>'player' as player, coalesce (pr.marriott_bonvoy_user,pr1.marriott_bonvoy_user,'NA') marriott_bonvoy_user, case wu.campaign_id when 1 then 'blue' when 3 then 'silver' when 4 then 'gold' end as membership_type  
	from labmi.labmi_user_poll_response pr
	left join labmi.labmi_web_user wu on pr.user_id = wu.user_id 
	join labmi.labmi_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id = po.poll_option_id
	left join labmi.labmi_user_poll_response pr1 on pr.user_id = pr1.user_id and pr1.poll_id = v_poll_id_1
	where pr.poll_id = v_poll_id;
	
	elsif v_opt_type = 17 then
	
	open p_user_cursor for
	select a.user_full_name,a.email_id,a.mobile_no,a.dob,a.gender,coalesce(s.name,'NA')as state,coalesce(c.name,'NA')as city
	from labmi.labmi_web_user  a
	left join waf_master.waf_cities c on a.city_id=c.city_id
	left join waf_master.waf_states s on a.state_id=s.state_id
	where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	and is_verified = 1 and  client_id =5;
	
	elsif v_opt_type = 18 then
	open p_user_cursor for
	with cte_data as ( select a.asset_id, a.asset_type_id,count(1) total 
  from labmi.labmi_user_asset_reaction a
  join labmi.labmi_asset_entity_map ae on a.asset_id = ae.asset_id and a.asset_type_id = ae.asset_type_id			  
  where a.reaction_id is not null and ae.entity_role_map_id = 2882
  group by a.asset_id, a.asset_type_id
  order by total desc)
  
select *
from (select  al.asset_title,
              case  al.asset_type_id  when 1 then 'article' when 2 then 'album' when 4 then 'video' else 'NA' end as post_type,
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=1)as Heart,
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=2)as Broken_Heart,
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=3)as Like,
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=4)as Comment
     from cte_data a
    left join labmi.labmi_asset_list al on a.asset_id=al.asset_id and a.asset_type_id= al.asset_type_id
     )tab;
	 
	elsif v_opt_type = 19 then
	DROP TABLE IF EXISTS cte_tab;

	CREATE TEMP TABLE cte_tab as	
	select wu.user_guid,p1.product_name,(p.created_date + '5.5 hours'::interval)::date as Membership_date,
	(wu.created_date + '5.5 hours'::interval)::date as registration_date,pc.membership_owner,pc.name_on_card,
	shipment_name,shipment_address1,shipment_address2,shipment_pincode,wc.name as city_name,
			  ws.name as state_name,jsonb_array_elements(cart_json->'data'->'cartdetails')->>'size' as size,
			  jsonb_array_elements(cart_json->'data'->'cartdetails')->>'customize_text' as product
	from labmi.labmi_product_cart_paydetails p
	left join labmi.labmi_product_cart pc on p.product_cart_id = pc.product_cart_id
	left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
	left join labmi.labmi_product p1 on pc.product_id = p1.product_id
	left join labmi.labmi_product_shipment_user su on p.product_cart_id=su.product_cart_id
	left join waf_master.waf_cities wc on su.shipment_city_id = wc.city_id
	left join waf_master.waf_states ws on su.shipment_state_id =  ws.state_id and ws.country_id = 101
	where p.order_status = 'SUCCESS'  ;
	
	open p_user_cursor for
	select a.user_full_name,a.email_id,a.mobile_no,coalesce(a.dob,'RaZ+IaoOzIbP75pPlnAcNQ==')as dob,a.gender,coalesce(s.name,state_name)as state_name,coalesce(c.name,city_name)as city_name,
	coalesce(product_name,'Blue Tier Membership') as product_name,coalesce(Membership_date,(a.created_date + '5.5 hours'::interval)::date) as Membership_date,(a.created_date + '5.5 hours'::interval)::date as registration_date,
	coalesce(membership_owner,'RaZ+IaoOzIbP75pPlnAcNQ==') as first_name,
	coalesce(name_on_card,'RaZ+IaoOzIbP75pPlnAcNQ==') as name_on_card,
	coalesce(shipment_name,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_name,
	coalesce (shipment_address1,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address1,
	coalesce(shipment_address2,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address2,
	coalesce (shipment_pincode,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_pincode,
	size,
	product
	from labmi.labmi_web_user  a
	left join waf_master.waf_cities c on a.city_id=c.city_id
	left join waf_master.waf_states s on a.state_id=s.state_id
	left join cte_tab t on a.user_guid = t.user_guid
	where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	and is_verified = 1 and  client_id = 5;
	/*
	select wu.user_guid,p1.product_name,(p.created_date + '5.5 hours'::interval)::date as Membership_date,
	(wu.created_date + '5.5 hours'::interval)::date as registration_date,pc.membership_owner,pc.name_on_card,
	shipment_name,shipment_address1,shipment_address2,shipment_pincode,wc.name as city_name,
			  ws.name as state_name,jsonb_array_elements(cart_json->'data'->'cartdetails')->>'size' as size,
			  jsonb_array_elements(cart_json->'data'->'cartdetails')->>'customize_text' as product
	from labmi.labmi_product_cart_paydetails p
	left join labmi.labmi_product_cart pc on p.product_cart_id = pc.product_cart_id
	left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
	left join labmi.labmi_product p1 on pc.product_id = p1.product_id
	left join labmi.labmi_product_shipment_user su on p.product_cart_id=su.product_cart_id
	left join waf_master.waf_cities wc on su.shipment_city_id = wc.city_id
	left join waf_master.waf_states ws on su.shipment_state_id =  ws.state_id and ws.country_id = 101
	where p.order_status = 'SUCCESS';*/

elsif v_opt_type = 22  then

open p_user_cursor for
SELECT bkg_id as bookingId, app_name as appName, venue_name as venueName, 
event_title as eventName, trans_date as transactionDateTime, show_date as showDateTime,
ticket_qty as totalTicketQuantity, ticket_amt as totalTicketAmount,
ticket_price as ticketPrice, category as categoryName, customer_mail_id as emailId, 
customer_mobile_number as mobileNumber,status as paymentStatus,
 add_info->>'seatInfo' as seatInfo,
add_info->>'firstName' as firstName,add_info->>'lastName' as lastName,
add_info->>'hdPinCode' as hdPinCode,add_info->>'address' as address,
add_info->>'city' as city,add_info->>'state' as state
FROM labmi.labmi_bms_booking
order by trans_date desc;

elsif v_opt_type = 23 then

DROP TABLE IF EXISTS cte_tab;

	CREATE TEMP TABLE cte_tab as	
	select p.tracking_id::text,p.invoice_id,wu.user_guid,p1.product_name,(p.created_date + '5.5 hours'::interval)::date as Membership_date,
	(wu.created_date + '5.5 hours'::interval)::date as registration_date,pc.membership_owner,pc.name_on_card,
	shipment_name,shipment_address1,shipment_address2,shipment_pincode,wc.name as city_name,
			  ws.name as state_name,
			 jsonb_array_elements(case cart_json->'data'->'cartdetails'::text when '[]' then  
			 '[ {"size": "NA"}]'::jsonb else 
			cart_json->'data'->'cartdetails' end)->>'size' as size,
			 coalesce(customize_text,'NA') as product,
			p.payment_guid
	from labmi.labmi_product_cart_paydetails p
	left join labmi.labmi_product_cart_details pcp on p.product_cart_id = pcp.product_cart_id
	left join labmi.labmi_product_cart pc on p.product_cart_id = pc.product_cart_id
	left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
	left join labmi.labmi_product p1 on pc.product_id = p1.product_id
	left join labmi.labmi_product_shipment_user su on p.product_cart_id=su.product_cart_id
	left join waf_master.waf_cities wc on su.shipment_city_id = wc.city_id
	left join waf_master.waf_states ws on su.shipment_state_id =  ws.state_id and ws.country_id = 101
	where p.order_status = 'SUCCESS';
	
	open p_user_cursor for
	select t.tracking_id::text,t.invoice_id,a.user_full_name,a.email_id,a.mobile_no,coalesce(a.dob,'RaZ+IaoOzIbP75pPlnAcNQ==')as dob,a.gender,coalesce(s.name,state_name)as statename,coalesce(c.name,city_name)as cityname,
        case when coalesce (a.is_free_membership,0)=1 then
        --Membership without buying user gets by contest winning or other factors.
   p.product_name||'(Free Membership)' else
    coalesce(t.product_name,'Blue Tier Membership') end as product_name,
    coalesce(Membership_date,(a.created_date + '5.5 hours'::interval)::date) as Membership_date,
    (a.created_date + '5.5 hours'::interval)::date as registration_date,
	coalesce(membership_owner,'RaZ+IaoOzIbP75pPlnAcNQ==') as first_name,
	coalesce(name_on_card,'RaZ+IaoOzIbP75pPlnAcNQ==') as name_on_card,
	coalesce(shipment_name,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_name,
	coalesce (shipment_address1,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address1,
	coalesce(shipment_address2,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address2,
	coalesce (shipment_pincode,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_pincode,
	a.pin_code,
	size,
	product,
	t.payment_guid as invoice_guid
	from labmi.labmi_web_user  a
    left join labmi.labmi_product p on p.product_id=a.campaign_id
	left join waf_master.waf_cities c on a.city_id=c.city_id
	left join waf_master.waf_states s on a.state_id=s.state_id
	left join cte_tab t on a.user_guid = t.user_guid
	where (((a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time )
	      or ((Membership_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ))
	and is_verified = 1 and  client_id = 5;
    
elsif v_opt_type = 24 then
open p_user_cursor for
		select user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state,
		to_char((wu.created_date + '5.5 hours'::interval)::date, 'DD-MM-YYYY') Website_registration_date,
		--(wu.created_date + '5.5 hours'::interval)::date as Website_registration_date , 
		coalesce(wu.whatsapp_consent,0) as whatsapp_consent,
		case campaign_id when 1 then 'Blue Tier Membership'
						 when 3 then 'Silver Tier Membership'
						  when 4 then 'Gold Tier Membership'
						  when 5 then 'Junior Tier Membership' else 'Blue Tier Membership'  end as membership_type,				  
		--(pc.created_date + '5.5 hours'::interval)::date as membership_purchase_date,
		to_char((pc.created_date + '5.5 hours'::interval)::date, 'DD-MM-YYYY') membership_purchase_date,
		p.total_price as membership_price ,name_on_card,wu.pin_code,wu.user_guid,pc.product_cart_id,
		case old_campaign_id when 1 then 'Blue Tier Membership'
						 when 3 then 'Silver Tier Membership'
						  when 4 then 'Gold Tier Membership'
						  when 5 then 'Junior Tier Membership' else 'Blue Tier Membership'  end as old_membership_type
		from labmi.labmi_web_user wu
		left join waf_master.waf_cities c on c.city_id = wu.city_id
		left join waf_master.waf_states s on s.state_id = wu.state_id
		left join labmi.labmi_product_cart_paydetails pc on  wu.user_guid = pc.user_guid and pc.order_status = 'SUCCESS'
		left join labmi.labmi_product_cart p on pc.product_cart_id = p.product_cart_id
		where client_id = 5 and wu.is_active = 1  and is_verified  = 1 ;

elsif v_opt_type = 25 then

DROP TABLE IF EXISTS cte_tab;
	DROP TABLE IF EXISTS cte_tab1;

	CREATE TEMP TABLE cte_tab as	
	select wu.user_guid,p1.product_name,(p.created_date + '5.5 hours'::interval)::date as Membership_date,
	(wu.created_date + '5.5 hours'::interval)::date as registration_date,pc.membership_owner,pc.name_on_card,
	shipment_name,shipment_address1,shipment_address2,shipment_pincode,wc.name as city_name,
			  ws.name as state_name,
			 jsonb_array_elements(case cart_json->'data'->'cartdetails'::text when '[]' then  
			 '[ {"size": "NA"}]'::jsonb else 
			cart_json->'data'->'cartdetails' end)->>'size' as size,
			 coalesce(customize_text,'NA') as product
			  --jsonb_array_elements(cart_json->'data'->'cartdetails')->>'size' as size,
			  --jsonb_array_elements(cart_json->'data'->'cartdetails')->>'customize_text' as product
	from labmi.labmi_product_cart_paydetails p
	left join labmi.labmi_product_cart_details pcp on p.product_cart_id = pcp.product_cart_id
	left join labmi.labmi_product_cart pc on p.product_cart_id = pc.product_cart_id
	left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
	left join labmi.labmi_product p1 on pc.product_id = p1.product_id
	left join labmi.labmi_product_shipment_user su on p.product_cart_id=su.product_cart_id
	left join waf_master.waf_cities wc on su.shipment_city_id = wc.city_id
	left join waf_master.waf_states ws on su.shipment_state_id =  ws.state_id and ws.country_id = 101
	where p.order_status = 'SUCCESS'  ;
	
	CREATE TEMP TABLE cte_tab1 as	
	select wu.user_full_name,wu.email_id,wu.mobile_no,wu.dob,wu.gender,ws.name as state_name,
	wc.name as city_name,p1.product_name,(p.created_date + '5.5 hours'::interval)::date as Membership_date,
	(wu.created_date + '5.5 hours'::interval)::date as registration_date,pc.membership_owner as first_name,pc.name_on_card,
	shipment_name,shipment_address1,shipment_address2,shipment_pincode,wu.pin_code,
			 jsonb_array_elements(case cart_json->'data'->'cartdetails'::text when '[]' then  
			 '[ {"size": "NA"}]'::jsonb else 
			cart_json->'data'->'cartdetails' end)->>'size' as size,
			 coalesce(customize_text,'NA') as product
			  --jsonb_array_elements(cart_json->'data'->'cartdetails')->>'size' as size,
			  --jsonb_array_elements(cart_json->'data'->'cartdetails')->>'customize_text' as product
	from labmi.labmi_product_cart_paydetails_archive p
	left join labmi.labmi_product_cart_details_archive pcp on p.product_cart_id = pcp.product_cart_id
	left join labmi.labmi_product_cart_archive pc on p.product_cart_id = pc.product_cart_id
	left join labmi.labmi_web_user wu on pc.user_guid = wu.user_guid 
	left join labmi.labmi_product p1 on pc.product_id = p1.product_id
	left join labmi.labmi_product_shipment_user_archive su on p.product_cart_id=su.product_cart_id
	left join waf_master.waf_cities wc on su.shipment_city_id = wc.city_id
	left join waf_master.waf_states ws on su.shipment_state_id =  ws.state_id and ws.country_id = 101
	where p.order_status = 'SUCCESS' and (((wu.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time )
	      or ((p.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ));
	
	open p_user_cursor for
	((select a.user_full_name,a.email_id,a.mobile_no,coalesce(a.dob,'RaZ+IaoOzIbP75pPlnAcNQ==')as dob,a.gender,coalesce(s.name,state_name)as statename,coalesce(c.name,city_name)as cityname,
	coalesce(product_name,'Blue Tier Membership') as product_name,coalesce(Membership_date,(a.created_date + '5.5 hours'::interval)::date) as Membership_date,(a.created_date + '5.5 hours'::interval)::date as registration_date,
	coalesce(membership_owner,'RaZ+IaoOzIbP75pPlnAcNQ==') as first_name,
	coalesce(name_on_card,'RaZ+IaoOzIbP75pPlnAcNQ==') as name_on_card,
	coalesce(shipment_name,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_name,
	coalesce (shipment_address1,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address1,
	coalesce(shipment_address2,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_address2,
	coalesce (shipment_pincode,'RaZ+IaoOzIbP75pPlnAcNQ==') as shipment_pincode,
	a.pin_code,
	size,
	product
	from labmi.labmi_web_user  a
	left join waf_master.waf_cities c on a.city_id=c.city_id
	left join waf_master.waf_states s on a.state_id=s.state_id
	left join cte_tab t on a.user_guid = t.user_guid
	where (((a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time )
	      or ((Membership_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time ))
	and is_verified = 1 and  client_id = 5)
	UNION ALL
	(select * from cte_tab1))	
	order by mobile_no,email_id,Membership_date;

end if;
 
 
 
 
end;

$$;


--
