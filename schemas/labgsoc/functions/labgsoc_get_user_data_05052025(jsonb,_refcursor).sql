-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_user_data_05052025(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labgsoc_get_user_data_05052025(jsonb, refcursor); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_user_data_05052025(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
select * from labgsoc.labgsoc_get_user_data
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
	v_contest_id numeric;
	i record;
	v_options json;
	v_question text;
	 v_map_id numeric;
	 v_json_data jsonb;

	
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
	
	if v_opt_type = 1 then
	
 open p_user_cursor for
   select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
  a.first_name,a.last_name,a.email_id, a.dob, a.country_code,a.mobile_no,a.city,b.name as country, s.name as state, a.user_guid,a.accept_disclaimer,
  a.accept_tnc,
  case when a.marketing_consent = TRUE then 'yes' when a.marketing_consent = FALSE then 'no'
    else NULL end as marketing_consent,

  	 (select STRING_AGG(em.entity_name, ',')
       		 from labgsoc.labgsoc_entity_role_map erm
        	join labgsoc.labgsoc_entity_master em using (entity_master_id) 
      		 where erm.entity_role_id=62 and erm.source_object_id in 
      (SELECT unnest(string_to_array(a.favourite_player_id, ',')::text[]))) as favourite_athlete,
         	 (select STRING_AGG(em.entity_name, ',')
       		 from labgsoc.labgsoc_entity_role_map erm
        	join labgsoc.labgsoc_entity_master em using (entity_master_id) 
      		 where erm.entity_role_id=3 and erm.source_object_id in 
             (SELECT unnest(string_to_array(a.favourite_club, ',')::text[]))) as favourite_team
  from labgsoc.labgsoc_web_user a  
  left join waf_master.waf_countries b 
  on a.country_id=b.country_id
  left join waf_master.waf_states s
  on s.state_id = a.state_id
  where (updated_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
  order by created_date desc;

  end if;

  if v_opt_type = 2 then 

  open p_user_cursor for
   select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
  c.contest_id as contest_id ,a.first_name,a.last_name, a.email_id, a.dob, a.country_code,a.mobile_no,a.city,b.name as country, s.name as state, c.ans as answers,a.accept_disclaimer,
  a.accept_tnc, 
  case when a.marketing_consent = TRUE then 'yes' when a.marketing_consent = FALSE then 'no'
    else NULL end as marketing_consent,

  	 (select STRING_AGG(em.entity_name, ',')
       		 from labgsoc.labgsoc_entity_role_map erm
        	join labgsoc.labgsoc_entity_master em using (entity_master_id) 
      		 where erm.entity_role_id=62 and erm.source_object_id in 
      (SELECT unnest(string_to_array(a.favourite_player_id, ',')::text[]))) as favourite_athlete,
         	 (select STRING_AGG(em.entity_name, ',')
       		 from labgsoc.labgsoc_entity_role_map erm
        	join labgsoc.labgsoc_entity_master em using (entity_master_id) 
      		 where erm.entity_role_id=3 and erm.source_object_id in 
             (SELECT unnest(string_to_array(a.favourite_club, ',')::text[]))) as favourite_team
  from labgsoc.labgsoc_web_user a  
  left join waf_master.waf_countries b 
  on a.country_id=b.country_id
  left join waf_master.waf_states s
  on s.state_id = a.state_id
  left join labgsoc.labgsoc_user_contest_response c
  on c.user_id = a.user_id
  -- join labgsoc.labgsoc_contest ct
  -- on ct.contest_id = c.contest_id
  where (updated_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
  order by created_date desc;
   
   end if;

   if v_opt_type = 3 then

	
	--select p_input_json->'jsondata'->'contest_id' into v_contest_id;
	
	v_contest_id = 841 ;
   delete from labgsoc.labgsoc_contest_temp;

	
	for i in 
	select contest_option_id, option from labgsoc.labgsoc_contest_option
	where contest_id = v_contest_id
	loop

	 -- select option::jsonb->>'question' as v_question from
  --   labgsoc.labgsoc_contest_option  
  --   where contest_id = v_contest_id and option is not null;

	select options into v_options from (
	select b->>'contest_answers' as options from (
	select b
	from json_array_elements((i.option)::json->'contest_answers') b)as a )c
	where options is not null ;

	

	
	select 
	json_array_elements((i.option)::json->'questions') as v_question 
	where contest_id = v_contest_id and option is not null;
	

	

	insert into labgsoc.labgsoc_contest_temp
	select *,i.contest_option_id,v_contest_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labgsoc.labgsoc_contest_temp_1;

					
				
				    insert into labgsoc.labgsoc_contest_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||CASE  WHEN po.option::jsonb->>'is_correct_answer' = 'true' AND po.option::jsonb->>'answer_id' = pt.answer_id::text THEN 'Correct' ELSE 'Wrong' END ||')'
					from labgsoc.labgsoc_user_contest_response pr
					left join labgsoc.labgsoc_contest_temp pt on pr.contest_id = pt.contest_id 
					and pr.response_option_id = pt.contest_option_id --and pr.ans = answer_id
					left join labgsoc.labgsoc_contest_option po on pr.contest_id = po.contest_id and pr.response_option_id=po.contest_option_id
					where pr.contest_id = v_contest_id
					order by 1,2;
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from labgsoc.labgsoc_contest_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
    

    open p_user_cursor for
	select first_name,last_name,email_id,dob,a.*,tab.score
      from data1 a
	left join labgsoc.labgsoc_web_user wu on a.user_id::numeric = wu.user_id
	left join (select user_id,sum(score) as score from
					(select distinct user_id,question,
					answer_display_value,CASE 
  WHEN po.option::jsonb->>'is_correct_answer' = 'true'
       AND po.option::jsonb->>'answer_id' = pt.answer_id::text  then 1 else 0 end as score
					from labgsoc.labgsoc_user_contest_response pr
					left join labgsoc.labgsoc_contest_temp pt on pr.contest_id = pt.contest_id 
					and pr.response_option_id = pt.contest_option_id --and pr.ans=answer_id
					left join labgsoc.labgsoc_contest_option po on pr.contest_id = po.contest_id and pr.response_option_id=po.contest_option_id
					where pr.contest_id =v_contest_id
					order by 1 desc) a
					group by 1
					order by 2 desc) tab on a.user_id::numeric = tab.user_id 
	order by tab.score desc	;

	end if;

   

   
    
 /*if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labgsoc.labgsoc_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgsoc.labgsoc_web_user wu
          join labgsoc.labgsoc_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labgsoc.labgsoc_web_user wu
          join labgsoc.labgsoc_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgsoc.labgsoc_web_user wu
          join labgsoc.labgsoc_asset_comment_reaction acr
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
 end if;*/
 
-- 	if v_opt_type = 2 then
    
--     	 open p_user_cursor for
--          	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
-- 			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
-- 			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labgsoc.labgsoc_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		and reaction_id <> 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
--       		from labgsoc.labgsoc_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--      		 and reaction_id = 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labgsoc.labgsoc_asset_comment_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		group by asset_id, asset_type_id) as tab
-- 			join labgsoc.labgsoc_asset_list al
-- 			on al.asset_id = tab.asset_id
-- 			and al.asset_type_id = tab.asset_type_id
-- 			group by al.asset_type_id, al.asset_title, al.title_alias
-- 			order by al.asset_type_id, al.asset_title;
--     end if;

	-- if v_opt_type = 2 then 
 --  open p_user_cursor for
 --  select 1;
--   select em.entity_master_id,entity_role_map_id,entity_name, entity_display_name,source_object_id as source_id,canonical_url,entity_url,
-- (select count(1) from labgsoc.labgsoc_asset_list where tagged_entity @> array[erm.entity_role_map_id]::int[] and is_published=1 and asset_type_id in (1,2,4))
-- as "Content Tagged Count"
-- from labgsoc.labgsoc_entity_master em
-- join labgsoc.labgsoc_entity_role_map erm using (entity_master_id)
-- where em.is_active=1 and erm.entity_role_id=22
-- order by em.entity_master_id desc;
 -- end if;
	
 
 
 
 
end;

$_$;


--
