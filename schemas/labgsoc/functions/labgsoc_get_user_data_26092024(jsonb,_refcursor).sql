-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_user_data_26092024(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labgsoc_get_user_data_26092024(jsonb, refcursor); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_user_data_26092024(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
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
    i record;
	v_options json;
	v_question text;
    v_contest_id numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 if v_opt_type = 1 then
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
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labgsoc.labgsoc_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labgsoc.labgsoc_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labgsoc.labgsoc_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labgsoc.labgsoc_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 if v_opt_type = 3 then
 v_contest_id:=1081;
 drop table if exists labgsoc_contest_temp;
 drop table if exists labgsoc_contest_temp_1;
 drop table if exists gsoctable;
 
 create temp table labgsoc_contest_temp (answer_id numeric,
    answer_display_value text,
    contest_option_id numeric,
    contest_id numeric,
    question text);
    
  create temp table labgsoc_contest_temp_1 (user_id text,
    question text,
    answer_display_value text);

	insert into labgsoc_contest_temp
	select contest_answer_id,answer,ca.contest_option_id,co.contest_id,option::jsonb->>'question' from labgsoc.labgsoc_contest_option co
    join labgsoc.labgsoc_contest_answer ca using (contest_option_id)
	where co.contest_id = v_contest_id;
				
				    insert into labgsoc_contest_temp_1
	                (select   user_id::text,question,
					answer_display_value ||' ('||case when 1=(select 1 from labgsoc.labgsoc_contest_answer where 
                                                            contest_answer_id::text=x::text and contest_id = po.contest_id 
                                                            and contest_option_id=pr.response_option_id and is_correct_answer='true') then 'Correct' 
                                                            else 'Wrong' end ||')'
					from labgsoc.labgsoc_user_contest_response pr
					left join labgsoc_contest_temp pt on pr.contest_id = pt.contest_id 
					and pr.response_option_id = pt.contest_option_id 
					left join labgsoc.labgsoc_contest_option po on pr.contest_id = po.contest_id and pr.response_option_id=po.contest_option_id
                    ,lateral jsonb_array_elements(pr.ans) as x
					where pr.contest_id = v_contest_id and x::text=pt.answer_id::text and po.answer_type<>'Input'
                    group by 1,2,3
					order by 1,2)
                    union all
                    (select user_id::text,option::jsonb->>'question' as question,x::text as answer_display_value from
                    labgsoc.labgsoc_user_contest_response pr
                    left join labgsoc.labgsoc_contest_option po on pr.contest_id = po.contest_id 
                     and pr.response_option_id=po.contest_option_id 
                     ,lateral jsonb_array_elements(pr.ans) as x
                     where po.answer_type='Input' and pr.contest_id = v_contest_id);
	
	perform colpivot('gsoctable', $$ select user_id,question,answer_display_value from labgsoc_contest_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select first_name,last_name,email_id,d.* from gsoctable d
    left join labgsoc.labgsoc_web_user wu on wu.user_id::text=d.user_id;

 end if; 
 
 
end;

$_$;


--
