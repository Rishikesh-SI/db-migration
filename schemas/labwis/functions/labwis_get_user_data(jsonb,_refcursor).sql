-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labwis_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labwis.labwis_get_user_data
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
	v_jsondata character varying;
	v_output numeric;
	v_message character varying; 
	v_module_name character varying;

begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
--  if v_opt_type = 1 then
--     open p_user_cursor for
--     select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
--     			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
--     from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
--           		0 as comment_count
--           from labwis.labwis_web_user wu
--           where created_date between v_start_date_time and v_end_date_time
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labwis.labwis_web_user wu
--           join labwis.labwis_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id <> 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
--           		count(1) as comment_count
--           from labwis.labwis_web_user wu
--           join labwis.labwis_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id = 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labwis.labwis_web_user wu
--           join labwis.labwis_asset_comment_reaction acr
--           on acr.user_id = wu.user_id
--           where acr.reaction_date between v_start_date_time and v_end_date_time
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--          ) as tab
-- 	left join waf_master.waf_cities c
--      on c.city_id = tab.city_id
--      left join waf_master.waf_states s
--      on s.state_id = tab.state_id
--      left join waf_master.waf_countries co
--      on co.country_id = tab.country_id;
--  end if;
 
-- 	if v_opt_type = 2 then
    
--     	 open p_user_cursor for
--          	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
-- 			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
-- 			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labwis.labwis_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		and reaction_id <> 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
--       		from labwis.labwis_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--      		 and reaction_id = 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labwis.labwis_asset_comment_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		group by asset_id, asset_type_id) as tab
-- 			join labwis.labwis_asset_list al
-- 			on al.asset_id = tab.asset_id
-- 			and al.asset_type_id = tab.asset_type_id
-- 			group by al.asset_type_id, al.asset_title, al.title_alias
-- 			order by al.asset_type_id, al.asset_title;
--     end if;

if v_opt_type = 1 then

open p_user_cursor for
select * from siwaf.siwaf_client_logs order by 1 desc limit 100;

end if;

if v_opt_type = 2 then

open p_user_cursor for
select * from labwis.labwis_web_user where created_date between v_start_date_time and v_end_date_time;
end if;

if v_opt_type = 4 then
    open p_user_cursor for
    select 
        wu.email_id as Account_Email,
        wu.Mobile_no as Account_MobileNumber,
		wu.first_name as user_first_name,
		wu.last_name as user_last_name,
        g.additional_info->'user_info'->>'firstName' as Form_First_Name,
        g.additional_info->'user_info'->>'lastName' as Form_Last_Name,
        g.additional_info->'user_info'->>'email' as Form_Email,
        g.additional_info->'user_info'->>'mobileNumberWithCountryCode' as Form_MobileNumber,
        g.additional_info->>'caption_text' as Caption,
        g.additional_info->>'status' as Status,
		g.additional_info->>'photoLocation' as Photo_Location,
        g.additional_info->>'dateOfPhotoTaken' as Date_Of_PhotoTaken,
        g.additional_info->>'cameraUsed' as Camera_Used,
        'https://staging.wisden.com/static-assets/'
				 || g.gallery_path || '/' || coalesce(g.user_guid,'')|| 
				  '/'||g.is_gif_created||'/' ||g.gallery_name as Link_uploadedImage
    from 
        labwis.labwis_web_user wu
    join 
        labwis.labwis_gallery g
        on wu.user_guid = g.user_guid
    where 
        g.created_date between v_start_date_time and v_end_date_time;
end if;

----------
if v_opt_type = 5 then 
    open p_user_cursor for
	    select 
        coalesce(sum(case when g.datajson->'data'->>'message' = 'yes' then 1 else 0 end), 0)::numeric as count_of_yes,
        coalesce(sum(case when g.datajson->'data'->>'message' = 'no' then 1 else 0 end), 0)::numeric as count_of_no,
        coalesce(sum(case when g.datajson->'data'->>'message' is not null then 1 else 0 end), 0)::numeric as total_count
    from labwis.labwis_custom_web_json g
    where g.created_date between v_start_date_time and v_end_date_time
	and g.datajson->'data'->>'module'= 'ticket-purchase' ;

end if;

if v_opt_type = 6 then 
    open p_user_cursor for
    select 
        coalesce(sum(case when g.datajson->'data'->>'message' = 'yes' then 1 else 0 end), 0)::numeric as count_of_yes,
        coalesce(sum(case when g.datajson->'data'->>'message' = 'no' then 1 else 0 end), 0)::numeric as count_of_no,
        coalesce(sum(case when g.datajson->'data'->>'message' is not null then 1 else 0 end), 0)::numeric as total_count
    from labwis.labwis_custom_web_json g
    where g.created_date between v_start_date_time and v_end_date_time
	and g.datajson->'data'->>'module'= 'wisden-ticket-purchase-test' ;
end if;


 
 
--  	if v_opt_type = 3 then
--     	 	v_output := labwis.labwis_del_entity_and_content(v_jsondata::numeric);
		 
-- 		 	if(v_output = 1) then
-- 				v_message :='content has been successfully deleted';
				
-- 			elsif(v_output = -1)then
-- 				v_message :='content is not deleted';
				
-- 			elsif(v_output = 2) then
-- 				v_message := 'entity has been successfully deleted';
-- 			else 
-- 				v_message := 'entity is not deleted';
-- 			end if;
			
-- 			open p_user_cursor for
-- 				select v_message as action;
			
--  	end if;
 
end;

$$;


--
