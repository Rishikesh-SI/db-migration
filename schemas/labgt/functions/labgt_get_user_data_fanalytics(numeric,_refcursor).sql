-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_user_data_fanalytics(numeric, refcursor)
-- Type: FUNCTION

-- Name: labgt_get_user_data_fanalytics(numeric, refcursor); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_user_data_fanalytics(p_input_id numeric, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labgt.labgt_get_user_data_fanalytics(4,'a');
fetch all in "a";
*/

declare 

v_date TIMESTAMP;    
begin

/*
1 for fanalytics - all content
2 for fanalytics - all content filter by date
3 for fanalytics - all user data
4 for notification data
5 for poll and quiz data
*/

v_date := (CURRENT_TIMESTAMP - '1 day'::interval)::date;
raise notice 'v_date %',v_date;
raise notice 'current time %',current_timestamp;

if p_input_id= 1 then
    open p_user_cursor for
    select al.asset_id as content_id,CONCAT(em.canonical_url,'/',al.title_alias) as content_slug,al.asset_type_id as content_type_id,
case when al.asset_type_id=1 then 'Article'
when al.asset_type_id=2 then 'Photos'
when al.asset_type_id=4 then 'Video'
end as content_type_name,em.entity_name as category_name,em.canonical_url as category_canonical_url,tab.tagged_entity as content_entity_tags,
TO_CHAR(al.published_date,'yyyymmdd') as content_published_date,tab.player_source_object_id as players_source_object_id 
from labgt.labgt_asset_list al
join
(SELECT asset_id,asset_type_id, coalesce (string_agg(distinct((select entity_name from labgt.labgt_entity_master where entity_master_id in (select entity_master_id from labgt.labgt_entity_role_map where entity_role_map_id=tagged_entity_id::numeric) )), ','),null) as tagged_entity,
string_agg(distinct((select source_object_id from labgt.labgt_entity_role_map where entity_role_map_id=tagged_entity_id::numeric and entity_role_id=181)), ',') as player_source_object_id
            FROM labgt.labgt_asset_list al1
           LEFT JOIN LATERAL unnest(tagged_entity) AS tagged_entity_id ON TRUE
             where asset_type_id in (1,2,4)
            group by tagged_entity,asset_id,asset_type_id)tab
      on tab.asset_id=al.asset_id and tab.asset_type_id=al.asset_type_id
      
     left join labgt.labgt_entity_role_map erm on erm.entity_role_map_id=al.secondary_entity_role_map_id
     left join labgt.labgt_entity_master em on em.entity_master_id=erm.entity_master_id
     left join labgt.labgt_entity_role_map erm1 on erm1.entity_role_map_id=al.primary_entity_role_map_id
     left join labgt.labgt_entity_master em1 on em1.entity_master_id=erm1.entity_master_id
       where al.asset_type_id in (1,2,4) and al.title_alias != '' and al.is_published=1 and  
       al.is_trashed=0 and 
	   al.updated_date::date >= v_date::date and 
	 al.updated_date::date <= (current_timestamp)::date
       order by al.updated_date desc;
  

    elsif p_input_id= 3 then
    open p_user_cursor for
    select a.updated_date,first_name,last_name,email_id,user_guid,country_code,mobile_no,dob,b.name as country,city,pincode,f.entity_name as favourite_player_name,gender,
    jersey_name,jersey_number,subscribe_for_email,(case when client_id in (2,4,9) and email_id is not null then 1 
												  when client_id = 5 then email_verified end) as is_email_verified, 
	(case when first_name is not null and last_name is not null and email_id is not null then 'YES' else 'NO' end) as is_profile_complete,
	created_date as registered_date
    from labgt.labgt_web_user a
    left join waf_master.waf_players f on a.favourite_player_id=f.source_object_id
    left join waf_master.waf_countries b on a.country_id=b.country_id
    where a.updated_date::date >= v_date::date and 
	 a.updated_date::date <= (current_timestamp)::date
    order by a.created_date desc;
    
    elsif p_input_id= 4 then
        open p_user_cursor for
		select notification_json->'data'->>'android_notification_sent_count' as android_notification_sent_count,
		notification_json->'data'->>'ios_notification_sent_count' as ios_notification_sent_count, notification_id,campaign_id,asset_type as notification_type,title as notification_message,TO_CHAR(created_date,'yyyymmdd') as published_date_key --notification_json
		from siwaf.siwaf_send_notification
        where client_name in ('gt01','labgt') and
		 created_date::date >= v_date::date and 
	 	 created_date::date <= (current_timestamp)::date;

	elsif p_input_id= 5 then
    open p_user_cursor for
    	select p.poll_id,wu.user_guid,TO_CHAR(upr.response_date,'yyyymmdd') as date_key,1 as attempt_count,(case when is_quiz = 0 or is_quiz is null then 
																	(case when p.no_of_ans_allowed = upr1.cnt then 1 else 0 end) 
																   when is_quiz = 1 then -1 end)as complete_status,
		case when is_quiz = 1 then 3 else 4 end as game_id,p.no_of_ans_allowed as no_of_ans_allowed,upr1.cnt as user_voted_count,round(gaming_minutes,2) as gaming_minutes													   
		from labgt.labgt_poll p
		join (select DISTINCT(user_id),max(response_date) as response_date,sum(gaming_minutes) as gaming_minutes, poll_id 
			  from labgt.labgt_user_poll_response
			 group by user_id,poll_id)upr 
		on upr.poll_id=p.poll_id
		join labgt.labgt_web_user wu
		on wu.user_id = upr.user_id
		join (select count(user_poll_response_id) as cnt,poll_id,user_id from labgt.labgt_user_poll_response up
		-- 	  join labgt.labgt_poll po
		-- 	  on up.poll_id = p.poll_id
			 group by poll_id,user_id)upr1
		on upr1.poll_id = p.poll_id
		and upr1.user_id=wu.user_id
		where p.no_of_ans_allowed >= cnt and 
		upr.response_date::date >= v_date::date and 
	    upr.response_date::date <= (current_timestamp)::date;
    end if;

end;
$$;


--
